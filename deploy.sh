sudo apt update -y
sudo apt upgrade -y
sudo apt install -y ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install php8.0 -y
apt install php8.0-{bcmath,bz2,gd,intl,mcrypt,mbstring,mysql,xml,xmlrpc,zip} -y
sudo apt install php8.0-fpm -y
apt-get install php8.0-mysql -y
systemctl stop apache2

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

apt install mysql-server -y
mysql -h localhost -u root -proot -e "CREATE USER 'crmdev'@'localhost' IDENTIFIED BY 'e72f4545eb68c96c754f91fc01573517';"
mysql -h localhost -u root -proot -e "GRANT ALL PRIVILEGES ON * . * TO 'crmdev'@'localhost';"
mysql -h localhost -u root -proot -e "FLUSH PRIVILEGES;"
mysql -h localhost -u root -proot -e "CREATE DATABASE crmdev;"

sudo apt update -y
sudo apt install nginx -y
systemctl start nginx


curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update -y
sudo apt-get install redis -y


sudo apt-get install curl gnupg apt-transport-https -y
curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null
curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null

sudo apt-get update -y

sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

sudo apt-get install rabbitmq-server -y --fix-missing


sudo apt install npm -y
sudo apt-get install -y build-essential libssl-dev
#curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh
sudo apt-get install -y libpng-dev


sudo apt-get update

source ~/.profile

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
sudo apt-get update
nvm install 14.17.0
nvm use 14.17.0


mv ~/deploy/backend /etc/nginx/sites-enabled/backend
mv ~/deploy/frontend /etc/nginx/sites-enabled/frontend
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
systemctl restart nginx

cd /var/www
rm -rf html
mv ~/deploy/id_rsa /root/.ssh/id_rsa
mv ~/deploy/id_rsa.pub /root/.ssh/id_rsa.pub
chmod 400 ~/.ssh/id_rsa

git clone git@github.com:vaaxooo/crm-backend.git backend
mv /root/deploy/.env_backend /var/www/backend/.env
cd backend
composer install --ignore-platform-reqs
php artisan migrate
php artisan db:seed
php artisan storage:link
php artisan optimize
chmod -R 777 storage
cd ..

git clone git@github.com:Mykhailov777/crm-frontend.git frontend
mv /root/deploy/.env_frontend /var/www/frontend/.env
cd /var/www/frontend
npm install
npm rebuild node-sass
npm install -g pm2

cd /root
rm -rf deploy