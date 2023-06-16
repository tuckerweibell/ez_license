#!/bin/bash


check_pkg_managers() {
    
        yarn -v &>/dev/null; if [ $? == 0 ]; then YARN="y" && echo "Yarn detected."; else YARN="n"; fi

        npm -v &>/dev/null; if [ $? == 0 ]; then NPM="y" && echo "Npm detected."; else NPM="n"; fi

        gem -v &>/dev/null; if [ $? == 0 ]; then GEM="y" && echo "Gems detected."; else GEM="n"; fi

        pip -v &>/dev/null; if [ $? == 0 ]; then PIP="y" && echo "Pip detected."; else PIP="n"; fi

        poetry -v &>/dev/null; if [ $? == 0 ]; then POETRY="y" && echo "Poetry detected."; else POETRY="n"; fi

    printf '\n'
}