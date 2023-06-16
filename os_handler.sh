#!/bin/bash


auto_detect_os () {
    os_var=`cat /etc/os-release | grep -w ID | cut -d "=" -f2`

    if [ $os_var == "alpine" ]; then 
        echo "Detected alpine operating system."
        if handle_alpine; then success_msg; else handle_fail; fi
    elif [ $os_var == "debian" ]; then
        echo "Detected debian operating system."
        if handle_debian; then success_msg; else handle_fail; fi
    else 
        echo 'OS auto-detection unsuccessful. Switching to manual input.'
        handle_os_input
    fi
}


handle_os_input () {

    printf '\n'; echo 'Please select OS:'; echo '----------------'; printf '\n' 
    echo '1) alpine' ; echo '2) debian'; printf '\n'; read -p 'Enter: ' os_var

    if [ $os_var == 1 ]; then
        if handle_alpine; then success_msg; else handle_fail; fi
    elif [ $os_var == 2 ]; then
        if handle_debian; then success_msg; else handle_fail; fi
    else
        printf '\n'; echo "EXITING: Run again and select 1 or 2."; printf '\n'; exit
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

    echo "Packages failed to install. Please manually install npm, jq, and yarn."; exit

}