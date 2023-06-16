#!/bin/bash

handle_app_name () {
    if [ -z $APP_NAME ]; then 
        printf '\n'; read -p 'Enter app name (anything you want): ' APP_NAME; 
    else
        printf '\n'; echo "APP_NAME has been set in env variables."; printf '\n';
    fi
}