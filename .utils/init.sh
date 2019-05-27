#!/usr/bin/env bash
bash ./.utils/message.sh headline "This script will help you get started with your development setup"
if [ -d "app" ]; then
    # app directory exists; asking user for permission to delete
    bash ./.utils/message.sh warning "Attention!"
    echo "It looks like you already have an app directory."
    echo "This script is intended to help with initial setup."
    echo "It will delete your current app folder which can lead to loss of data."
    echo ""
    read -e -p "Do you want to remove the app folder and start from scratch? [N/y]: " initOK
    [ -z "${initOK}" ] && initOK="N"
else
    initOK="Yes"
fi
if [ "$initOK" = "Yes" ] || [ "$initOK" = "yes" ] || [ "$initOK" = "Y" ] || [ "$initOK" = "y" ]; then
    rm -rf app
    echo ""
    read -e -p "Provide your own Bedrock repo or press enter to create a fresh instance: " repo
    [ -z "${repo}" ] && repo="false"
    if [ "$repo" = "false" ]; then
        bash ./.utils/message.sh info "Creating new Bedrock instance via composer."
        bash ./.utils/message.sh info "This can take a while..."
        make composer create-project roots/bedrock .
    else
        bash ./.utils/message.sh info "Cloning your repo..."
        git clone $repo app
        bash ./.utils/message.sh info "Installing composer dependencies..."
        make composer install
    fi
    bash ./.utils/message.sh info "Starting your project..."
fi
