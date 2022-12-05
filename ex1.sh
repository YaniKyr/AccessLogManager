#!/bin/bash

#USE CASE instead of if's 
FILE=$1
CMD=$2
STRS=$3

 #  declare -A assArr
 #  
 #  while read p; do
 #      let count++ 
 #     
 #      name=`echo "$p" |sed -n "s/.*\(-\s[a-zA-Z0-9 ]* \).*/\1/p"`
 #      temp=`echo "$name" |sed -n "s/-\s\([a-zA-Z0-9]*\)\s/\1/p"`
 #      if [ -z $temp ]; then 
 #          let assArr["-"]++
 #      else 
 #          let assArr[$temp]++
 #      fi
 #     
 #  done < $FILE
 #  for key in "${!assArr[@]}"; do echo "${assArr[$key]} $key"; done


function mining_usernames(){
    
    if [ -z $1 ]; then 

        declare -A userArr
        #Get the number of lines with wc. 
        #Sed is used to remove the filename of the wc's output
        number_of_lines=`wc -l $FILE | sed -n 's/\([0-9]*\).*/\1/p'`
        
        name=`sed -n "s/.*\(-\s[a-zA-Z0-9 ]* \).*/\1/p" $FILE`
    
        echo "$name" |sed -n "s/-\s\([a-zA-Z0-9]*\)\s/\1/p" >cached_username.log
        number=`wc -l cached_username.log | sed -n 's/\([0-9]*\).*/\1/p'`
        
        for ele in $(cat cached_username.log); do
            let userArr[$ele]++
        done

        let userArr["-"]=number_of_lines-number +1
        for key in "${!userArr[@]}"; do echo "${userArr[$key]} $key"; done
    else
        if [ $1 = "-" ]; then 
            sed -n "s/.*\(- -\).*/\0/p" $FILE 

        elif [[ "$1" =~ [^a-zA-Z0-9] ]]; then
            echo "Fallacy"
        else
            
            sed -n "s/.*\($1\).*/\0/p" $FILE
        fi
        
    fi
}

function findByMethod(){
    if [ -z $1 ]; then 
    echo "Fallacy"
    elif [ $1 = "GET" ]; then
        sed -n "s/.*GET.*/\0/p" $FILE
    elif [ $1 = "POST" ]; then 
        sed -n "s/.*POST.*/\0/p" $FILE
    else 
        echo "Fallacy"
    fi
}

if [ -z $1 -a -z $2  ] ; then
    echo "Yannis Kyriakopoulos"
elif [ -n $1 -a -z $2 ] ; then 
    cat $1
elif [ -n $1 -a -n $2 ] ; then
    punctuation=`echo $2 | sed -n "s/\(-*\)\([a-z]*\)/\1/p"`
    if [ $punctuation = '-' ] ; then 
        cmd_type=`echo $2 | sed -n "s/\(-*\)\([a-z]*\)/\2/p"`
        if [ $cmd_type = "method" ]; then
            findByMethod $3
        
        else 
        echo "Fallacy"
        fi 
    elif [ $punctuation = '--' ] ; then 
        cmd_type=`echo $2 | sed -n "s/\(-*\)\([a-z]*\)/\2/p"`
        if [ $cmd_type = "usrid" ]; then
            mining_usernames $3
        fi
    else 
        echo "Fallacy"
    fi
    
    #mining_usernames

fi 
