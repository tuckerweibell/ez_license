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
    apk update && apk add jq ruby
    check_lock
    if ! [ -z $NPM_INSTALL ]; then
        if [ $NPM_INSTALL == "y" ]; then apk add npm; NPM_INSTALLED="y"; NPM="y"; else NPM_INSTALLED="n"; fi
    fi
    if ! [ -z $YARN_INSTALL ]; then
        if [ $YARN_INSTALL == "y" ]; then apk add yarn; YARN_INSTALLED="y" YARN="y"; else YARN_INSTALLED="n"; fi
    fi
}

handle_debian () {
    set_install
    apt-get update -y && apt install jq ruby -y
    check_lock
    if ! [ -z $NPM_INSTALL ]; then
        if [ $NPM_INSTALL == "y" ]; then apt install npm -y; NPM_INSTALLED="y"; NPM="y"; else NPM_INSTALLED="n"; fi
    fi
    if ! [ -z $YARN_INSTALL ]; then
        if [ $YARN_INSTALL == "y" ]; then apt install yarn -y; YARN_INSTALLED="y"; YARN="y"; else YARN_INSTALLED="n"; fi
    fi
}

success_msg () {

    printf '\n'; echo "Packages installed successfully."

}

handle_fail () {

    printf '\n'; echo "Packages failed to install. Please manually install npm, jq, and yarn or try different operating system."; exit

}

set_install () {
        jq --version &>/dev/null; if [ $? -ne 0 ]; then JQ_INSTALLED="y" && echo "jq will be installed."; else JQ_INSTALLED="n"; fi
        ruby --version &>/dev/null; if [ $? -ne 0 ]; then RUBY_INSTALLED="y" && echo "ruby will be installed."; else RUBY_INSTALLED="n"; fi
}

check_lock () {
    if [ $NPM == "n" ]; then
        ls 'package-lock.json' &>/dev/null; 
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "npm will be installed."; return 0; else NPM_INSTALL="n"; fi
        ls 'package.json' &>/dev/null;
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "npm will be installed."; return 0; else NPM_INSTALL="n"; fi
        ls 'node_modules' &>/dev/null;
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "npm will be installed."; return 0; else NPM_INSTALL="n"; fi
    fi

    if [ $YARN == "n" ]; then
        ls 'yarn.lock' &>/dev/null; 
        if [ $? -eq 0 ]; then YARN_INSTALL="y" && echo "yarn will be installed."; return 0; else YARN_INSTALL="n"; fi
    fi
}

clean_up () {

    if [ $OS_VAR == 1 ] || [ $OS_VAR == "alpine" ]; then
        if [ $JQ_INSTALLED == "y" ]; then apk del jq; fi
        if [ $RUBY_INSTALLED == "y" ]; then apk del ruby; fi
        if [ $NPM_INSTALLED == "y" ]; then apk del npm; fi
        if [ $YARN_INSTALLED == "y" ]; then apk del yarn; fi
        return 1
    fi

    if [ $OS_VAR == 2 ] || [ $OS_VAR == "debian" ]; then
        if [ $JQ_INSTALLED == "y" ]; then apt remove jq -y; fi
        if [ $RUBY_INSTALLED == "y" ]; then apt remove ruby -y; fi
        if [ $NPM_INSTALLED == "y" ]; then apt remove npm -y; fi
        if [ $YARN_INSTALLED == "y" ]; then apt remove yarn -y; fi
    fi
}
