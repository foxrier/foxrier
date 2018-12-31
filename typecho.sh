#!/bin/bash

cd /root/

wget http://typecho.org/downloads/1.1-17.10.30-release.tar.gz

wget https://blog.foxrier.org/usr/uploads/2018/12/161806927.conf

wget https://blog.foxrier.org/usr/uploads/2018/12/3299154192.ini

mv /root/161806927.conf /root/www.conf

mv /root/3299154192.ini /root/php.ini

chown root:root www.conf

chown root:root php.ini

tar -zxvf 1.1-17.10.30-release.tar.gz

zypper install -y nginx mariadb php7 php7-fpm php7-gd php7-mysql php7-curl \
       php7-mbstring php7-iconv 

mkdir /usr/share/nginx/typecho

rsync -avP build/ /usr/share/nginx/typecho/

chown -R nginx:nginx /usr/share/nginx/typecho

cp /root/php.ini /etc/php7/fpm/

cp /etc/php7/fpm/php-fpm.conf.default /etc/php7/fpm/php-fpm.conf

cp /root/www.conf /etc/php7/fpm/php-fpm.d/

mkdir /var/lib/php7/session

chown nginx:nginx /var/lib/php7/session

systemctl start nginx mariadb php-fpm

systemctl enable nginx mariadb php-fpm

firewall-cmd --add-service=http --permanent

firewall-cmd --add-service=https --permanent

firewall-cmd --reload
