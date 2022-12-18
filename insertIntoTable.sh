#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

new_line="\n"
seperator="|"

read -p "Enter table name: " table_name
if [ -f $table_name ]
then

    num_fields=`awk -F "|" '{if(NR==1) print NF}' $table_name`    #get the number of fields in file(table name)
    
    i=2
    while [ $i -le $num_fields ]        #assume the min value of rows in meta_table_name file i=2
    do
        field_name=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' meta_$table_name)    #get the field name from meta_table_name file
        field_type=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $2}' meta_$table_name)    #get the field type from meta_table_name file
        field_pk=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $3}' meta_$table_name)      #get the field pk from meta_table_name file

        read -p "Please,Enter the value of field ( $field_name ) :" value           #get the value you wanted to add to the field name


        if [[ "$field_type" = "int" ]]           #if the value was integer 
        then

            while ! [[ "$value" =~ ^[0-9]+$ && -n "$value" ]]      #while value is NOT numbers and not null value
            do
                echo -e "Error! Invalid Data Type !!!"
                read -p "Please,Enter the value of field ( $field_name ) :" value
            done


        elif [ "$field_type" = "str" ]
        then

            while ! [[ "$value" =~ ^[a-zA-z] && -n "$value" ]]   #while value is NOT str [a-zA-z] and not null value and not null
            do
                echo -e "Error! Invalid Data Type !!!"
                read -p "Please,Enter the value of field ( $field_name ) :" value
            done
        fi


        if [ "$field_pk" = "itIsPK" ]
        then

            result=$(for i in `awk -F"|" '{if(NR > 3) print $1}' $table_name`;do echo $i;done)

            for x in `echo $result`
            do

                if [ "$x" = "$value" ]
                then

                    echo -e "Error! THIS IS A REPEATED PRIMARY KEY !!!"
                    read -p "Please,Enter the value of field ( $field_name ) :" value
                fi
            done
        fi

        if [ $i == $num_fields ]
        then

            new_row=$value$new_line
        else
            new_row=$value$seperator
        fi

        echo -e $new_row"\c" >> $table_name



        ((i++))
    done

    if [ $? -eq 0 ]
    then
        echo -e "\n------------------------------------------------------------"
        echo -e "  Complete! Your Data Inserted in table $table_name Successfully :) "
        echo -e "------------------------------------------------------------\n" 
    else
        echo -e "\n---------------------------------------------------------"
        echo -e "  Error! Failed To Insert The Data Into : $table_name table"
        echo -e "---------------------------------------------------------\n"
    fi
else
    echo -e "\n----------------------------------------------------"
    echo -e "         Error! Table Name Doesn't Exist              "
    echo -e "----------------------------------------------------\n"
    source ../../inserIntoTable.sh
fi




