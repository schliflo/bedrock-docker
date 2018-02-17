FROM amd64/nginx:alpine

RUN apk add --no-cache nano curl
ADD ./etc/nginx/* /etc/nginx/
ADD ./etc/nginx/h5bp/location/* /etc/nginx/h5bp/location/
ADD ./etc/nginx/h5bp/directive-only/* /etc/nginx/h5bp/directive-only/
