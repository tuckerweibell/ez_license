#!/bin/bash

handle_gem_deps () {

    if gem_installed; then
        echo "{\"dependencies\": [" > gem_deps.json && gem list | \
        cut -d " " -f1 | \
        xargs -t -I {} bash -c 'homepage=`gem spec {} homepage | \
                                cut -c5-` && version=`gem spec {} version | \
                                tail -n2 | cut -d " " -f 2` && name=`gem spec {} name | \
                                cut -c5-` && license=`gem spec {} licenses | xargs | \
                                cut -c7-` && if ([ $license = "[]" ] || \ 
                                [ -v $license ] || [ -z $license ] || \
                                [ $license = "" ]) && ! [ -z $name ]; then \
                                echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"UNKOWN\",\"homepage_url\":\"$homepage\"}" | \
                                jq && echo ,; else if ! [$name == ""]; then \
                                echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"$license\",\"homepage_url\":\"$homepage\"}" | \
                                jq && echo ,; fi; fi' 2>/dev/null >> gem_deps.json && sed -i '$ d' gem_deps.json && echo "]}" >> ez_license/dependencies/gem_deps.json
    else
        printf '\n'; echo "Skipping gem - not installed."
    fi
}

gem_installed () {
    gem -v &>/dev/null 
    return $?
}