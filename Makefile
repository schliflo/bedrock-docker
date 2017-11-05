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

destroy:
	docker-compose down --rmi all --remove-orphans

restart: stop start

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
