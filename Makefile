ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

#############################
# ENVIRONMENT
#############################

export PROJECT_NAME=bedrock
export DB_PREFIX=wp_
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
	[ -d "app" ] || make init
	bash ./.utils/message.sh info "Starting your project..."
	make check-proxy
	docker-compose up -d
	make urls

stop:
	bash ./.utils/message.sh info "Stopping your project..."
	docker-compose stop

destroy: stop
	bash ./.utils/message.sh info "Deleting all containers..."
	docker-compose down --rmi all --remove-orphans

upgrade:
	bash ./.utils/message.sh info "Upgrading your project..."
	docker-compose pull
	docker-compose build --pull
	make composer update
	make up

restart: stop up

rebuild: destroy upgrade


#############################
# UTILS
#############################

mysql-backup:
	bash ./.utils/mysql-backup.sh

mysql-restore:
	bash ./.utils/mysql-restore.sh

composer:
	mkdir -p app
	sleep 1
	bash ./.utils/composer.sh $(ARGS)

ci-test:
	bash ./.utils/ci/test.sh


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

check-proxy:
	bash ./.utils/check-proxy.sh

#############################
# Argument fix workaround
#############################
%:
	@:
