#!/bin/bash

handle_pip_deps () {

    if pip_installed; then
       pip install -U pip-licenses && pip-licenses -l --format=json > ez_license/dependencies/python_deps.json
    else
        printf '\n'; echo "Skipping pip - not installed."
    fi
}

gem_installed () {
    pip -v &>/dev/null 
    return $?
}