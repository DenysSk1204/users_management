#!/bin/bash

source functions.sh

PS3="Select the number of operation: "

    select OPT in "Create user" "Update user" "Delete user" "Quit"; do
        case $OPT in
            "Create user")
                read -p "Enter the name of user: " NAME
                if id "$NAME" &>/dev/null; then
                    echo "The user with name $NAME exists"
                else
                   create_user $NAME
                fi
                ;;

            "Update user")
                echo "The user has been updated";;

            "Delete user")
                echo "The user has been deleted";;

            "Quit")
                echo "Bye!" 
                break;;

            *)
                echo "Invalid option... try again";;
        esac
    done