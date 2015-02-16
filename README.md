# Supported tags and respective `Dockerfile` links

-      [`latest` (*Dockerfile*)](https://github.com/estebanmatias92/docker-nginx/blob/master/Dockerfile)

# What contains this image?

-      [Official Docker nginx image](https://registry.hub.docker.com/_/nginx)
-      [Dockerize](https://github.com/jwilder/dockerize)

# How to use this image

## Traditional way

       docker run -d estebanmatias92/nginx

With this, you have a nginx server that runs on port 80 from the container ip.

## Dockerize way

With Dockerize you can redirect logs to Docker log collector and  easily manage any configuration at runtime through templates and environment variables.

Before start to using it, i recommend you to read the [Jason Wilder’s post](http://jasonwilder.com/blog/2014/10/13/a-simple-way-to-dockerize-applications) for a more in-depth explanation about this tool.

       FROM estebanmatias92/nginx
       COPY ./config/nginx.conf /etc/nginx/
       COPY ./config/default.tmpl /var/www/config/
       RUN mkdir -p /etc/nginx/sites-enabled/
       ENTRYPOINT [“dockerize”, “-template”, “/var/www/config/default.tmpl:/etc/nginx/sites-enabled/default”, “-stdout”, “/var/log/nginx/access.log”, “-stderr”, “/var/log/nginx/error.log”, “/usr/sbin/nginx”]
       CMD ["-g", "daemon off;"]

If the template that you copied had some placeholder to replace, you can make usage of it:

       docker build --force-rm -t my-nginx-image .
       docker run -d --link=”php-container:php” -e FASTCGI_ADDRESS=php:9000 my-nginx-image

And you have a nginx server linked with a php server from another container.

In the example above i assume that you made a placeholder for “fastcgi_pass” option (fastcgi_pass={{ .Env.FASTCGI_ADDRESS }}), but you can create this way whatever environment variable that you want.

# License

View [license information](https://github.com/nginx/nginx/blob/master/LICENSE) for nginx.

View [license information](https://github.com/jwilder/dockerize#license) for dockerize.

# User Feedback

## Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/estebanmatias92/docker-nginx/issues).

## Contributing

Every contribution are welcome.
