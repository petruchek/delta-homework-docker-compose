#!/bin/bash

if [[ -z "$(ls -A /var/www/html)" ]]; then
    echo "Setting up WordPress..."
    wp core download --allow-root
    echo -e '<IfModule mod_rewrite.c>\nRewriteEngine On\nRewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]\nRewriteBase /\nRewriteRule ^index\.php$ - [L]\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule . /index.php [L]\n</IfModule>' > /var/www/html/.htaccess
    wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost=mysql --allow-root
    wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
    wp user update 1 --user_pass="${WP_ADMIN_PASSWORD}" --allow-root
    wp rewrite structure '/%postname%/' --hard --allow-root
    wp rewrite flush --hard --allow-root
    echo "WordPress setup completed."
else
    echo "WordPress is already set up."
fi
