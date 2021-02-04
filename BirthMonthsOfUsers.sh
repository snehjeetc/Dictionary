
#!/bin/bash -x

declare -A BirthMonths
lengthOfUserName=4

generateRandomUserName(){
    array=()
    for i in {a..z}; 
    do
        array[$RANDOM]=$i
    done
    printf %s ${array[@]::$lengthOfUserName}
}

storeUserData(){
    local UserName=$1
    local birthMonth=$2
    
    BirthMonths[$birthMonth]="${BirthMonths[$birthMonth]}${BirthMonths[$birthMonth]:+,}$UserName"
}

getMonthName(){
    case $1 in 
        1)
            echo "Jan"
            ;;
        2)
            echo "Feb"
            ;;
        3)
            echo "Mar"
            ;;
        4)
            echo "Apr"
            ;;
        5)
            echo "May"
            ;;
        6)  
            echo "Jun"
            ;;
        7)  
            echo "Jul"
            ;;
        8)
            echo "Aug"
            ;;
        9)
            echo "Sep"
            ;;
        10)
            echo "Oct"
            ;;
        11)
            echo "Nov"
            ;;
        12)
            echo "Dec"
            ;;
    esac
}

assignRandomBirthMonthToUsers(){
    for(( k=1; k<=50; k++))
    do
        key=$((RANDOM%12 + 1))
        userName="$( generateRandomUserName )"
        storeUserData $userName $key
    done
}

printBirthMonthsOfUsers(){
    for((k=1; k<=12; k++))
    do
        if [[ ! -z "${BirthMonths[$k]}" ]]
        then
            month="$( getMonthName $k )"
            echo $month" : "${BirthMonths[$k]}
        fi
    done
}
printCommonBirthMonthsOfUsers(){
    for((k=1; k<=12; k++))
    do
        if [[ ! -z "${BirthMonths[$k]}" ]]
        then
            month="$( getMonthName $k )"
            echo ${BirthMonths[$k]} | awk -F',' -v m=$month '{ if( NF > 1 ) print m " : " $0 }'
            printf $'\n'
        fi
    done
}

assignRandomBirthMonthToUsers

printBirthMonthsOfUsers
printCommonBirthMonthsOfUsers
