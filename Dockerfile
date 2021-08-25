FROM debian:buster-slim
MAINTAINER Alex Tatulchenkov
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade > /dev/null && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install > /dev/null nginx procps && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/www/* && \
    mkdir -p /var/www/company.com/img

COPY index.html /var/www/company.com/index.html
COPY patrik.jpg /var/www/company.com/img/patrik.jpg
RUN chmod -R 0754 /var/www/company.com && \
    useradd alex && \
    groupadd tatulchenkov && \
    usermod -aG tatulchenkov alex && \
    chown -R alex:tatulchenkov /var/www/company.com && \
    sed -i 's/\/var\/www\/html/\/var\/www\/company.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user alex/g' /etc/nginx/nginx.conf

EXPOSE 80/tcp
CMD ["nginx", "-g", "daemon off;"]
