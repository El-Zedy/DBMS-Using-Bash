#!/bin/bash
export LC_COLLATE=C # Terminal Case Sensitive
shopt -s extglob #import Advanced Regex


read -p "|--Please Enter Database Name : " db_name

case $db_name in

    +([A-Za-z]))

        if [ -d ./DBMS/$db_name ] ; then

		    echo -e "
        --------------------------------------
        | Erorr! ($db_name) name is already exist.
        --------------------------------------
        "
		    source	./createDB.sh
		else

            mkdir ./DBMS/$db_name
            echo -e "
        ----------------------------------------
        | Database ($db_name) created successfully.
        ----------------------------------------
             "
              

		fi          
    ;;
    *)
		echo "
        -----------------------------
        | Not Vaild Database name ! |
        -----------------------------
             "
		source ./createDB.sh

    ;;
    
esac

