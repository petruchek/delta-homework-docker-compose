# Wordpress in a Docker Homework

This project intentionally uses php:apache image instead of wordpress

Everything is configurable via `.env`:

Mysql configuration:
- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD

Wordpress configuration:
- WP_URL
- WP_TITLE
- WP_ADMIN_USER
- WP_ADMIN_EMAIL
- WP_ADMIN_PASSWORD

If no wordpress provided in `code` volume, the latest English version will be downloaded and installed on the first run.
Configuration will use the values from ENV