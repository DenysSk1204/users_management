#!/bin/bash

main_menu(){
    
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
                update_user;;

            "Delete user")
                echo "The user has been deleted";;

            "Quit")
                echo "Bye!" 
                exit 0;;

            *)
                echo "Invalid option... try again";;
        esac
    done
}

create_user(){
    if useradd -m -s /bin/bash $1; then 
        echo "####################################"
        echo "Specify a password for user $1: "
        passwd --expire $1
        echo "Done! The user $1 has been created. User must change password after first sing in. Below information about user: "
        id $1
        echo "####################################"
    else 
        echo "Something happened...try again please"
    fi
}

update_user(){

    PS3="Select the number of operation: "
    select OPT in "Add to group" "Delete from group" "Lock user" "Unlock user" "Quit"; do
        case $OPT in 
            "Add to group")
                read -p "Enter the name of user: " NAME
                echo "####################################"
                if id "$NAME" &>/dev/null; then
                    GROUPS_LIST=$(awk -F: '($3 >= 1000 || $1 == "sudo" || $1 == "wheel") {print $1, $3}' /etc/group)
                    echo "The list of available groups is below:"
                    echo $GROUPS_LIST
                    read -p "Enter the name of group: " GROUP
                    if egrep ^"$GROUP" /etc/group &> /dev/null; then
                        usermod -aG $GROUP $NAME
                        echo "The user $NAME added to group $GROUP"
                        echo "Information about $NAME below:"
                        id $NAME
                    else
                        echo "The group $GROUP doesn't exist."
                    fi
                    echo "####################################"
                    main_menu
                    return
                else
                    echo "The user $NAME doesn't exist."
                    echo "####################################"
                    main_menu
                    return
                fi
                ;;
            
            "Delete from group")
                echo "Deleted from group";;

            "Lock user")
                echo "Locked";;
            
            "Unlock user")
                echo "Unlocked";;
            
            "Quit")
                echo "Forwarding to main menu."
                main_menu
                return;;
        esac
    done
}