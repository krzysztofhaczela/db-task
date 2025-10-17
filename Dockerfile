FROM php:8.4-fpm-alpine AS base

RUN apk add --no-cache \
    nginx \
    supervisor \
    postgresql-dev \
    libzip-dev \
    oniguruma-dev \
    libxml2-dev \
    curl \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql zip mbstring exif pcntl bcmath opcache

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN mkdir -p /var/log/supervisor

# Create database directory and file with proper permissions
RUN mkdir -p /var/www/html/database && \
    touch /var/www/html/database/database.sqlite && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache && \
    chmod 664 /var/www/html/database/database.sqlite && \
    chmod 775 /var/www/html/database

# for testing purposes; in production, use real env vars
COPY .env.example .env

COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["/var/www/html/start.sh"]
