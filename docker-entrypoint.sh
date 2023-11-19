#!/bin/bash
set -e

# Function to wait for MySQL to be ready
wait_for_mysql() {
    echo "Waiting for MySQL to be ready..."
    /usr/local/bin/wait-for-it.sh -t 0 mysql:3306 -- echo "MySQL is ready!"
}

# Run the wait_for_mysql function
wait_for_mysql

# Run the wp-setup.sh script
/usr/local/bin/wp-setup.sh

# Start Apache
apache2-foreground
