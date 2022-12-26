#!/bin/bash
export LC_COLLATE=C             #Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex
ls -F ./DBMS | grep / | sed -r 's/\S\s*$//' |column -t
echo -e "\n  ------------------------------"
echo -n "   ==> Please Enter Table Name : "
read tablename
echo -e "\n"
while [ true ]
do
    if [ -f ./$tablename ] #if table exist
    then
        echo -e "Please , Enter Column name from the following names : "
        head -1 $tablename | column -t -s "|"
        read colname
        colnum=`awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tablename 2>>/dev/null`
        if [[ $colnum == "" ]]
        then
            echo "Wrong Input!"
            continue
        else
            echo -e "Enter the value : "
            read value
            
        fi
    else
        echo -e "\n--------------------------------------------------"
        echo "table not found please!"
        echo -e "--------------------------------------------------\n"
        echo "Please Enter Table Name : "
        read tablename
    fi

done