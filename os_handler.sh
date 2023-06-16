#!/bin/bash

AUTO="Trying"


auto_detect_os () {
    if [ -z $OS_VAR ]; then
        OS_VAR=`cat /etc/os-release | grep -w ID | cut -d "=" -f2`
        AUTO="Detected"
    fi

    if [ $OS_VAR == "alpine" ]; then 
        echo "$AUTO $OS_VAR operating system."; printf '\n'
        if handle_alpine; then success_msg; else handle_fail; fi
    elif [ $OS_VAR == "debian" ]; then
        echo "$AUTO $OS_VAR operating system."; printf '\n'
        if handle_debian; then success_msg; else handle_fail; fi
    else 
        echo 'OS auto-detection unsuccessful. Switching to manual input.'; printf '\n'
        handle_os_input
    fi
}


handle_os_input () {

    printf '\n'; echo 'Please select OS:'; echo '----------------'; printf '\n' 
    echo '1) alpine' ; echo '2) debian'; printf '\n'; read -p 'Enter: ' OS_VAR

    if [ $OS_VAR == 1 ]; then
        if handle_alpine; then success_msg; else handle_fail; fi
    elif [ $OS_VAR == 2 ]; then
        if handle_debian; then success_msg; else handle_fail; fi
    else
        printf '\n'; echo "EXITING: Run again and select 1 or 2."; printf '\n'; exit
    fi

    printf '\n'

}

handle_alpine () {

    apk update && apk add jq ruby pip #npm yarn pip

}

handle_debian () {

    apt-get update -y && apt install jq ruby pip -y #npm yarn pip

}

success_msg () {

    printf '\n'; echo "Packages installed successfully."

}

handle_fail () {

    printf '\n'; echo "Packages failed to install. Please manually install npm, jq, and yarn or try different operating system."; exit

}