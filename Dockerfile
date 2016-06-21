FROM uofa/docker_apache2_php7

# Upgrade all currently installed packages and install web server packages.
RUN apt-get update \
&& apt-get -y install php-xdebug php7.0-cli \
&& apt-get -y autoremove && apt-get -y autoclean && apt-get clean && rm -rf /var/lib/apt /tmp/* /var/tmp/*

COPY ./files/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

# Configure apache modules, php modules, error logging.
RUN phpenmod -v ALL -s ALL xdebug
