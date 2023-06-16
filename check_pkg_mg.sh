#!/bin/bash


check_pkg_managers() {
    
    yarn -v &>/dev/null; if [ $? == 0 ] && [ $YARN != "y"]; then YARN="y" && echo "Yarn detected."; else YARN="n"; fi

    npm -v &>/dev/null; if [ $? == 0 ] && [ $NPM != "y"]; then NPM="y" && echo "Npm detected."; else NPM="n"; fi

    gem -v &>/dev/null; if [ $? == 0 ] && [ $GEM != "y"]; then GEM="y" && echo "Gems detected."; else GEM="n"; fi

    pip -v &>/dev/null; if [ $? == 0 ] && [ $PIP != "y"]; then PIP="y" && echo "Pip detected."; else PIP="n"; fi

    poetry -v &>/dev/null; if [ $? == 0 ] && [ $PIP != "y"]; then PIP="y" && echo "Poetry detected."; else PIP="n"; fi

    printf '\n'
}