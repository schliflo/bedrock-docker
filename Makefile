ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

#############################
# ENVIRONMENT
#############################

export PROJECT_NAME=bedrock
export COMPOSE_PROJECT_NAME=${PROJECT_NAME}


#############################
# INITIALIZATION
#############################

init:
	bash ./.utils/init.sh


#############################
# CONTAINER ACCESS
#############################

up:
	bash ./.utils/header.sh
	echo ""
	bash ./.utils/message.sh info "Starting your project"
	docker-compose up -d
	make urls

stop:
	bash ./.utils/message.sh info "Stopping your project"
	docker-compose stop

destroy: stop
	bash ./.utils/message.sh info "Deleting all containers"
	docker-compose down --rmi all --remove-orphans

update:
	bash ./.utils/message.sh info "Updating your project"
	docker-compose pull
	docker-compose build --pull
	make composer update
	make up

restart: stop up

rebuild: destroy update


#############################
# UTILS
#############################

mysql-backup:
	bash ./.utils/message.sh info "Creating a backup of your database in ./backup/mysql.sql.bz2"
	mkdir -p backup
	docker exec -i $$(docker-compose ps -q db) mysqldump -u root -ppassword --opt --single-transaction --events --all-databases --routines --comments | bzip2 > "backup/mysql.sql.bz2"

mysql-restore:
	bash ./.utils/message.sh info "Restoring ./backup/mysql.sql.bz2"
	[ -f backup/mysql.sql.bz2 ]
	bzcat "backup/mysql.sql.bz2" | docker exec -i $$(docker-compose ps -q db) mysql -u root -ppassword
	echo "FLUSH PRIVILEGES;" | docker exec -i $$(docker-compose ps -q db) mysql -u root -ppassword

composer:
	mkdir -p app
	sleep 1
	docker run --rm --interactive --tty --volume $$PWD/app:/app --volume $$COMPOSER_HOME:/tmp --user $$(id -u):$$(id -g) composer $(ARGS)


#############################
# CONTAINER ACCESS
#############################

ssh:
	docker exec -it $$(docker-compose ps -q $(ARGS)) sh


#############################
# INFORMATION
#############################

urls:
	bash ./.utils/message.sh headline "You can access your project at the following URLS:"
	bash ./.utils/message.sh link "Backend:     http://${PROJECT_NAME}.docker/wp/wp-admin/"
	bash ./.utils/message.sh link "Frontend:    http://${PROJECT_NAME}.docker/"
	bash ./.utils/message.sh link "Mailhog:     http://mail.${PROJECT_NAME}.docker/"
	bash ./.utils/message.sh link "PHPMyAdmin:  http://phpmyadmin.${PROJECT_NAME}.docker/"
	echo ""

state:
	docker-compose ps

logs:
	docker-compose logs -f --tail=50 $(ARGS)


#############################
# Argument fix workaround
#############################
%:
	@:
