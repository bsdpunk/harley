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
LIST=$(grep -P -o '\d{5}-\d{2}\w{0,1}' c.txt | sort | uniq )
#Temp for checking if adjacent price
TEMP=0
for n in $(cat <(echo $LIST) )
do
    #Get Name
    NAME=$( grep '14093-84' c.txt  -B9 | grep '^[A-Z]\.' | sed 's/^[A-Z]\. //' | sed 's/^[A-Z ]\+       \([A-Z][a-z]\)/\1/' | sed 's/"//g' | grep '[A-Z ]\+' | tail -n1 | sed 's/[a-z].*//' | sed 's/.$//' )
    #grep "$n" c.txt -B9 |  grep '^[A-Z]\.'  | grep '^[A-Z]\+ [A-Z -]\+[a-z]' -o  | sed 's/  //g' | sed 's/A\. //' | cut -d' ' -f1-4 | tail -n1 | sed 's/^[A-Z]\. //' | sed 's/[A-Z][a-z]//')
   #Get Body
    DESCRIPTION=$( grep "$n" c.txt  -B9 | grep '^[A-Z]\.' | sed 's/^[A-Z]\. //' | sed 's/^[A-Z ]\+\([A-Z][a-z]\)/\1/' | sed 's/"//g')

    if [[  -z $NAME ]]
    then
    NAME=$( grep $n c.txt  -B10 | grep '^[A-Z]\+' | head -n1 | sed 's/^[A-Z]\. //' | sed 's/[A-Z][a-z].*//g')
        fi
    #Get Handle
    HANDLE=$( echo $NAME | tr '[A-Z]' '[a-z]' | sed 's/ /-/g' | sed "s/$/-${n}/"| sed 's/[A-Z][a-z]//' )
 
        #Get Price
        PRICE=$(grep "$n" c.txt -A6 | grep -P '26800120 $\d+\.\d+' -o | grep -P '\d+\.\d+' -o)
        #    PRICE=$( grep "$n" c.txt | grep -P -m1 -o '\$\d+\.\d+' | sed  's/\$//' )
    if [[  -z $PRICE ]]
    then
     #   if [[ "$n" -eq "$TEMP" ]]
      #  then
       #     PRICE=$(grep "$n" c.txt -A10 | grep -P -o '\$\d+\.\d+' | sed 's/\$//g' | tr ' ' '\n' |tail -n1)
        #else

            PRICE=$(grep "$n" c.txt -A6 | grep -P -o '\$\d+\.\d+' | sed 's/\$//g' |tr ' ' '\n' | head -n1)
        #fi
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
    done

