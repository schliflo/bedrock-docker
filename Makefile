#############################
# ENVIRONMENT
#############################

export COMPOSE_PROJECT_NAME=wp-bedrock-docker


#############################
# CONTAINER ACCESS
#############################

up:
	docker-compose up -d

start:
	docker-compose start

stop:
	docker-compose stop

destroy: stop
	docker-compose down --rmi all --remove-orphans

update:
	docker-compose pull

restart: stop start

rebuild: destroy update up


#############################
# BACKUP/RESTORE
#############################

mysql-backup:
	docker exec -i $$(docker-compose ps -q db) mysqldump -u root -ppassword --opt --single-transaction --events --all-databases --routines --comments | bzip2 > "backup/mysql.sql.bz2"

mysql-restore:
	bzcat "backup/mysql.sql.bz2" | docker exec -i $$(docker-compose ps -q db) mysql -u root -ppassword
	echo "FLUSH PRIVILEGES;" | docker exec -i $$(docker-compose ps -q db) mysql -u root -ppassword


#############################
# CONTAINER ACCESS
#############################

ssh-app:
	docker exec -it $$(docker-compose ps -q app) sh

ssh-web:
	docker exec -it $$(docker-compose ps -q web) sh

ssh-db:
	docker exec -it $$(docker-compose ps -q db) sh

ssh-memcached:
	docker exec -it $$(docker-compose ps -q memcached) sh


#############################
# INFORMATION
#############################

state:
	docker-compose ps

logs:
	docker-compose logs -f --tail=50 $(ARGS)
