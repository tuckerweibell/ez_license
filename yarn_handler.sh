#!/bin/bash

handle_yarn_deps () {
    if yarn_installed; then
        yarn licenses --ignore-engines list --json --no-progress | jq > yarn_deps.json
    else
        printf '\n'; echo "Skipping yarn - not installed."
    fi
}

yarn_installed () {
    yarn -v &>/dev/null 
    return $?
}