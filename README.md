# Install OCS Inventory Server on Debian/Ubuntu

https://nksistemas.com/instalar-ocs-inventory-en-debian-10/

https://pmorenoit.blog/2022/06/05/instalacion-de-ocs-inventory-server-2-9-2-en-ubuntu-22-04/

https://www.cyberciti.biz/faq/linux-apache2-change-default-port-ipbinding/

https://tecadmin.net/switch-between-multiple-php-version-on-debian/

https://www.edivaldobrito.com.br/mysql-no-debian-e-sistemas-derivados/

## Instalando Dependencias Necessárias

```sh
sudo apt -y install vim git make cmake gcc build-essential graphicsmagick libgraphicsmagick1-dev \
software-properties-common ca-certificates lsb-release apt-transport-https curl libapache2-mod-perl2 \
libapache-dbi-perl libapache-db-perl bzip2 curl mycli wget ntp libarchive-tools;
```

### Ubuntu
```sh
sudo apt update;
sudo apt -y install software-properties-common;
sudo apt update && sudo apt -y full-upgrade;
sudo add-apt-repository ppa:ondrej/php;
curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x;
sudo apt update;
```

### Debian
```sh
sudo apt update;
sudo apt -y install lsb-release apt-transport-https ca-certificates;
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list;
sudo apt update;
```

---

### 🔢 **Versões Estáveis do PHP desde 7.4**

| Versão  | Data de Lançamento | Status                      | Requisitos mínimos                              |
| ------- | ------------------ | --------------------------- | ----------------------------------------------- |
| **7.4** | 28 de nov. de 2019 | **EOL** (nov/2022)          | Última com suporte ao PHP 7                     |
| **8.0** | 26 de nov. de 2020 | **EOL** (nov/2023)          | Requer PHP >=7.4 para upgrade                   |
| **8.1** | 25 de nov. de 2021 | **Manutenção até nov/2024** | Muitas libs modernas exigem                     |
| **8.2** | 8 de dez. de 2022  | **Ativa**                   | Recomendada em muitos projetos                  |
| **8.3** | 23 de nov. de 2023 | **Mais recente estável**    | Versão mais atual, compatível com libs modernas |

---

### 📌 Recomendações:

* ✅ **PHP 8.3** – mais recente, com melhorias de performance e segurança.
* ✅ **PHP 8.2** – ótima estabilidade e suporte de pacotes.
* ⚠️ **PHP 8.1** – ainda estável, mas já entra em manutenção (fim: nov/2024).
* ❌ **PHP 8.0 e 7.4** – **não recomendadas**, pois estão fora do suporte oficial.

---

### Instalar PHP 7.4
```sh
sudo apt -y install apache2 libapache2-mod-fcgid php7.4 libapache2-mod-php php-zip php-pclzip php-gd php-mysql php-soap php-curl php-json php-pear \
php-xml php-mbstring perl libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libnet-ip-perl \
libsoap-lite-perl libio-compress-perl libapache2-mod-perl2-dev libarchive-zip-perl libmojolicious-perl \
libplack-perl libswitch-perl php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-bz2 \
php7.4-intl php-fpm php7.4-fpm php-cli php-xmlrpc php7.4-common php7.4-mysql php-imagick php7.4-dev php7.4-imap \
php7.4-opcache php7.4-soap php7.4-zip php7.4-intl php-ssh2 php7.4-oauth php7.4-mcrypt libapache2-mod-php7.4 \
php7.4-apcu php7.4-ldap php7.4-snmp php7.4-pgsql php8.4-sockets;
```

### Instalar PHP 8.3
```sh
sudo apt -y install apache2 libapache2-mod-fcgid php8.3 libapache2-mod-php php-zip php-pclzip php-gd php-mysql php-soap php-curl php-json php-pear \
php-xml php-mbstring perl libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libnet-ip-perl \
libsoap-lite-perl libio-compress-perl libapache2-mod-perl2-dev libarchive-zip-perl libmojolicious-perl \
libplack-perl libswitch-perl php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php8.3-bcmath php8.3-bz2 \
php8.3-intl php-fpm php8.3-fpm php-cli php-xmlrpc php8.3-common php8.3-mysql php-imagick php8.3-dev php8.3-imap \
php8.3-opcache php8.3-soap php8.3-zip php8.3-intl php-ssh2 php8.3-oauth php8.3-mcrypt libapache2-mod-php8.3 \
php8.3-apcu php8.3-ldap php8.3-snmp php8.3-pgsql php8.3-sockets;
```

