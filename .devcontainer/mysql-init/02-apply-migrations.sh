#!/bin/bash
# Apply migrations in version order

echo "Setting global sql_mode..."
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SET GLOBAL sql_mode='';"

echo "Applying migrations from /docker-migrations/..."
if [ -d "/docker-migrations" ]; then
    # find all .sql files, sort them using version sort (-V), and apply them
    # We use -maxdepth 1 to avoid subdirectories
    # We use --force to continue even if some statements fail (e.g., if already applied)
    find /docker-migrations -maxdepth 1 -name "*.sql" | sort -V | while read f; do
        echo "Applying $f..."
        mysql -u root -p${MYSQL_ROOT_PASSWORD} --force ${MYSQL_DATABASE} < "$f"
    done
fi
