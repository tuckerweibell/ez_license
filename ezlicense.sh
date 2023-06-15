#!/bin/bash

. 'spinner.sh'

echo "Installing required tools..."

apt-get update -y
apt install jq -y
apt install cowsay -y
PATH="$PATH:/usr/games"
export PATH
printf '\n'
echo "__________________________________________________"
echo "Rails License Scanner (Supports Bundle, Yarn, Npm)"
echo "__________________________________________________"
cowsay -e @@ -T U "Ignore it all and click “I agree”."
printf '\n'
start_spinner "Processing gem dependencies..."
echo "{\"dependencies\": [" > gem_deps.json && gem list | cut -d " " -f1 | xargs -t -I {} bash -c 'homepage=`gem spec {} homepage | cut -c5-` && version=`gem spec {} version | tail -n2 | cut -d " " -f 2` && name=`gem spec {} name | cut -c5-` && license=`gem spec {} licenses | xargs | cut -c7-` && if ([ $license = "[]" ] || [ -v $license ] || [ -z $license ] || [ $license = "" ]) && ! [ -z $name ]; then echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"UNKOWN\",\"homepage_url\":\"$homepage\"}" | jq && echo ,; else if ! [$name == ""]; then echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"$license\",\"homepage_url\":\"$homepage\"}" | jq && echo ,; fi; fi' 2>/dev/null >> gem_deps.json && sed -i '$ d' gem_deps.json && echo "]}" >> gem_deps.json
stop_spinner 0
printf '\n'
echo "Processed gem dependencies"
#start_spinner "Processing transitive gem dependencies..."
#echo "{\"dependencies\": [" > gem_transitive_deps.json && gem list | cut -d " " -f1 | xargs -I {} gem spec {} dependencies | grep name | cut -d " " -f4 | sort | uniq |  xargs -t -I {} bash -c 'homepage=`gem spec {} homepage | cut -c5-` && version=`gem spec {} version | tail -n2 | cut -d " " -f 2` && name=`gem spec {} name | cut -c5-` && license=`gem spec {} licenses | xargs | cut -c7-` && if ([ $license = "[]" ] || [ -v $license ] || [ -z $license ] || [ $license = "" ]) && ! [ -z $name ]; then echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"UNKOWN\",\"homepage_url\":\"$homepage\"}" | jq && echo ,; else if ! [$name == ""]; then echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"$license\",\"homepage_url\":\"$homepage\"}" | jq && echo ,; fi; fi' 2>/dev/null >> gem_transitive_deps.json && sed -i '$ d' gem_transitive_deps.json && echo "]}" >> gem_transitive_deps.json
#stop_spinner 0
#printf '\n'
#echo "Processed transitive gem dependencies (recursive depth 1)"
start_spinner "Processing yarn package dependencies..."
yarn licenses --ignore-engines list --json --no-progress | jq > yarn_deps.json
stop_spinner 0
printf '\n'
echo "Processed yarn package dependencies"
start_spinner "Processing npm package dependencies..."
npm install -g license-checker && license-checker --json | jq > npm_deps.json
stop_spinner 0
printf '\n'
printf '\n'
echo "Consolidating and removing duplicates..."
printf '\n'
ruby ezhelper.rb
echo "Success"
printf '\n'
printf '\n'
echo "License File:"
echo "_______________________"
cat config/application.rb | grep 'SERVICE_NAME = ' | cut -d '"' -f2 | xargs -t -I {} bash -c 'echo {}_licenses.csv && mv licenses.csv {}_licenses.csv'
cp *_licenses.csv results
printf '\n'
echo "Status: Complete!"
