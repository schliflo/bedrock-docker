#!/usr/bin/env bash
# CHECK WORDPRESS
if $(docker-compose run -T test curl -L http://$PROJECT_NAME.docker/ | grep "WordPress" | grep -q "Installation"); then
    bash ./.utils/message.sh success "check for WordPress OK";
else
    bash ./.utils/message.sh warning "Test failed!";
    bash ./.utils/message.sh info "Expected fo find WordPress Installation page at http://$PROJECT_NAME.docker/";
    exit 1;
fi

# CHECK PHPMYADMIN
if $(docker-compose run -T test curl -L http://phpmyadmin.$PROJECT_NAME.docker/ | grep -q "phpMyAdmin"); then
    bash ./.utils/message.sh success "check for phpMyAdmin OK";
else
    bash ./.utils/message.sh warning "Test failed!";
    bash ./.utils/message.sh info "Expected fo find phpMyAdmin Instance at http://$PROJECT_NAME.bedrock.docker/";
    exit 1;
fi

# CHECK MAILHOG
if $(docker-compose run -T test curl -L http://mail.$PROJECT_NAME.docker:8025/ | grep -q "MailHog"); then
    bash ./.utils/message.sh success "check for MailHog OK";
else
    bash ./.utils/message.sh warning "Test failed!";
    bash ./.utils/message.sh info "Expected fo find MailHog Instance http://mail.$PROJECT_NAME.docker:8025/";
    exit 1;
fi
