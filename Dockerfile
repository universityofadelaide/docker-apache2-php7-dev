FROM uofa/apache2-php7:shepherd

# Add tideways repo.
RUN echo 'deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main' > /etc/apt/sources.list.d/tideways.list

# Upgrade all currently installed packages and install web server packages.
RUN apt-get update \
&& apt-get -y install php-sqlite3 php-xdebug php7.0-cli git wget sudo \
&& wget -O - https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | sudo apt-key add - \
&& apt-get -y --allow-unauthenticated install tideways-php tideways-cli \
&& sed -ri 's/^zend.assertions\s*=\s*-1/zend.assertions = 1/g' /etc/php/7.0/cli/php.ini \
&& apt-get -y autoremove && apt-get -y autoclean && apt-get clean && rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*

# Get robo.
RUN wget -O /usr/local/bin/robo https://github.com/consolidation/Robo/releases/download/1.0.4/robo.phar && chmod +x /usr/local/bin/robo

# Install Composer.
RUN wget -q https://getcomposer.org/installer -O - | php -d allow_url_fopen=On -- --install-dir=/usr/local/bin --filename=composer

COPY ./files/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
COPY ./files/tideways.ini /etc/php/7.0/mods-available/tideways.ini

# Enable xdebug.
RUN phpenmod -v ALL -s ALL xdebug
