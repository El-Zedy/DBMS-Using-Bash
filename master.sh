#!/bin/bash
export LC_COLLATE=C # Terminal Case Sensitive
shopt -s extglob #import Advanced Regex

if [ -d DBMS ] ; then
    echo -e "\n -------- Welcome to B-DBMS ------------ \n"
else
    mkdir ./DBMS    #current Directory
    echo -e "\n -------- Welcome to B-DBMS ------------ \n"
fi

#Create Main Menu
select choice in "Create Database" "List Databases" "Connect to Database" "Drop Database" Exit
do
    case $choice in 
        "Create Database" )

            #Call createDB.sh to Creating a new Database
            source ./createDB.sh
        ;;
        "List Databases" )

            #Call listDBs.sh to List all Databases
            source ./listDBs.sh
        ;;
        "Connect to Database" ) 

             #Call connectDB to connect a Database
             source ./connectDB.sh
        ;;
        "Drop Database" ) 
        
             #Call dropDB.sh 
             source ./dropDB.sh
        ;;
        "Exit" ) 
        
             #Exit from B-DBMS
             echo -e "\n Good Bye See You Soon :)\n "
             break
        ;;
        *) 
            echo "Sorry, please select a number from the above Menu."
    esac
done

