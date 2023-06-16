#!/bin/bash


check_pkg_managers() {
    
    if [ -z $YARN ]; then
        yarn -v &>/dev/null; if [ $? == 0 ]; then YARN="y" && echo "Yarn detected."; else YARN="n"; fi
    fi

    if [ -z $NPM ]; then
        npm -v &>/dev/null; if [ $? == 0 ]; then NPM="y" && echo "Npm detected."; else NPM="n"; fi
    fi

    if [ -z $GEM ]; then
        gem -v &>/dev/null; if [ $? == 0 ]; then GEM="y" && echo "Gems detected."; else GEM="n"; fi
    fi

    if [ -z $PIP ]; then
        pip -v &>/dev/null; if [ $? == 0 ]; then PIP="y" && echo "Pip detected."; else PIP="n"; fi
    fi

    if [ -z $POETRY ]; then
        poetry -v &>/dev/null; if [ $? == 0 ]; then POETRY="y" && echo "Poetry detected."; else POETRY="n"; fi
    fi
    
    printf '\n'
}