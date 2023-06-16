#!/bin/bash

handle_os_input () {

    echo 'Please select OS:'
    echo '----------------'
    printf '\n' 
    echo '1) alpine' 
    echo '2) debian' 
    printf '\n'
    read -p 'Enter: ' os_var
    if [ $os_var == 1 ]; then
        if handle_alpine; then success_msg; else handle_fail; fi
    elif [ $os_var == 2 ]; then
        if handle_debian; then success_msg; else handle_fail; fi
    else
        echo "Please select 1 or 2"; exit
    fi
    printf '\n'

}

handle_alpine () {

    apk update && apk add jq npm yarn

}
handle_debian () {

    apt-get update -y && apt install jq npm yarn -y

}

success_msg () {
    echo "Packages installed successfully."
}

handle_fail () {
    echo "Packages failed to install. Please manually install npm, jq, and yarn."
    exit
}