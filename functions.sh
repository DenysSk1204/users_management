#!/bin/bash

function main_menu(){
    PS3="Select the number of operation: "

    select OPT in "Create user" "Update user" "Delete user" "Quit"; do
        case $OPT in
            "Create user")
                echo "The user has been created";;

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

}