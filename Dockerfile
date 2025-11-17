# Imagen base oficial con Apache + PHP 8.2
FROM php:8.2-apache
 
# Habilitar mod_rewrite
RUN a2enmod rewrite
 
# Configurar AllowOverride para permitir .htaccess
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
 
# Copiar el código de la aplicación al DocumentRoot
COPY . /var/www/html/
 
# Dar permisos correctos
RUN chown -R www-data:www-data /var/www/html
 
EXPOSE 80
 
CMD ["apache2-foreground"]

