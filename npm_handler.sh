#!/bin/bash

handle_npm_deps () {

    if [ $NPM == "n" ]; then return 0; fi

    if npm_installed; then
        npm install -g license-checker && license-checker --json | jq > ez_license/dependencies/npm_deps.json
        echo "Processed npm packages."
    else
        printf '\n'; echo "Skipping npn - not installed."
    fi
}

npm_installed () {
    npm -v &>/dev/null 
    return $?
}