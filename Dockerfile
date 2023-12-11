# small is beautiful
FROM alpine:3.14

LABEL maintainer="Nico Duldhardt <nico@duldhardt.com>"

# The container listens on port 80, map as needed
EXPOSE 80

# This is where the repositories will be stored
VOLUME ["/git"]

# Install required packages
RUN apk add --no-cache nginx git git-daemon fcgiwrap spawn-fcgi

COPY nginx.conf /etc/nginx/nginx.conf

# launch fcgiwrap via spawn-fcgi and run nginx in the foreground
CMD spawn-fcgi -s /run/fcgi.sock -U nginx /usr/bin/fcgiwrap && \
    nginx -g "daemon off;"
