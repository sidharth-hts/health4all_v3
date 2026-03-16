#!/bin/bash
set -e

echo "Setting global sql_mode..."
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SET GLOBAL sql_mode='';"

echo "Applying migrations..."
# Use version sort to handle 1.0.2.sql before 1.0.10.sql
for f in $(ls -1 -v /docker-migrations/*.sql); do
    echo "Applying $f..."
    mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < "$f"
done
