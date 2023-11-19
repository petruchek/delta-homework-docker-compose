FROM php:apache

# Set the working directory
WORKDIR /var/www/html

# Install dependencies and PHP extension
RUN apt-get update \
    && apt-get install -y less unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install mysqli \
    && a2enmod rewrite

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy the setup script, wait-for-it script, and entrypoint script
COPY wp-setup.sh /usr/local/bin/
COPY wait-for-it.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

# Make the scripts executable
RUN chmod +x /usr/local/bin/wp-setup.sh /usr/local/bin/wait-for-it.sh /usr/local/bin/docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
