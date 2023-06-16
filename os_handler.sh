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
    set_install
    apk update && apk add jq ruby pip #npm yarn pip

}

handle_debian () {
    set_install
    apt-get update -y && apt install jq ruby pip -y #npm yarn pip

}

success_msg () {

    printf '\n'; echo "Packages installed successfully."

}

handle_fail () {

    printf '\n'; echo "Packages failed to install. Please manually install npm, jq, and yarn or try different operating system."; exit

}

set_install () {
        jq --version &>/dev/null; if [ $? == 0 ]; then JQ_INSTALLED="y" && echo "Yarn detected."; else JQ_INSTALLED="n"; fi
        ruby --version &>/dev/null; if [ $? == 0 ]; then RUBY_INSTALLED="y" && echo "Yarn detected."; else RUBY_INSTALLED="n"; fi
        pip --version -v &>/dev/null; if [ $? == 0 ]; then PIP_INSTALLED="y" && echo "Yarn detected."; else PIP_INSTALLED="n"; fi
}

clean () {
    if [ $OS_VAR == 1 ] || [ $OS_VAR == "alpine" ]; then
        if [ $JQ_INSTALLED == "y" ]; then
            apk delete jq
        fi
        if [ $RUBY_INSTALLED == "y" ]; then
            apk delete ruby
        fi
        if [ $PIP_INSTALLED == "y" ]; then
            apk delete pip
        fi

        return 1
    fi

    if [ $OS_VAR == 2 ] || [ $OS_VAR == "debian" ]; then
        if [ $JQ_INSTALLED == "y" ]; then
            apt remove jq
        fi
        if [ $RUBY_INSTALLED == "y" ]; then
            apt remove ruby
        fi
        if [ $PIP_INSTALLED == "y" ]; then
            apt remove pip
        fi
    fi
}