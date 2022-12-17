#!/bin/bash
export LC_COLLATE=C             # Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex
if [ -z "$(ls -F ./DBMS | grep / )" ]; then         #check th DB lists if
   echo "
        -----------------------
        | NO DATABASES FOUND ! |
        -----------------------"                #if there is no DB list it will return this message
else
    ls -F ./DBMS | grep /           #list bye type then grep only directories
    echo -e "\n"                    #newline
fi