
class batman{

    include apt

    package { "software-properties-common":
        ensure          => present
    }

    apt::ppa { 'ppa:freifunk-mwu/freifunk-ppa': 
        require         => Package['software-properties-common']
    }

    apt::ppa { "ppa:cz.nic-labs/bird":
        require         => Apt::Ppa['ppa:freifunk-mwu/freifunk-ppa']
    }

    apt::source { "adv":
        location        => "http://repo.universe-factory.net/debian/",
        release         => "sid",
        repos           => " main",
        require         => Apt::Ppa['ppa:cz.nic-labs/bird']
    }

    apt::key { "adv-key":
        id              => 16EF3F64CB201D9C,
        server          => 'keyserver.ubuntu.com',
        require         => Apt::Source['adv']
    }

    exec {"apt-update":
        command         => '/usr/bin/apt-get update',
        require         => Apt::Key['adv-key']
    }

    exec {"apt-upgrade":
        command         => '/usr/bin/apt-get upgrade',
        require         => Exec['apt-update']
    }

    package { "bind9":
        ensure          => purged,
        require         => Exec['apt-upgrade']
    }

    $packages = [
        'dnsmasq', 
        'build-essential', 
        'bridge-utils',
        'git',
        'batctl', 
        'fastd',
        'batman-adv-dkms', 
        'alfred',
        'openvpn', 
        'tinc', 
        'vnstat', 
        'vnstati'
    ]

    package { $packages:
        ensure          => present,
        require         => Exec['apt-upgrade']
    }

    exec {"install-additions":
        command => '/usr/bin/apt-get install -y batadv-vis alfred-json',
        require => Package[
        'dnsmasq', 
        'build-essential', 
        'bridge-utils',
        'git',
        'batctl', 
        'fastd',
        'batman-adv-dkms', 
        'alfred',
        'openvpn', 
        'tinc', 
        'vnstat', 
        'vnstati'
    ]
    }

    file { '/etc/sysctl.conf':
        ensure          => 'present',
        content         => "net.ipv4.ip_forward=1 net.ipv6.conf.all.forwarding = 1"
    }

    exec { "sysctl":
      command           => "/sbin/sysctl -p",
      refreshonly       => true,
      subscribe         => File["/etc/sysctl.conf"],
   }
}

include batman
