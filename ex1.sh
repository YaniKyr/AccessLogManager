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
        rm cached_username.log
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

function find_by_method(){
    if [ -z $1 ]; then 
    echo "Wrong Method Name"
    elif [ $1 = "GET" ]; then
        sed -n "s/.*GET.*/\0/p" $FILE
    elif [ $1 = "POST" ]; then 
        sed -n "s/.*POST.*/\0/p" $FILE
    else 
        echo "Wrong Method Name"
    fi
}

function show_protocol(){
    if [ -z $1 ]; then 
    echo "Wrong network protocol"
    elif [ $1 = "IPv4" ]; then
        
        sed -n  "s/[0-9]\+\.[0-9]\+.[0-9]\+.[0-9]\+.*/\0/p" $FILE
    elif [ $1 = "IPv6" ]; then 
        sed -n "s/::[0-9].*/\0/p" $FILE
    else 
        echo "Wrong network protocol"
    fi
}

function count_browsers(){

    
    
    awk '{if( match($0,"Mozilla") !=0) count++ } END{ print count}' $FILE
    awk '{if( match($0,"Safari") !=0) count++ } END{ print count}' $FILE
    awk '{if( match($0,"Chrome") !=0) count++ } END{ print count}' $FILE
    awk '{if( match($0,"Edg") !=0) count++ } END{ print count}' $FILE

}

function search_by_date(){
    
    case $1 in
        Jan)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Feb)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Mar)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Apr)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        May)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Jun)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Jul)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Aug)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Sep)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Oct)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Nov)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        Dec)
            sed -n "s/.*\(\[..\/$1\/\).*/\0/p" $FILE
        ;;
        *)
        echo "Wrong Date"
    esac
 
    
}


function Instructions(){
    echo "Usage:    ./logparser.sh [FILE] [OPTION]...                 "
    echo "[FILE],[OPTION] are not mandatory.                          "
    echo ""
    echo "./logparser.sh                Returns the owners personal info."
    echo "./logparser.sh [FILE]         Output the [FILE]            "
    echo ""
    echo "Arguments:"
    echo "--usrid                       [USERNAME] find data based on a username."
    echo "                              Default print the number of occurences for" 
    echo "                              each username."
    echo "-method                       [INSTRUCTION] input only GET or POST.Returns all "
    echo "                              the data, that have the specified [INSTRUCTION]"
    echo "--servprot                    [IP] input only IPv4 or IPv6. Return the"
    echo "                              data that have the specified [IP] "
    echo "--browsers                    Return the number of occurrences, of predefined"
    echo "                              browsers. Mozilla, Safari, Chrome, Edg"
    echo "--datum                       [DATE] input only months Jan...Dec. Print"
    echo "                              the data based on months. The occurrences"
    echo "                              are independent of the year"
    echo ""
    echo "This shell script can read as well log as txt files. The purpose of the script is"
    echo "to parse files, that have netowrk POST or GET requests. The project was implemented"
    echo "as a university exercise. I claim no right. Yannis Kyriakopoulos"
}


if [ -z $1 -a -z $2  ] ; then
    echo "Yannis Kyriakopoulos"
elif [ $1 = "--help" -o $1 = "-h" -a -z $2 ]; then
    Instructions
elif [ -n $1 -a -z $2 ] ; then 
    if [ -f "$1" ]; then
        cat $1
    else 
        echo "Error in file: 'File does not exist' "
    fi


elif [ -n $1 -a -n $2 ] ; then
    if [ -f "$1" ]; then
        case $2 in 
        -method)
            find_by_method $3
        ;;
        --usrid)
            mining_usernames $3
        ;;
        --servprot)
        	show_protocol $3
        ;;
        --browsers)
            count_browsers 
        ;;
        --datum)
            search_by_date $3
        ;;
        *)
            echo "Command Ill formed. Check the syntax. --help for instructions"
    esac
    else 
        echo "Error in file: 'File does not exist' "
    fi
    
fi