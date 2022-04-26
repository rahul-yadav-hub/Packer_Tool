sudo mv /tmp/wordpress-nginx-conf /etc/nginx/sites-available/wordpress-nginx-conf
sudo ln -s /etc/nginx/sites-available/wordpress-nginx-conf /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
sudo apt update
sudo apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
sudo systemctl restart php7.4-fpm