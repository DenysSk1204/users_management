#!/bin/bash

create_user(){
    if useradd -m -s /bin/bash $1; then 
        echo "####################################"
        echo "Specify a password for user $1: "
        passwd $1
        echo "Done! The user $1 has been created. Below information about user: "
        id $1
        echo "####################################"
    else 
        echo "Something happened...try again please"
    fi
}