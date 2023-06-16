#!/bin/bash


check_pkg_managers() {
    
    if `yarn -v &>/dev/null`; then YARN="y" && echo "Yarn detected."; else YARN="n"; fi

    if `npm -v &>/dev/null`; then NPM="y" && echo "Npm detected."; else NPM="n"; fi

    if `gem -v &>/dev/null`; then GEM="y" && echo "Gems detected."; else GEM="n"; fi

    if [ `pip -v &>/dev/null` || `poetry -v &>/dev/null`]; then PIP="y" && echo "Pip/Poetry detected."; else PIP="n"; fi

}