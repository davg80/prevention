#!/bin/bash

#if [ ! -f "vendor/autoload.php" ]; then
    composer install --ignore-platform-req=ext-http --no-interaction #S--no-progress 
#fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exists."
fi

role=${CONTAINER_ROLE:-app}

ls -lah 

#if [ "$role" = "app" ]; then
    php artisan key:generate
    php artisan migrate
    php artisan create:all
    # php artisan cache:clear
    # php artisan config:clear
    # php artisan route:clear
    php artisan serve --port=$PORT --host=0.0.0.0 --env=.env
    # exec docker-php-entrypoint "$@"
#fi

