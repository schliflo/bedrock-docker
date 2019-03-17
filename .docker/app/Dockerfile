FROM webdevops/php-dev:alpine-php7

# configure postfix to use mailhog
RUN apk add --no-cache nano curl
RUN postconf -e "relayhost = mail:1025"

# install wp cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/
