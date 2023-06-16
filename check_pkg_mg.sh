#!/bin/bash


check_pkg_managers() {
    
    if [ -z $YARN ]; then
        yarn -v &>/dev/null; if [ $? == 0 ]; then export YARN="y" && echo "Yarn detected."; else export YARN="n"; fi
    fi

    if [ -z $NPM ]; then
        npm -v &>/dev/null; if [ $? == 0 ]; then export NPM="y" && echo "Npm detected."; else export NPM="n"; fi
    fi

    if [ -z $GEM ]; then
        gem -v &>/dev/null; if [ $? == 0 ]; then export GEM="y" && echo "Gems detected."; else export GEM="n"; fi
    fi

    if [ -z $PIP ]; then
        pip -v &>/dev/null; if [ $? == 0 ]; then export PIP="y" && echo "Pip detected."; else export PIP="n"; fi
    fi

    if [ -z $POETRY ]; then
        poetry -v &>/dev/null; if [ $? == 0 ]; then export POETRY="y" && echo "Poetry detected."; else export POETRY="n"; fi
    fi

    printf '\n'
}