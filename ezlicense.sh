#!/bin/bash

# Include required scripts
. 'spinner.sh'
. 'os_handler.sh'
. 'welcome_banner.sh'
. 'app_handler.sh'
. 'gem_handler.sh'

# Display welcome message
welcome

# Attempt to detect OS. Prompt if unsuccessful.
auto_detect_os

# Set application name
handle_app_name

# Handle Gem Dependencies
start_spinner "Processing gem dependencies..."
handle_gem_deps
stop_spinner 0
printf '\n'
echo "Processed gem dependencies"

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
printf '\n'
file_ext="_license.csv"
mv licenses.csv $APP_NAME$file_ext
echo $APP_NAME$file_ext
cp $APP_NAME$file_ext results
printf '\n'
echo "Status: Complete!"
