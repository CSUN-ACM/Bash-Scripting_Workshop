#!/bin/bash

for ((i=0;i<100;i++)); do
    echo "Do you want to create a new directory? (1=yes, 0=no)"
    read var
    
    unset dir_copy
    
    create_dir(){
        echo "Write the name of the directory you want to create:"
        read dir_name
        dir_copy="$dir_name"
    
        mkdir "$dir_name"
    
        cat <<EOF
-------------
The directory $dir_name was created
"cd $dir_name" to navigate into the directory
-------------
EOF
        new_file
    }

    new_file(){
        echo "Do you want to make a file in the directory $dir_copy? (1=yes, 0=no)"
        read var

        if [[ $var == 1 ]]; then
            cd "$dir_copy" || { echo "Failed to change directory"; return 1; }
            echo "Write the name of the file you want to create:"
            read file_name
            touch "$file_name"
            cat <<EOF
-----------
The file $file_name was created
"start $file_name" to open the file
-----------
EOF
            cd - > /dev/null  # Return to previous directory
        fi
    }
    
    if [[ $var == 1 ]]; then
        create_dir
    else 
        echo "Bye!"
        exit 0
    fi
done
