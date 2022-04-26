sleep 30
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo apt install php-fpm php-mysql -y
sudo mkdir /var/www/wordpress
