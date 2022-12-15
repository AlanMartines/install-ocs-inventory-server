# install-ocs-inventory-server-on-debian
Install OCS Inventory Server on Debian

https://wiki.projetoroot.com.br/index.php/Ocs_Inventory_2.9

https://computingforgeeks.com/how-to-install-ocs-inventory-server-on-debian-linux/


https://computingforgeeks.com/how-to-install-ocs-inventory-server-on-debian-linux/


https://www.gnulinuxbrasil.com.br/?p=3402


https://nksistemas.com/instalar-ocs-inventory-en-debian-10/


```sh
apt install sudo -y

sudo apt update && sudo apt -y full-upgrade

sudo apt -y install mariadb-server mariadb-client git make cmake gcc build-essential apache2 libapache2-mod-perl2 libapache-dbi-perl libapache-db-perl libapache2-mod-php php php-zip php-pclzip php-gd php-mysql php-soap php-curl php-json php-xml php-mbstring perl libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libnet-ip-perl libsoap-lite-perl libio-compress-perl libapache2-mod-perl2-dev libarchive-zip-perl libmojolicious-perl libplack-perl libswitch-perl php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php-xmlrpc 

sudo cpan install XML::Entities Apache2::SOAP Net::IP Apache::DBI Mojolicious Switch Plack::Handler Archive::Zip

mysql -u root -p

CREATE DATABASE ocs;

GRANT ALL PRIVILEGES ON ocs.* TO ocs@localhost IDENTIFIED BY "StrongDBPassword";

FLUSH PRIVILEGES;

QUIT;
```
