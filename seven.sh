#!/bin/bash - 
#===============================================================================
#
#          FILE: harleytwo.sh
# 
#         USAGE: ./harleytwo.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/04/17 22:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
BROAD=$(grep '[A-Z]\.' c.txt -A2 -B9)
#List of all Skus
LIST=$(grep '[A-Z]\.' c.txt -A2 -B2 | grep -o '^[0-9]\{7,8\}' | sort | uniq | tail -n740)
#Temp for checking if adjacent price
TEMP=0
for n in $(cat <(echo $LIST) )
do
    #Get Name
    NAME=$( grep "$n" c.txt -A2 -B9 |  grep '[A-Z]\.'  | grep '[A-Z]\. [A-Z -]\+[a-z]' -o  | gsed 's/  //g' | gsed 's/A\. //' | cut -d' ' -f1-4 | head -n1 | sed 's/^[A-Z]\. //' | sed 's/[A-Z][a-z]//')
   #Get Body
    DESCRIPTION=$( grep "$n" c.txt  -B9 | grep '[A-Z]\.' | sed 's/^[A-Z]\. //' | gsed 's/^[A-Z ]\+\([A-Z][a-z]\)/\1/' | sed 's/"//g')

    if [[  -z $NAME ]]
    then
    NAME=$( grep $n c.txt  -B10 | grep '[A-Z]\.' | head -n1 | sed 's/^[A-Z]\. //' | sed 's/[A-Z][a-z].*//g')
        fi
    #Get Handle
    HANDLE=$( echo $NAME | tr '[A-Z]' '[a-z]' | sed 's/ /-/g' | sed "s/$/-${n}/"| sed 's/[A-Z][a-z]//' )
 
        #Get Price
        PRICE=$(grep 26800120 b.txt -A6 | ggrep -P '26800120 $\d+\.\d+' -o | ggrep -P '\d+\.\d+' -o)
        #    PRICE=$( grep "$n" c.txt | ggrep -P -m1 -o '\$\d+\.\d+' | sed  's/\$//' )
    if [[  -z $PRICE ]]
    then
        if [[ "$n" -eq "$TEMP" ]]
        then
            PRICE=$(grep "$n" c.txt -A10 | ggrep -P -o '\$\d+\.\d+' | sed 's/\$//g' | tr ' ' '\n' |tail -n1)
        else

            PRICE=$(grep "$n" c.txt -A6 | ggrep -P -o '\$\d+\.\d+' | sed 's/\$//g' |tr ' ' '\n' | head -n1)
        fi
    fi
        FIFTEEN=$( echo "scale=2; (${PRICE}) * .15" | bc )
        VARPRICE=$( echo "scale=2; ${PRICE} - $FIFTEEN"| bc )
        if [[ ! -z $n ]]
        then
            FINAL=$(echo "\"$HANDLE\", \"$NAME\" , \"$DESCRIPTION\", \"Harley Davidson\", \"\" , , \"\", \"Title\", \"Default Title\", , , , , \"$n\", ,,,,,\"$VARPRICE\",\"$PRICE\"")
        fi
        if [[ ! -z $FINAL ]]
        then
            echo $FINAL
        fi
        TEMP=$(($n + 1))
    done

