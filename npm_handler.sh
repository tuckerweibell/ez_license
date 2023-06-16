#!/bin/bash

handle_npm_deps () {
    if npm_installed; then
        npm install -g license-checker && license-checker --json | jq > npm_deps.json
    else
        printf '\n'; echo "Skipping npn - not installed."
    fi
}

npm_installed () {
    npm -v &>/dev/null 
    return $?
}