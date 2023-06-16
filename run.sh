#!/bin/bash

# Include required scripts
. 'ez_license/scripts.sh'

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
echo "Processed gem dependencies."

# Handle Yarn Dependencies
start_spinner "Processing yarn package dependencies..."
handle_yarn_deps
stop_spinner 0
printf '\n'
echo "Processed yarn package dependencies."

# Handle Npm Dependencies
start_spinner "Processing npm package dependencies..."
handle_npm_deps
stop_spinner 0
printf '\n'
echo "Processed npm package dependencies."

# Run Ruby script to generate CSV file
printf '\n'; echo "Consolidating and removing duplicates..."; printf '\n'
ruby ez_license/ezhelper.rb
echo "Success!"
printf '\n\n'
 
# Generate output message
output_msg
