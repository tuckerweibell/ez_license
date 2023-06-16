#!/bin/bash

# Include required scripts
. 'ez_license/scripts.sh'

# Remove old .json output if they exist
rm ez_license/dependencies/*.json &>/dev/null

# Display welcome message
welcome

# Checking Package Managers
check_pkg_managers

# Attempt to detect OS. Prompt if unsuccessful.
auto_detect_os

# Set application name
handle_app_name

# Handle Gem Dependencies
start_spinner "Processing gem dependencies..."
handle_gem_deps
stop_spinner 0
printf '\n'

# Handle Yarn Dependencies
start_spinner "Processing yarn package dependencies..."
handle_yarn_deps
stop_spinner 0
printf '\n'

# Handle Npm Dependencies
start_spinner "Processing npm package dependencies..."
handle_npm_deps
stop_spinner 0
printf '\n'

# Handle Pip / Poetry Dependencies
start_spinner "Processing pip / poetry package dependencies..."
handle_pip_deps
stop_spinner 0
printf '\n'

# Run Ruby script to generate CSV file
printf '\n'; echo "Consolidating and removing duplicates..."; printf '\n'
ruby ez_license/parser.rb
echo "Success!"
printf '\n'
 
# Generate output message
output_msg
