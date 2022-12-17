#!/bin/bash
export LC_COLLATE=C # Terminal Case Sensitive
shopt -s extglob #import Advanced Regex

echo -e "\n  ---------------------------------"
echo -n "   ==> Please Enter Database Name : "
read  database 

case $database in

    +([A-Za-z]))

        if [ -d ./DBMS/$database ]         #check if dbname exist on DBMS Dir or not
        then                               #if yes 

            echo -e "\n-------------------------------------------------"
            echo "   ($database) database exist and your are in it now."
            echo -e "-------------------------------------------------\n"
            cd ./DBMS/$database             #cd to it
            pwd
            source ../../tableMenu.sh       #then call tableMenu script
                    
        else

            echo -e "\n----------------------------------------"
            echo "   Error! ($database) database not exist."
            echo -e "----------------------------------------\n"                
            source ./connectDB.sh                      

        fi
        ;;
        * )
            echo -e "\n-----------------------------------------------"
            echo "   Error! Please enter a vaild database name."
            echo -e "-----------------------------------------------\n"
            source ./connectDB.sh
        ;;
 esac
