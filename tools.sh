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
    ruby --version &>/dev/null; if [ $? == 0 ]; then RUBY="y" && echo "Ruby detected."; else RUBY="n"; fi
    gem -v &>/dev/null; if [ $? == 0 ]; then GEM="y" && echo "Gems detected."; else GEM="n"; fi
    pip -v &>/dev/null; if [ $? == 0 ]; then PIP="y" && echo "Pip detected."; else PIP="n"; fi
    poetry -v &>/dev/null; if [ $? == 0 ]; then POETRY="y" && echo "Poetry detected."; else POETRY="n"; fi
    jq --version &>/dev/null; if [ $? == 0 ]; then JQ="y" && echo "JQ detected."; else JQ="n"; fi
    printf '\n'
}

add_npm_check () {
    printf '\n'
    if [ $NPM == "n" ]; then
        ls 'package-lock.json' &>/dev/null; 
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "Found package-lock.json."; return 0; else NPM_INSTALL="n"; fi
        ls 'package.json' &>/dev/null;
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "Found package.json."; return 0; else NPM_INSTALL="n"; fi
        ls 'node_modules' &>/dev/null;
        if [ $? -eq 0 ]; then NPM_INSTALL="y" && echo "Found node_modules."; return 0; else NPM_INSTALL="n"; fi
    fi
    printf '\n'
}

add_yarn_check () {
    printf '\n'
    if [ $YARN == "n" ]; then
        ls 'yarn.lock' &>/dev/null; 
        if [ $? -eq 0 ]; then YARN_INSTALL="y" && echo "Found yarn.lock"; return 0; else YARN_INSTALL="n"; fi
    fi
    printf '\n'
}

install_debian_tools () {
    add_npm_check
    add_yarn_check
    apt-get update -y
    if [ $RUBY == "n" ]; then printf '\n'; echo "ruby will be installed"; printf '\n'; apt install ruby -y; RUBY_INSTALLED="y"; fi
    if [ $JQ == "n" ]; then printf '\n'; echo "jq will be installed"; printf '\n'; apt install jq -y; JQ_INSTALLED="y"; fi
    if ! [ -z $NPM_INSTALL ]; then if [ $NPM_INSTALL == "y" ]; then printf '\n'; echo "npm will be installed"; printf '\n'; apt install npm -y; NPM_INSTALLED="y"; NPM="y"; else NPM_INSTALLED="n"; fi; fi
    if ! [ -z $YARN_INSTALL ]; then if [ $YARN_INSTALL == "y" ]; then printf '\n'; echo "yarn will be installed"; printf '\n'; apt install yarn -y; YARN_INSTALLED="y" YARN="y"; else YARN_INSTALLED="n"; fi; fi
}

install_alpine_tools () {
    add_npm_check
    add_yarn_check
    apk update
    if [ $RUBY == "n" ]; then printf '\n'; echo "ruby will be installed"; printf '\n'; apk add ruby; RUBY_INSTALLED="y"; fi
    if [ $JQ == "n" ]; then printf '\n'; echo "jq will be installed"; printf '\n'; apk add jq; JQ_INSTALLED="y"; fi
    if ! [ -z $NPM_INSTALL ]; then if [ $NPM_INSTALL == "y" ]; then printf '\n'; echo "npm will be installed"; printf '\n'; apk add npm; NPM_INSTALLED="y"; NPM="y"; else NPM_INSTALLED="n"; fi; fi
    if ! [ -z $YARN_INSTALL ]; then if [ $YARN_INSTALL == "y" ]; then printf '\n'; echo "npm will be installed"; printf '\n'; apk add yarn; YARN_INSTALLED="y" YARN="y"; else YARN_INSTALLED="n"; fi; fi
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