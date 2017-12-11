# Bedrock Docker
Easy-to-use [Docker](https://www.docker.com/) setup for local development of [Bedrock](https://github.com/roots/bedrock) based [Wordpress](https://wordpress.org/) projects

*please note that this is intended for local development - deploying it to production is probably a bad idea*

## Features
- Automated setup of new and existing [Bedrock](https://github.com/roots/bedrock) projects
- Minimal configuration needed: Enter your project's name and you're good to go
- Backup/Restore routines for the database
- [MailHog](https://github.com/mailhog/MailHog): Catch all outgoing mail for easy mail debugging
- [phpMyAdmin](https://github.com/phpmyadmin/phpmyadmin): Direct database access

[![Screenshot showing Bedrock Docker in action](https://user-images.githubusercontent.com/9881672/33634343-21380236-da14-11e7-8322-8896341115c9.png "Screenshot")](https://user-images.githubusercontent.com/9881672/33634343-21380236-da14-11e7-8322-8896341115c9.png)
## Requirements

### macOS
- Have `docker-compose` and [dinghy](https://github.com/codekitchen/dinghy) installed & running

### Linux
- `docker` & `docker-compose`
- Some sort of reverse proxy container like [nginx-proxy](https://github.com/jwilder/nginx-proxy) used by [dinghy](https://github.com/codekitchen/dinghy) 

## Usage

### First time setup
1. `git clone https://github.com/schliflo/bedrock-docker.git your-project`
1. `cd your-project`
1. Adjust `PROJECT_NAME=bedrock` in the Makefile to your projects name (use [kebap-case](https://stackoverflow.com/questions/11273282/whats-the-name-for-hyphen-separated-case/12273101#12273101) as this is also used for your local development domain)
1. Run `make up` and follow the instructions
1. Your new project should start and you should be greeted with the local URLs where you can access it

### Starting, stopping etc...
Run `make up` to start everything

Run `make stop` to stop everything

Run `make restart` to - you probably guessed it - restart everything

Run `make rebuild` to rebuild the project from the ground (current database will be lost if not backed up)

### Using composer
Bedrock Docker abstracts composer into a container. You can use `make composer` like you would use `composer` standalone:

    # install a wordpress plugin:
    make composer require wpackagist-plugin/wp-mail-smtp
    
    # update wordpress & plugins:
    make composer update


### Backup a database
Run `make mysql-backup` creates a compressed backup of your database in the backup folder. If you need a more fine grained backup you can use phpMyAdmin

### Restoring a database
Use phpMyAdmin to restore the database or use `make mysql-restore` if you created a backup previously

### Updating the project & development containers
Run `make update`

### Logging & information
Run `make logs` or `make logs app` for just the logs of all or specific containers

Run `make state` to see the current state of your containers

Run `make urls` to see the URLs of the project

### Accessing containers
Run `make ssh app` or `make logs web` to access the specific containers

### Deleting the containers
Run `make destroy`

## Need help or missing a feature?
Open an issue over [here](https://github.com/schliflo/bedrock-docker/issues)

Feedback is generally appreciated ;)