### Instalar PHP 8.4
```sh
sudo apt -y install apache2 libapache2-mod-fcgid php8.4 libapache2-mod-php php-zip php-pclzip php-gd php-mysql php-soap php-curl php-json php-pear \
php-xml php-mbstring perl libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libnet-ip-perl \
libsoap-lite-perl libio-compress-perl libapache2-mod-perl2-dev libarchive-zip-perl libmojolicious-perl \
libplack-perl libswitch-perl php8.4-curl php8.4-gd php8.4-mbstring php8.4-xml php8.4-bcmath php8.4-bz2 \
php8.4-intl php-fpm php8.4-fpm php-cli php-xmlrpc php8.4-common php8.4-mysql php-imagick php8.4-dev php8.4-imap \
php8.4-opcache php8.4-soap php8.4-zip php8.4-intl php-ssh2 php8.4-oauth php8.4-mcrypt libapache2-mod-php8.4 \
php8.4-apcu php8.4-ldap php8.4-snmp php8.4-pgsql php8.4-sockets;
```

```sh
sudo a2enmod proxy_fcgi setenvif rewrite;
sudo systemctl restart apache2;
sudo cpan install XML::Entities Apache2::SOAP Net::IP Apache::DBI Mojolicious Switch Plack::Handler Archive::Zip;
```

---

### Instalar MySQL
```sh
sudo apt update;
sudo apt upgrade -y;
wget https://repo.mysql.com//mysql-apt-config_0.8.29-1_all.deb;
sudo apt install ./mysql-apt-config_0.8.29-1_all.deb -y;
sudo dpkg-reconfigure mysql-apt-config;
sudo apt update;
sudo apt install mysql-server;
```

### Instalação segura do Mysql

```sh
mysql_secure_installation
```

