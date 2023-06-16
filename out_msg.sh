#!/bin/bash

output_msg () {

# Output resulting CSV file name
echo '
License File:
_______________________
'
    printf '\n'
    EXT="_license.csv"
    mv licenses.csv $APP_NAME$EXT

    # Check if output dir specified.

    if [ -z $OUTPUT_DIR ]; then
        echo "No output directory specified. $APP_NAME$EXT added to current directory."
    else
        mv $APP_NAME$EXT $OUTPUT_DIR
        echo "$APP_NAME$EXT added to $PWD/$OUTPUT_DIR"
    fi

    printf '\n'; echo "Complete!";

    printf '\n'
    echo '
                                Come again!        
               -----------------------------------------------
               Rest assured, it will be an "udderly" good time. 
               -----------------------------------------------
                                  \   ^__^            
                                   \  (@@)\_______    
                                      (__)\       )\/\
                                        U ||----w||  
                                          ||     ||  
        '
    printf '\n'
}