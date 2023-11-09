#  node
FROM node:18 as node

WORKDIR /var/www
COPY . .
CMD ["bash", "./docker/entrypointNode.sh"]
# ==============================================================================

FROM php:8.2 as php

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    git \
    curl \
    ca-certificates gnupg \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip \
    nodejs \
    npm && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring exif pcntl bcmath gd xml iconv pgsql pdo pdo_pgsql


WORKDIR /var/www
COPY . .

COPY --from=composer:2.6.5 /usr/bin/composer /usr/bin/composer

ENV PORT=8000
CMD [ "bash", "./docker/entrypoint.sh" ]
