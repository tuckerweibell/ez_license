
#!/bin/bash

usage() {
  printf '\n'; echo "Usage: $0 [ -n APP_NAME (anything) ] [ -o OS_VAR (alpine or debian) ] [ -d OUTPUT_DIR ]" 1>&2; printf '\n';
}

exit_abnormal() {
  usage
  exit 1
}

while getopts "n:o:d:" opt; do
    case $opt in
        n)
            APP_NAME=${OPTARG}
            ;;
        o)
            OS_VAR=${OPTARG}
            if ! ([ $OS_VAR == "debian" ] || [ $OS_VAR == "alpine" ]); then exit_abnormal; fi
            ;;
        d)
            OUTPUT_DIR=${OPTARG}
            ;;
        ?)
            exit_abnormal
            ;;
        :)
            exit_abnormal
    esac

done