#!/bin/bash -x

declare -A DiesCount
maxDieCount=-1
maxKey=-1
minDieCount=12
minKey=-1

init_DiesCount(){

    for ((i=1; i<=6; i++))
    do
        DiesCount[$i]=0
    done
}

generateRollingDieNumbers(){
    randomDiesNumbers=$(( RANDOM%6 + 1))
    storeInDictionary $randomDiesNumbers
}

storeInDictionary () {
	key=$1;
	DiesCount[$key]=$(( ${DiesCount[$key]} + 1 ));
}

getMinMaxOfDieCounts(){
    for(( k=1; k<=6; k++))
    do
        if [ $maxDieCount -lt ${DiesCount[$k]} ]
        then
            maxDieCount=${DiesCount[$k]}
            maxKey=$k
        fi

        if [ $minDieCount -gt ${DiesCount[$k]} ]
        then
            minDieCount=${DiesCount[$k]}
            minKey=$k
        fi

    done
}

printKeyValues(){
    for key in "${!DiesCount[@]}";
    do
        echo "${key}" " : " "${DiesCount[$key]}"
    done
}

isLimitReached(){
    if  [[ ${DiesCount[1]} -ne 10 && ${DiesCount[2]} -ne 10 && ${DiesCount[3]} -ne 10 
        && ${DiesCount[4]} -ne 10 && ${DiesCount[5]} -ne 10 && ${DiesCount[6]} -ne 10 ]]
    then 
        return 0
    else
        return 1
    fi
}

throwTheDieUptoTheLimit(){
    while isLimitReached 
    do
        generateRollingDieNumbers
    done
}

init_DiesCount
throwTheDieUptoTheLimit
printKeyValues
getMinMaxOfDieCounts

echo "${maxKey}" " : " "${maxDieCount}"
echo "${minKey}" " : " "${minDieCount}"

