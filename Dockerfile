FROM uofa/apache2-php7:shepherd

# Upgrade all currently installed packages and install web server packages.
RUN apt-get update \
&& apt-get -y install php-sqlite3 php-xdebug php7.1-cli git wget sudo \
&& sed -ri 's/^zend.assertions\s*=\s*-1/zend.assertions = 1/g' /etc/php/7.1/cli/php.ini \
&& sed -i 's/^\(allow_url_fopen\s*=\s*\).*$/\1on/g' /etc/php/7.1/mods-available/php_custom.ini \
&& apt-get -y autoremove && apt-get -y autoclean && apt-get clean && rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*

# Get robo.
RUN wget -O /usr/local/bin/robo https://github.com/consolidation/Robo/releases/download/1.1.4/robo.phar && chmod +x /usr/local/bin/robo

# Install Composer.
RUN wget -q https://getcomposer.org/installer -O - | php -d allow_url_fopen=On -- --install-dir=/usr/local/bin --filename=composer

# Configure additional PHP modules.
COPY ./files/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini

# Enable xdebug.
RUN phpenmod -v ALL -s ALL xdebug
