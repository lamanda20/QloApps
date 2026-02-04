FROM php:8.2-apache

# Modules Apache utiles
RUN a2enmod rewrite headers

# Dépendances + extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev zip unzip \
    libxml2-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mysqli gd soap xml dom zip \
    && rm -rf /var/lib/apt/lists/*

# Réglages PHP proches des recommandations
RUN { \
  echo "memory_limit=128M"; \
  echo "upload_max_filesize=16M"; \
  echo "post_max_size=16M"; \
  echo "max_execution_time=500"; \
} > /usr/local/etc/php/conf.d/qloapps.ini

WORKDIR /var/www/html
