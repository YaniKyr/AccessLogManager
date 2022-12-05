#!/bin/bash

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
        sed -n "s/.*\($1\).*/\0/p" $FILE > temp_cache.log

        
    fi
}


if [ -z $1 -a -z $2  ] ; then
    echo "Yannis Kyriakopoulos"
elif [ -n $1 -a -z $2 ] ; then 
    cat $1
elif [ -n $1 -a -n $2 ] ; then
    punctation=`echo $2 | sed -n "s/\(-*\)\([a-z]*\)/\1/p"`
    if [ $punctation = '-' ] ; then 
        echo "correct way"
    elif [ $punctation = '--' ] ; then 
        cmd_type=`echo $2 | sed -n "s/\(-*\)\([a-z]*\)/\2/p"`
        if [ $cmd_type = "usrid" ]; then
            mining_usernames $3
        fi
    else 
        echo "fallasy"
    fi
    
    #mining_usernames

fi 
