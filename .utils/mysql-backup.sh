#!/usr/bin/env bash
if [ -f "./backup/mysql.sql.bz2" ]; then
    bash ./.utils/message.sh warning "Attention!"
    echo "Existing backup file found: backup/mysql.sql.bz2"
    echo ""
    read -e -p "Do you want to override the backup file? [N/y]: " backupOK
    [ -z "${backupOK}" ] && backupOK="N"
else
    backupOK="Yes"
fi
if [ "$backupOK" = "Yes" ] || [ "$backupOK" = "yes" ] || [ "$backupOK" = "y" ] || [ "$backupOK" = "y" ]; then
    bash ./.utils/message.sh info "Creating a backup of your database in backup/mysql.sql.bz2"
    mkdir -p backup
    docker exec -i $(docker-compose ps -q db) mysqldump -u root -ppassword --opt --single-transaction --events --all-databases --routines --comments | bzip2 > "backup/mysql.sql.bz2"
    bash ./.utils/message.sh success "Backup successful!"
fi
