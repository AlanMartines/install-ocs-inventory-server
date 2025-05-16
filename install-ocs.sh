#!/bin/bash

echo "==== OCS Inventory Installer para Debian/Ubuntu ===="
echo ""

# Escolher versão do PHP
read -p "Escolha a versão do PHP que deseja instalar [7.4 / 8.0 / 8.1 / 8.2 / 8.3]: " phpver

# Validar versão
case "$phpver" in
  7.4|8.0|8.1|8.2|8.3) echo "Selecionado: PHP $phpver";;
  *) echo "❌ Versão inválida."; exit 1;;
esac

echo ""
echo "== Atualizando sistema =="
sudo apt update && sudo apt -y full-upgrade

echo ""
echo "== Instalando dependências base =="
sudo apt -y install vim git make cmake gcc build-essential graphicsmagick libgraphicsmagick1-dev \
software-properties-common ca-certificates lsb-release apt-transport-https curl libapache2-mod-perl2 \
libapache-dbi-perl libapache-db-perl bzip2 curl mycli wget ntp libarchive-tools

# Repositório PHP (sury.org)
if [[ $(lsb_release -is) == "Ubuntu" ]]; then
    echo "== Adicionando repositório PPA PHP para Ubuntu =="
    sudo add-apt-repository ppa:ondrej/php -y
else
    echo "== Adicionando repositório PHP para Debian =="
    sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
fi

sudo apt update

echo ""
echo "== Instalando PHP $phpver e extensões =="
sudo apt -y install apache2 libapache2-mod-fcgid php$phpver libapache2-mod-php$phpver \
php$phpver-cli php$phpver-common php$phpver-curl php$phpver-gd php$phpver-mbstring \
php$phpver-xml php$phpver-bcmath php$phpver-bz2 php$phpver-intl php$phpver-mysql \
php$phpver-soap php$phpver-zip php$phpver-fpm php-imagick php-pear php-xmlrpc \
php$phpver-dev php$phpver-imap php$phpver-opcache php$phpver-ldap php$phpver-snmp \
php$phpver-pgsql php$phpver-apcu php-ssh2 php$phpver-oauth

echo ""
echo "== Alternando para PHP $phpver no Apache =="
for v in 7.4 8.0 8.1 8.2 8.3; do
    if [ "$v" != "$phpver" ]; then sudo a2dismod php$v; fi
done
sudo a2enmod php$phpver
sudo update-alternatives --set php /usr/bin/php$phpver
sudo update-alternatives --set phar /usr/bin/phar$phpver
sudo update-alternatives --set phar.phar /usr/bin/phar.phar$phpver
sudo systemctl restart apache2

echo ""
echo "== Instalando MySQL =="
wget https://repo.mysql.com/mysql-apt-config_0.8.29-1_all.deb
sudo apt install ./mysql-apt-config_0.8.29-1_all.deb -y
sudo dpkg-reconfigure mysql-apt-config
sudo apt update
sudo apt install mysql-server -y

echo ""
echo "== Configuração segura do MySQL =="
sudo mysql_secure_installation

echo ""
echo "== Criando banco de dados 'ocsdb' e usuário 'ocsuser' =="
mysql -u root -p <<EOF
CREATE DATABASE ocsdb;
GRANT ALL PRIVILEGES ON ocsdb.* TO 'ocsuser'@'localhost' IDENTIFIED BY 'ocspassword';
FLUSH PRIVILEGES;
EOF

echo ""
echo "== Baixando e instalando OCS Inventory Server =="
wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/2.12.3/OCSNG_UNIX_SERVER-2.12.3.tar.gz
tar xvf OCSNG_UNIX_SERVER-2.12.3.tar.gz
cd OCSNG_UNIX_SERVER-2.12.3
sudo ./setup.sh

echo ""
echo "== Ativando configurações no Apache =="
sudo a2enconf ocsinventory-reports.conf
sudo a2enconf z-ocsinventory-server.conf
sudo a2enconf zz-ocsinventory-restapi.conf
sudo systemctl restart apache2

echo ""
echo "== Ajustando permissões da pasta reports =="
sudo chown -R www-data:www-data /var/lib/ocsinventory-reports/
sudo systemctl enable apache2

echo ""
echo "✅ Instalação concluída! Acesse http://<IP_DO_SERVIDOR>/ocsreports"
