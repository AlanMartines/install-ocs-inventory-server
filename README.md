# Install OCS Inventory Server on Debian/Ubuntu

https://nksistemas.com/instalar-ocs-inventory-en-debian-10/

https://pmorenoit.blog/2022/06/05/instalacion-de-ocs-inventory-server-2-9-2-en-ubuntu-22-04/

https://www.cyberciti.biz/faq/linux-apache2-change-default-port-ipbinding/

https://tecadmin.net/switch-between-multiple-php-version-on-debian/

## Instalando Dependencias Necessárias

### Ubuntu
```sh
apt install sudo -y
sudo apt -y install software-properties-common
apt install sudo vim -y
sudo apt update && sudo apt -y full-upgrade
sudo add-apt-repository ppa:ondrej/php
curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x
sudo apt update 
```
### Debian
```sh
sudo apt update
sudo apt -y install lsb-release apt-transport-https ca-certificates 
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update
```

```sh
sudo apt -y install vim git make cmake gcc build-essential apache2 libapache2-mod-perl2 libapache-dbi-perl libapache-db-perl libapache2-mod-php php php-zip php-pclzip php-gd php-mysql php-soap php-curl php-json php-xml php-mbstring perl libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libnet-ip-perl libsoap-lite-perl libio-compress-perl libapache2-mod-perl2-dev libarchive-zip-perl libmojolicious-perl libplack-perl libswitch-perl php7.4 php7.4-pgsql php7.4-cli php7.4-common libapache2-mod-php7.4 php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-bz2 php7.4-intl php-bcmath php-fpm php-pear php7.4-fpm php-cli php-xmlrpc php7.4-common php7.4-mysql php7.4-xmlrpc php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl php7.4-imagick php-ssh2 graphicsmagick gcc libgraphicsmagick1-dev php-pear software-properties-common ca-certificates lsb-release apt-transport-https curl


sudo apt install -y php8.2 libapache2-mod-php8.2 php8.2-mysql php8.2-common php8.2-curl php8.2-xml php8.2-mbstring php8.2-gettext php8.2-pdo php8.2-gd php8.2-zip php8.2-soap php8.2-xmlrpc php8.2-intl php8.2-mysqlnd php8.2-cli php8.2-dev php8.2-zip libapache2-mod-php8.2 php8.2-curl php8.2-bz2 php-pear


sudo cpan install XML::Entities Apache2::SOAP Net::IP Apache::DBI Mojolicious Switch Plack::Handler Archive::Zip
```
# Instalar MySQL

https://www.edivaldobrito.com.br/mysql-no-debian-e-sistemas-derivados/

## mysql_secure_installation

![image](https://user-images.githubusercontent.com/10979090/208107935-70eadcf0-aa37-47ad-87a7-d43bee8a39d1.png)

## Criando o banco de dados ocs no MySQL
```sh
mysql -u root -p

CREATE DATABASE ocsdb;

GRANT ALL PRIVILEGES ON ocsdb.* TO 'ocsuser'@'localhost' IDENTIFIED BY 'ocspassword';

FLUSH PRIVILEGES;

QUIT;
```
![image](https://user-images.githubusercontent.com/10979090/208531417-a62e7a78-8426-4b8d-bda1-4fddd92034d7.png)


## Ajustes no php.ini
```sh
# Para PHP 7.4
vim /etc/php/7.4/apache2/php.ini 
vim /etc/php/7.4/cli/php.ini

# Parâmetros a serem alterados
short_open_tag ==> On    linea +/- 187
post_max_size ==> 1024M  linea +/- 694
upload_max_filesize ==> 256M linea +/- 846
```

## Baixar e instalar OCS
```sh
wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/2.11.1/OCSNG_UNIX_SERVER-2.11.1.tar.gz

tar xvf OCSNG_UNIX_SERVER-2.11.1.tar.gz

cd OCSNG_UNIX_SERVER-2.11.1

sudo ./setup.sh
```

## Criando Links Simbólicos para o Apache
```sh
a2enconf ocsinventory-reports.conf

a2enconf z-ocsinventory-server.conf

a2enconf zz-ocsinventory-restapi.conf
```
## Ajustes no OCS
```sh
vim vim /etc/apache2/conf-enabled/zz-ocsinventory-restapi.conf

# Parâmetros a serem alterados
OCS_DB_LOCAL ==> database_name	line +/- 9
OCS_DB_USER ==>  database_user	line +/- 10
OCS_DB_PWD ==>   database_pwd   line +/- 11



vim /etc/apache2/conf-enabled/z-ocsinventory-server.conf

# Parâmetros a serem alterados
OCS_DB_NAME ==>  database_name  line +/- 26 
OCS_DB_LOCAL ==> database_name	line +/- 27
OCS_DB_USER ==>  database_user	line +/- 29
OCS_DB_PWD ==>   database_pwd   line +/- 31
```

## Ajustando dono da pasta reports
```sh
chown -R www-data:www-data /var/lib/ocsinventory-reports/

systemctl restart apache2
```
