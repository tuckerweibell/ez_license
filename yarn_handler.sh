#!/bin/bash

handle_yarn_deps () {

    if [ $YARN == "n" ]; then return 0; fi

    if yarn_installed; then
        yarn licenses --ignore-engines list --json --no-progress | jq > ez_license/dependencies/yarn_deps.json
        echo "Processed yarn packages."
    else
        printf '\n'; echo "Skipping yarn - not installed."
    fi
}

yarn_installed () {
    yarn -v &>/dev/null 
    return $?
}