FROM php:7.4-cli
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions \
		@composer \
		apcu \
		ast \
		bcmath \
		gd \
		imagick \
		imap \
		intl \
		ldap \
		opcache \
		redis \
		pdo_mysql \
		smbclient \
		ssh2 \
		xdebug \
		zip
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
		&& apt-get install -yq \
		smbclient \
		ldap-utils \
		redis-tools \
		mariadb-client-core-10.5 \
		&& rm -rf /var/lib/apt/lists/*
COPY --from=node:16-bullseye-slim /usr/local/bin/node /usr/local/bin/node
COPY --from=node:16-bullseye-slim /usr/local/lib/ /usr/local/lib/
COPY --from=node:16-bullseye-slim /opt/ /opt/
WORKDIR /usr/local/bin
RUN ln -s ../lib/node_modules/corepack/dist/corepack.js corepack \
		&& ln -s /usr/local/bin/node nodejs \
		&& ln -s ../lib/node_modules/npm/bin/npm-cli.js npm \
		&& ln -s ../lib/node_modules/npm/bin/npx-cli.js npx \
		&& ln -s /opt/yarn-v1.22.19/bin/yarn yarn \
		&& ln -s /opt/yarn-v1.22.19/bin/yarnpkg yarnpkg
RUN useradd owncloud
USER owncloud
WORKDIR /home/owncloud
EXPOSE 8000
CMD ["php", "-S","0.0.0.0:8000"]