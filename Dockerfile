FROM nginx

MAINTAINER "Matias Esteban" <estebanmatias92@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install "dockerize"
# More about it on https://github.com/jwilder/dockerize
RUN buildDeps=' \
        wget \
    ' \
    && apt-get update -y \
    && apt-get install -y $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && wget --no-check-certificate -O /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz \
    && tar -C /usr/local/bin -xvzf /tmp/dockerize.tar.gz \
    && rm /tmp/dockerize.tar.gz \
    && apt-get purge --auto-remove -y $buildDeps

# Prepare nginx config directories
RUN mkdir -p /etc/nginx/sites-available/

# Run always in foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ENTRYPOINT ["/usr/sbin/nginx"]
