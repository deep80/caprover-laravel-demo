FROM wyveo/nginx-php-fpm:php81

RUN apt-get update && \
    apt install -y nodejs && \
    apt install -y npm

WORKDIR /var/www/html

COPY ./.docker/default.conf /etc/nginx/conf.d

COPY . .

RUN cp .env.example .env

RUN composer install --optimize-autoloader --no-dev

RUN npm install && \
    npm run prod && \
    rm -rf node_modules

EXPOSE 80