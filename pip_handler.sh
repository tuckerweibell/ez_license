#!/bin/bash

handle_pip_deps () {

    if [ $PIP == "n" ]; then return 0; fi

    if pip_installed; then
        pip install -U pip-licenses
        pip-licenses -u --format=json > ez_license/dependencies/python_deps.json
        echo "Processed pip / poetry packages."
    else
        printf '\n'; echo "Skipping pip - not installed."
    fi
}

pip_installed () {
    pip -v &>/dev/null 
    return $?
}