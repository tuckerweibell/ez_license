
#!/bin/bash

usage() {
  printf '\n'; echo "Usage: $0 [ -n APP_NAME (anything) ] [ -o OS_VAR (alpine or debian) ] [ -d OUTPUT_DIR ] [ -y (enable yarn)]" 1>&2; printf '\n';
}

exit_abnormal() {
  usage
  exit 1
}

while getopts "n:o:d:y" opt; do
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
        y)  
            YARN_ENABLED="y"
            ;;
        ?)
            exit_abnormal
            ;;
        :)
            exit_abnormal
    esac

done