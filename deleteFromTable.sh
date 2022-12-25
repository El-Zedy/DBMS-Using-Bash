#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

echo -e "\n ---------------- Delete From Table Main Menu -------------------- \n"
select deleteOption in "Delete All table Data" "Delete Specefic Row" "Back"
do
    case $deleteOption in

      "Delete All table Data")

            echo -e "\n  ------------------------------"
            echo -n "   ==> Please Enter Table Name : "
            read tableName
            echo -e "\n"
            if [[ -f $tableName && $tableName = +([A-Za-z]) ]]; then

                echo -e "=== ($tableName) Table Content is ==="
                    column -t -s "|" $tableName
                echo -e "================================\n"
                
                sed -i '2,$d' $tableName
                if [ $? -eq 0 ] #if last command true returns a status of 0
                then
                        echo -e "\n---------------------------------------"
                        echo -e "  Table Data is deleted Successfully :) "
                        echo -e "---------------------------------------\n" 
                else
                        echo -e "\n---------------------------------------"
                        echo -e "  Error! Deleting table data Failed. "
                        echo -e "----------------------------------------\n"
                fi
            else
                    echo -e "\n-------------------------------"
                    echo -e " Error! Table Name Inavlid Or Not Found."
                    echo -e "-------------------------------\n"
            fi
         
        ;;  
      "Delete Specefic Row")

        echo -e "\n  ------------------------------"
        echo -n "   ==> Please Enter Table Name : "
        read tableName
        echo -e "\n"
        
        if [[ -f $tableName && $tableName = +([A-Za-z]) ]]; then

            echo -e "=== ($tableName) Table Content is ==="
                column -t -s "|" $tableName
            echo -e "================================\n"

			echo -e "  \n   -----------------------------------------------"
			echo -n "   ==> Please Enter Column ID For The Row Y Want to Delete: "
            read colId
			echo ""
            while ! [[ $colId =~ ^[1-9]+$ ]] #lw el colName name msh string
                do
                    echo -e "\n-------------------------------"
                    echo -e "   Error! Invalid Column ID."
                    echo -e "-------------------------------\n"
                    echo -e "  \n   --------------------------------------------------------"
                    read -p "   ==> Please Enter Column ID For The Row Y Want to Delete:" colId
                done
                
                etc=$(awk -F "|" '{if($1=='"$colId"') print $0}' $tableName) 
                sed -i '$etcd' $tableName 2>>./.error.log

                if [ $? -eq 0 ] #if last command true returns a status of 0
                then
                        echo -e "\n---------------------------------------"
                        echo -e "  Table Data is deleted Successfully :) "
                        echo -e "---------------------------------------\n" 
                else
                        echo -e "\n---------------------------------------"
                        echo -e "  Error! Deleting table data Failed. "
                        echo -e "----------------------------------------\n"
                fi
        else
         echo "error"
        fi
        ;;        
        "Back" )
            source ../../tableMenu.sh
        ;;
        * )
            echo -e "\n----------------------------------------------------"
            echo " Sorry, please select a number from the above Menu."
            echo -e "----------------------------------------------------\n"
        ;;
    esac

done