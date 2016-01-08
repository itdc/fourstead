# Clear The Old Environment Variables

sed -i '/# Set Fourstead Environment Variable/,+1d' /home/vagrant/.profile
sed -i '/env\[.*/,+1d' /etc/php/7.0/fpm/php-fpm.conf
