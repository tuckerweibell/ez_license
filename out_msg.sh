#!/bin/bash

output_msg () {

# Output resulting CSV file name
echo '
License File:
_______________________
'
    EXT="_license.csv"
    LINES=`cat licenses.csv | wc -l`
    COUNT=$(($LINES-1))
    mv licenses.csv $APP_NAME$EXT

    # Check if output dir specified.
    if [ -z $OUTPUT_DIR ]; then
        echo "No output directory specified. $APP_NAME$EXT added to current directory."
    else
        # Check if output dir already exists and create if not
        ls $OUTPUT_DIR &>/dev/null; if ! [ $? == 0 ]; then mkdir $OUTPUT_DIR; fi
        mv $APP_NAME$EXT $OUTPUT_DIR
        echo "$APP_NAME$EXT added to $PWD/$OUTPUT_DIR"
    fi

echo '
Results:
_______________________
'
    echo "$COUNT licenses found."

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