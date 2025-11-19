# Imagen base oficial con Apache + PHP 8.2
FROM php:8.2-apache
 
# Habilitar mod_rewrite
RUN a2enmod rewrite
 

# Configurar AllowOverride para permitir .htaccess en /var/www/html
RUN printf "\n<Directory /var/www/html>\n    AllowOverride All\n</Directory>\n" >> /etc/apache2/apache2.conf

 
RUN docker-php-ext-install pdo pdo_mysql

# Copiar el código de la aplicación al DocumentRoot
COPY . /var/www/html/

RUN if [ -f /var/www/html/htaccess ]; then mv /var/www/html/htaccess /var/www/html/.htaccess; fi
 
# Dar permisos correctos
RUN chown -R www-data:www-data /var/www/html
 
EXPOSE 80
 
CMD ["apache2-foreground"]

