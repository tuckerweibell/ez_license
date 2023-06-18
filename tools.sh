#!/bin/bash

set_vars () {
    YARN_INSTALLED="n"
    NPM_INSTALLED="n"
    RUBY_INSTALLED="n"
    JQ_INSTALLED="n"
}

check_tools () {
    yarn -v &>/dev/null; if [ $? == 0 ]; then YARN="y" && echo "Yarn detected."; else YARN="n"; fi
    npm -v &>/dev/null; if [ $? == 0 ]; then NPM="y" && echo "Npm detected."; else NPM="n"; fi
    gem -v &>/dev/null; if [ $? == 0 ]; then GEM="y" && echo "Gems detected."; else GEM="n"; fi
    pip -v &>/dev/null; if [ $? == 0 ]; then PIP="y" && echo "Pip detected."; else PIP="n"; fi
    poetry -v &>/dev/null; if [ $? == 0 ]; then POETRY="y" && echo "Poetry detected."; else POETRY="n"; fi
    jq --version &>/dev/null; if [ $? == 0 ]; then JQ="y" && echo "JQ detected."; else JQ="n"; fi
    ruby --version &>/dev/null; if [ $? == 0 ]; then RUBY="y" && echo "Ruby detected."; else RUBY="n"; fi
    printf '\n'
}

add_npm_check () {
    printf '\n'
    if [ $NPM == "n" ]; then
        ls 'package-lock.json' &>/dev/null; 
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "npm will be installed."; return 0; else NPM_INSTALL="n"; fi
        ls 'package.json' &>/dev/null;
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "npm will be installed."; return 0; else NPM_INSTALL="n"; fi
        ls 'node_modules' &>/dev/null;
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "npm will be installed."; return 0; else NPM_INSTALL="n"; fi
    fi
    printf '\n'
}

add_yarn_check () {
    printf '\n'
    if [ $YARN == "n" ]; then
        ls 'yarn.lock' &>/dev/null; 
        if [ $? -eq 0 ]; then YARN_INSTALL="y" && echo "yarn will be installed."; return 0; else YARN_INSTALL="n"; fi
    fi
    printf '\n'
}

install_debian_tools () {
    apt-get update -y
    if [ $RUBY == "n" ]; then apt install ruby -y; RUBY_INSTALLED="y"; fi
    if [ $JQ == "n" ]; then apt install jq -y; JQ_INSTALLED="y"; fi
    add_npm_check
    add_yarn_check
    if ! [ -z $NPM_INSTALL ]; then if [ $NPM_INSTALL == "y" ]; then apt install npm -y; NPM_INSTALLED="y"; NPM="y"; else NPM_INSTALLED="n"; fi; fi
    if ! [ -z $YARN_INSTALL ]; then if [ $YARN_INSTALL == "y" ]; then apt install yarn -y; YARN_INSTALLED="y" YARN="y"; else YARN_INSTALLED="n"; fi; fi
}

install_alpine_tools () {
    apk update
    if [ $RUBY == "n" ]; then apk add ruby; RUBY_INSTALLED="y"; fi
    if [ $JQ == "n" ]; then apk add jq; JQ_INSTALLED="y"; fi
    add_npm_check
    add_yarn_check
    if ! [ -z $NPM_INSTALL ]; then if [ $NPM_INSTALL == "y" ]; then apk add npm; NPM_INSTALLED="y"; NPM="y"; else NPM_INSTALLED="n"; fi; fi
    if ! [ -z $YARN_INSTALL ]; then if [ $YARN_INSTALL == "y" ]; then apk add yarn; YARN_INSTALLED="y" YARN="y"; else YARN_INSTALLED="n"; fi; fi
}

clean () {
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