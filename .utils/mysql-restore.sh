#!/usr/bin/env bash
if [ -f "./backup/mysql.sql.bz2" ]; then
    bash ./.utils/message.sh info "Restoring ./backup/mysql.sql.bz2"
    bzcat "backup/mysql.sql.bz2" | docker exec -i $(docker-compose ps -q db) mysql -u root -ppassword wp
    echo "FLUSH PRIVILEGES;" | docker exec -i $(docker-compose ps -q db) mysql -u root -ppassword
    bash ./.utils/message.sh success "Restore successful!"
else
    bash ./.utils/message.sh info "No backup found: backup/mysql.sql.bz2"
fi