![image](https://user-images.githubusercontent.com/10979090/208107935-70eadcf0-aa37-47ad-87a7-d43bee8a39d1.png)

### Criando o banco de dados ocs no MySQL
```sh
mysql -u root -p
CREATE DATABASE ocsdb;
GRANT ALL PRIVILEGES ON ocsdb.* TO 'ocsuser'@'localhost' IDENTIFIED BY 'ocspassword';
FLUSH PRIVILEGES;
QUIT;
```
![image](https://user-images.githubusercontent.com/10979090/208531417-a62e7a78-8426-4b8d-bda1-4fddd92034d7.png)

---

### Ajustes no php.ini
```
# Parâmetros a serem alterados
short_open_tag ==> On    linea +/- 187
post_max_size ==> 1024M  linea +/- 694
upload_max_filesize ==> 256M linea +/- 846
```

### PHP 7.4
```sh
# /etc/php/7.4/apache2/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 600/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 600/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/7.4/apache2/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/7.4/apache2/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/7.4/apache2/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_7.4_apache2.log|' /etc/php/7.4/apache2/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.4/apache2/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/7.4/apache2/php.ini

# /etc/php/7.4/cli/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/7.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/7.4/cli/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/7.4/cli/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/7.4/cli/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_7.4_cli.log|' /etc/php/7.4/cli/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.4/cli/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/7.4/cli/php.ini

# /etc/php/7.4/fpm/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/7.4/fpm/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/7.4/fpm/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/7.4/fpm/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_7.4_fpm.log|' /etc/php/7.4/fpm/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.4/fpm/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/7.4/fpm/php.ini

```

### PHP 8.3
```sh
# /etc/php/8.3/apache2/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/8.3/apache2/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/8.3/apache2/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/8.3/apache2/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_8.3_apache2.log|' /etc/php/8.3/apache2/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/8.3/apache2/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/8.3/apache2/php.ini

# /etc/php/8.3/cli/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/8.3/cli/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/8.3/cli/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/8.3/cli/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/8.3/cli/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_8.3_cli.log|' /etc/php/8.3/cli/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/8.3/cli/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/8.3/cli/php.ini

# /etc/php/8.3/fpm/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/8.3/fpm/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/8.3/fpm/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/8.3/fpm/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_8.3_fpm.log|' /etc/php/8.3/fpm/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/8.3/fpm/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/8.3/fpm/php.ini

```

### PHP 8.4
```sh
# /etc/php/8.4/apache2/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/8.4/apache2/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/8.4/apache2/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/8.4/apache2/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_8.4_apache2.log|' /etc/php/8.4/apache2/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/8.4/apache2/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/8.4/apache2/php.ini

# /etc/php/8.4/cli/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/8.4/cli/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/8.4/cli/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/8.4/cli/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/8.4/cli/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_8.4_cli.log|' /etc/php/8.4/cli/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/8.4/cli/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/8.4/cli/php.ini

# /etc/php/8.4/fpm/php.ini
sed -i 's/^\s*short_open_tag\s*=.*/short_open_tag = On/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*post_max_size\s*=.*/post_max_size = 1024M/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*upload_max_filesize\s*=.*/upload_max_filesize = 256M/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*max_execution_time\s*=.*/max_execution_time = 300/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*max_input_time\s*=.*/max_input_time = 300/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*session.cookie_httponly\s*=.*/session.cookie_httponly = on/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pgsql/extension=pgsql/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pdo_pgsql/extension=pdo_pgsql/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=pdo_mysql/extension=pdo_mysql/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=mysqli/extension=mysqli/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=soap/extension=soap/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^\s*;\s*extension=sockets/extension=sockets/' /etc/php/8.4/fpm/php.ini;
sed -i 's/^;\?\s*display_errors\s*=.*/display_errors = On/' /etc/php/8.4/fpm/php.ini
sed -i 's/^;\?\s*log_errors\s*=.*/log_errors = On/' /etc/php/8.4/fpm/php.ini
sed -i 's|^;\?\s*error_log\s*=.*|error_log = /var/log/php_errors_8.4_fpm.log|' /etc/php/8.4/fpm/php.ini
sed -i 's/^;\?\s*error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/8.4/fpm/php.ini
sed -i 's/^\s*allow_url_fopen\s*=.*/allow_url_fopen = On/' /etc/php/8.4/fpm/php.ini

```

```sh
systemctl restart apache2;
systemctl restart php7.4-fpm;
systemctl restart php8.0-fpm;
systemctl restart php8.1-fpm;
systemctl restart php8.2-fpm;
systemctl restart php8.3-fpm;
systemctl restart php8.4-fpm;
```

---

### Alterar a verção no PHP
#### Alternar para o PHP 7.4:
```sh
sudo a2dismod php8.0
sudo a2dismod php8.1
sudo a2dismod php8.2
sudo a2dismod php8.3
sudo a2dismod php8.4
sudo a2enmod php7.4
sudo update-alternatives --set php /usr/bin/php7.4
sudo update-alternatives --set phar /usr/bin/phar7.4
sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.4
sudo systemctl restart apache2
```
#### Alternar para o PHP 8.0:
```sh
sudo a2dismod php7.4
sudo a2dismod php8.1
sudo a2dismod php8.2
sudo a2dismod php8.3
sudo a2dismod php8.4
sudo a2enmod php8.0
sudo update-alternatives --set php /usr/bin/php8.0
sudo update-alternatives --set phar /usr/bin/phar8.0
sudo update-alternatives --set phar.phar /usr/bin/phar.phar8.0
sudo systemctl restart apache2
```
#### Alternar para o PHP 8.1:
```sh
sudo a2dismod php7.4
sudo a2dismod php8.0
sudo a2dismod php8.2
sudo a2dismod php8.3
sudo a2dismod php8.4
sudo a2enmod php8.1
sudo update-alternatives --set php /usr/bin/php8.1
sudo update-alternatives --set phar /usr/bin/phar8.1
sudo update-alternatives --set phar.phar /usr/bin/phar.phar8.1
sudo systemctl restart apache2
```
#### Alternar para o PHP 8.2:
```sh
sudo a2dismod php7.4
sudo a2dismod php8.0
sudo a2dismod php8.1
sudo a2dismod php8.3
sudo a2dismod php8.4
sudo a2enmod php8.2
sudo update-alternatives --set php /usr/bin/php8.2
sudo update-alternatives --set phar /usr/bin/phar8.2
sudo update-alternatives --set phar.phar /usr/bin/phar.phar8.2
sudo systemctl restart apache2
```
#### Alternar para o PHP 8.3:
```sh
sudo a2dismod php7.4
sudo a2dismod php8.0
sudo a2dismod php8.1
sudo a2dismod php8.2
sudo a2dismod php8.4
sudo a2enmod php8.3
sudo update-alternatives --set php /usr/bin/php8.3
sudo update-alternatives --set phar /usr/bin/phar8.3
sudo update-alternatives --set phar.phar /usr/bin/phar.phar8.3
sudo systemctl restart apache2
```
#### Alternar para o PHP 8.4:
```sh
sudo a2dismod php7.4
sudo a2dismod php8.0
sudo a2dismod php8.1
sudo a2dismod php8.2
sudo a2dismod php8.3
sudo a2enmod php8.4
sudo update-alternatives --set php /usr/bin/php8.3
sudo update-alternatives --set phar /usr/bin/phar8.3
sudo update-alternatives --set phar.phar /usr/bin/phar.phar8.3
sudo systemctl restart apache2
```
```sh
php -v;
```
---

### Baixar e instalar OCS
```sh
wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/2.12.3/OCSNG_UNIX_SERVER-2.12.3.tar.gz

tar xvf OCSNG_UNIX_SERVER-2.12.3.tar.gz

cd OCSNG_UNIX_SERVER-2.12.3

sudo ./setup.sh
```

### Criando Links Simbólicos para o Apache
```sh
a2enconf ocsinventory-reports.conf

a2enconf z-ocsinventory-server.conf

a2enconf zz-ocsinventory-restapi.conf
```

### Ajustes no OCS
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
---

### Ajustando dono da pasta reports
```sh
chown -R www-data:www-data /var/lib/ocsinventory-reports/;
systemctl restart apache2;
systemctl enable apache2;
```
