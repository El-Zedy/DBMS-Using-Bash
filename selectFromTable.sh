#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex
ls -F ./ |  sed -n '/meta_/!p' | column -t
echo -e "\n  ------------------------------"
echo -n "   ==> Please Enter Table Name : "
read tablename
echo -e "\n"
while [ true ]    
do
    if [ -f ./$tablename ] #if table exist
    then
        select choice in "Select all Columns" "Select specific column" "back to table menu" "back to main menu" Exit
        do
            case $choice in
          
              "Select all Columns" )
                column -t -s "|" $tablename         #show all columns in the table
              ;;
              "Select specific column" )
                
                read -p " ===> Please, Enter column name : " col_name                                  # to choose specific column 
                col_num=`awk -F"|" -v col="$col_name" 'NR==1{for (i=1; i<=NF; i++) if ($i==col) {print i;exit}}' $tablename`  # col_num = number of field the column exist
                awk -F"|" -v val="$col_num" '{print $val }' $tablename | column -t -s "|"  #print the choosen column
              ;;
              "back to table menu" )
                clear
                source ../../tableMenu.sh
              ;;
              "back to main menu" )
                cd ../..
                clear
                source ./master.sh
                exit
                break
              ;;
              "Exit" )
                echo "
                        ----------------------------
                        | Good Bye See You Soon :) |
                        ----------------------------
                    "
                exit
              ;;
              *)
                echo -e "\n--------------------------------------------------"
                echo " Sorry, please select a number from the above Menu."
                echo -e "--------------------------------------------------\n"
            esac
        done

    else
        echo -e "\n-----------------------------"
        echo "table not found please!"
        echo -e "-----------------------------\n"
        echo "Please Enter Table Name : "
        read tablename
    fi
done