# syntax=docker/dockerfile:1

ARG DOCKER_PHP_IMG_VER
ARG DOCKER_MYSQL_IMG_VER

FROM ${DOCKER_PHP_IMG_VER} as php-ext-installer
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

FROM ${DOCKER_PHP_IMG_VER}
ARG UID=1000
ARG GID=1000
RUN <<EOF
set -eux
addgroup -g ${GID} app
adduser -G app -u ${UID} -D -H -s /sbin/nologin -S app
EOF
RUN --mount=type=bind,from=php-extension-installer,source=/usr/local/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions <<EOF
install-php-extensions \
    opcache \
    intl \
    mbstring \
    json \
    mysqlnd \
    curl \
    imagick \
    gd \
    simplexml \
    dom \
    xdebug \
    @composer
apk del --no-cache ${PHPIZE_DEPS}
EOF
