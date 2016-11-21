FROM uofa/apache2-php7

# Upgrade all currently installed packages and install web server packages.
RUN apt update \
&& apt-get -y install php-sqlite3 php-xdebug php7.0-cli git wget sudo \
&& sed -ri 's/^zend.assertions\s*=\s*-1/zend.assertions = 1/g' /etc/php/7.0/cli/php.ini \
&& apt-get -y autoremove && apt-get -y autoclean && apt-get clean && rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*

# Get robo.
RUN wget -O /usr/local/bin/robo https://github.com/consolidation/Robo/releases/download/1.0.4/robo.phar && chmod +x /usr/local/bin/robo

# Install Composer.
RUN wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./files/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

# Configure apache modules, php modules, error logging.
RUN phpenmod -v ALL -s ALL xdebug
