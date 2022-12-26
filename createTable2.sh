#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

echo -e "\n  ------------------------------"
echo -n "   ==> Please Enter Table Name : "
read tableName
echo -e "\n"

case $tableName in

    +([A-Za-z]))

        if [ -f ./$tableName ]                   #check Table existance
        then                       
            echo -e "\n-------------------------------------------"
            echo "   Error! ($tableName) is already exist."
            echo -e "--------------------------------------------\n"
        else
            # take number from user and checks it's a valid number
            echo -n "   ==> Please Enter number of Fields: "
            read numOfFields

            # check $numOfFields is a special character or empty value or a string
            while ! [[ "$numOfFields" =~ ^[0-9]+$ ]];       # =~ A regular expression matching sign
            do
                echo -e "\n------------------------------------------"
                echo -e "   Error! Please enter a Valid number."
                echo -e "------------------------------------------\n"
                echo -n "   ==> Enter number of Fields: "
                read numOfFields   
            done

            primary_key="" 
            num=1                                           #Counter                              
            # Start point of the loop
            while (( $num <= $numOfFields ))
            do
                # take fields names from the user 
                echo -e "  \n   ------------------------------"  
                read -p "   ==> Enter name of field no.$num: " fieldName
                                
                while ! [[ $fieldName = +([A-Za-z]) ]]; #if fieldName not equal set of chars
                do                   
                    echo -e "\n-------------------------------"
                    echo -e "   Error! invalid field name."
                    echo -e "-------------------------------\n"
                    echo -e "  \n   ------------------------------"
                    read -p "   ==> Enter Name of field no.$num: " fieldName

                done

                # Select the field type
                echo -e "\n-------------------------------"
                echo -e "  Choose Type of field ($fieldName):"
                echo -e "-------------------------------\n"
                
                select dType in "integer" "string"
                do
                case $dType in
                    integer )
                        fieldType="int";
                        break
                    ;;
                    string ) 
                        fieldType="string";
                        break
                    ;;
                    * ) 
                    echo -e "\n-------------------------------------------------"
                    echo -e "   Error! invalid data type, Please choose 1 Or 2."
                    echo -e "-------------------------------------------------\n"
                    ;;
                esac
                done

                newLine="\n"
                seperator="|"                                                                           
                meta_data="field"$seperator"type"$seperator"key" ##===> field | type | key

                #Check is there a primary key 
                while [ "$primary_key" == "" ]   # while pk = empty string ask him
                do
                    echo -e "\n-----------------------------------------"
                    echo -e "  Do you want this field as Primary Key?"
                    echo -e "-----------------------------------------\n"

                    select answer in "yes" "no"
                    do
                        case $answer in

                        yes ) 
                            primary_key="itIsPK";
                            meta_data=$newLine$fieldName$seperator$fieldType$seperator$primary_key; #\n filedname | Data type | pk
                            break
                        ;;
                        no ) 
                            primary_key="notPK";
                            meta_data=$newLine$fieldName$seperator$fieldType$seperator$primary_key;
                            break
                        ;;

                        * ) 
                            echo -e "\n------------------------------------"
                            echo -e "  Error! Please enter a valid answer."
                            echo -e "-------------------------------------\n"                        
                        ;;
                        esac
                    done                            
                done
                
                if [ "$primary_key" == "notPK" ]
                then
                        primary_key=""
                fi

                myarray[$num]=$fieldName$seperator$fieldType$seperator$primary_key # myarray[1] = Field Name | data type | pk

                if [ "$primary_key" == "itIsPK" ]  
                then
                        primary_key="\t"                                            
                fi
                (( num++ ))

            done
            #End point of the loop

            #insert 
            touch $tableName
            touch meta_$tableName

            echo -e "field"$seperator"type"$seperator"key" >> meta_$tableName #field | datatype | pk
            
            for i in ${myarray[*]}
            do
                echo -e "$i" >> meta_$tableName   #append data comes with array at metadata                            
                
            done
                
            awk '(NR>1)' meta_$tableName | cut -d "|" -f 1 | awk  '{ printf "%s | ",$1 }' > $tableName #from metadata second row cut first columns and append it at first row in afile by default  #$1 first colum
            echo "" >> $tableName                                           

            if [ $? -eq 0 ] #if last command true returns a status of 0
            then
                    echo -e "\n---------------------------------------"
                    echo -e "  Table $tableName is Created Successfully :) "
                    echo -e "---------------------------------------\n" 
            else
                    echo -e "\n---------------------------------------"
                    echo -e "  Error! Creating table $tableName Faild. "
                    echo -e "----------------------------------------\n"
            fi
       fi
        ;;      

    *)
        echo -e "\n----------------------------------------------------"
        echo -e "   Error! invalid table name, Press enter to continue.."
        echo -e "----------------------------------------------------\n"
    ;;      
esac 