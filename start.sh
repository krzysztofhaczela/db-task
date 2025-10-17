#!/bin/sh

# Run migrations
php artisan migrate --force

# Start supervisor (which manages nginx and php-fpm)
/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
