#Install OCS Inventory Server on Debian/Ubuntu

https://nksistemas.com/instalar-ocs-inventory-en-debian-10/

https://pmorenoit.blog/2022/06/05/instalacion-de-ocs-inventory-server-2-9-2-en-ubuntu-22-04/

## Instalando Dependencias Necessárias
```sh
apt install sudo -y

sudo apt update && sudo apt -y full-upgrade

sudo apt -y install mariadb-server mariadb-client git make cmake gcc build-essential apache2 libapache2-mod-perl2 libapache-dbi-perl libapache-db-perl libapache2-mod-php php php-zip php-pclzip php-gd php-mysql php-soap php-curl php-json php-xml php-mbstring perl libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libnet-ip-perl libsoap-lite-perl libio-compress-perl libapache2-mod-perl2-dev libarchive-zip-perl libmojolicious-perl libplack-perl libswitch-perl php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php-xmlrpc 

sudo cpan install XML::Entities Apache2::SOAP Net::IP Apache::DBI Mojolicious Switch Plack::Handler Archive::Zip
```

## Criando o banco de dados ocs no MySQL
```sh
mysql -u root -p

CREATE DATABASE ocsdb;

GRANT ALL PRIVILEGES ON ocsdb.* TO 'ocsuser'@'localhost' IDENTIFIED BY 'ocspassword';

FLUSH PRIVILEGES;

QUIT;
```

## Baixar e instalar OCS
```sh
wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/2.11.1/OCSNG_UNIX_SERVER-2.11.1.tar.gz

tar xvf OCSNG_UNIX_SERVER-2.11.1.tar.gz

cd OCSNG_UNIX_SERVER-2.11.1

sudo ./setup.sh
```

## Ajustes no php.ini
```sh
# Para PHP 7.4
vim /etc/php/7.4/apache2/php.ini

# Parâmetros a serem alterados
max_execution_time = 200
max_input_time = 200
memory_limit = 512M
post_max_size = 128M
upload_max_filesize = 128M
```
## Criando Links Simbólicos para o Apache
```sh
ln -s /etc/apache2/conf-available/ocsinventory-reports.conf /etc/apache2/conf-enabled/ocsinventory-reports.conf

ln -s /etc/apache2/conf-available/z-ocsinventory-server.conf /etc/apache2/conf-enabled/z-ocsinventory-server.conf

systemctl restart apache2
```

## Ajustando parâmetros do OCS
```sh
vim /etc/apache2/conf-available/z-ocsinventory-server.conf

# Parâmetros a serem alterados
OCS_DB_NAME ocsdb
OCS_DB_LOCAL ocsdb
OCS_DB_USER ocsdb
OCS_DB_PWD ocspassword

sudo rm -fr /usr/share/ocsinventory-reports/ocsreports/install.php
```

## Ajustando dono da pasta reports para Debian 11
```sh
chown -R www-data:www-data /var/lib/ocsinventory-reports/
```
