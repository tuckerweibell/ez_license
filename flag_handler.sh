
#!/bin/bash

usage() {
  printf '\n'; echo "Usage: $0 [ -n APP_NAME (anything) ] [ -o OS_VAR (alpine or debian)]" 1>&2; printf '\n';
}

exit_abnormal() {
  usage
  exit 1
}

while getopts ":n:o:" opt; do
    case $opt in
        n)
            APP_NAME=${OPTARG}
            ;;
        o)
            OS_VAR=${OPTARG}
            ;;
        :)
            exit_abnormal
    esac

done