FROM webdevops/php:alpine-php7

RUN apk add --no-cache musl-dev go
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mail:1025' > /opt/docker/etc/php/php.ini
