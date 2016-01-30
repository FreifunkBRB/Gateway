# Freifunk Gateway Brandenburg an der Havel

Das Projekt ist aktuell noch im Aufbau. Das Puppet Skript folgt der Anleitung von Freifunk Stuttgart (https://wiki.freifunk-stuttgart.net/technik:gateways:gateway-einrichten).

Zum Starten das Repository auschecken, Virtualbox und Vagrant sowie das vbguest plugin installieren. Danach dann einfach die Vagrant VM hochfahren.

sudo apt-get update
sudo apt-get install virtualbox vagrant
vagrant plugin install vagrant-vbguest
vagrant up

Wichtig:

Die Konfigurationsdateien sind noch nicht angepasst und das Projekt ist noch im Aufbau. Für den Produktiveinsatz ist der aktuelle Stand noch absolut nicht geeignet.
