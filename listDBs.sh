#!/bin/bash
export LC_COLLATE=C             # Terminal Case Sensitive
shopt -s extglob                #import Advanced Regex

echo "
        -----------------------
        | Your Databases List: |
        -----------------------"
ls -F ./DBMS | grep /           #list bye type then grep only directories
echo -e "\n"                    #newline