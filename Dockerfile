FROM php:8.4-fpm-alpine

WORKDIR /var/www

# Install system dependencies
RUN apk add --no-cache \
  bash \
  git \
  curl \
  nodejs \
  npm \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  zip \
  unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node dependencies
RUN npm install

# Build frontend (Wayfinder works because PHP exists)
RUN npm run build

# Fix permissions
RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]