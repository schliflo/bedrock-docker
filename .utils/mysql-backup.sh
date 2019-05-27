#!/usr/bin/env bash
if [ -f "./backup/mysql.sql.gz" ]; then
    bash ./.utils/message.sh warning "Attention!"
    echo "Existing backup file found: backup/mysql.sql.gz"
    echo ""
    read -e -p "Do you want to override the backup file? [N/y]: " backupOK
    [ -z "${backupOK}" ] && backupOK="N"
else
    backupOK="Yes"
fi
if [ "$backupOK" = "Yes" ] || [ "$backupOK" = "yes" ] || [ "$backupOK" = "Y" ] || [ "$backupOK" = "y" ]; then
    bash ./.utils/message.sh info "Creating a backup of your database in backup/mysql.sql.gz"
    mkdir -p backup
    docker exec -i $(docker-compose ps -q db) mysqldump -u root -ppassword --opt --single-transaction --events --databases wp --routines --comments | gzip > "backup/mysql.sql.gz"
    bash ./.utils/message.sh success "Backup successful!"
fi
