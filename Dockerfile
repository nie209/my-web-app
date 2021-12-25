FROM ubuntu:18.04

RUN apt-get update

RUN apt-get -y install nginx git curl

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get install -y nodejs

WORKDIR /app

copy . .

RUN npm install -g @quasar/cli

RUN npm install

Run quasar build

# Copy the respective nginx configuration files
#COPY nginx_config/nginx.conf /etc/nginx/nginx.conf

COPY nginx_conf/default /etc/nginx/sites-available/default

WORKDIR /var/www/html

RUN cp -r /app/dist/spa/* .

RUN rm -rf /app


EXPOSE 80

EXPOSE 443

EXPOSE 4000

CMD ["nginx", "-g", "daemon off;"]
