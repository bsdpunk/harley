#!/bin/bash - 
#===============================================================================
#
#          FILE: final.sh
# 
#         USAGE: ./final.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Dusty Carver (), 
#  ORGANIZATION: 
#       CREATED: 10/04/17 22:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
BROAD=$(grep '[A-Z]\.' c.txt -A2 -B9)
#List of all Skus
#LIST=$(grep -P -o '\d{5}-\d{2}\w{0,1}' c.txt | sort | uniq )
LIST=$( grep -o '^[0-9]\{7,8\}' c.txt | sort | uniq  )
#Temp for checking if adjacent price
TEMP=0
for n in $(cat <(echo $LIST) )
do
    #Get Name
    NAME=$( grep "$n" c.txt  -B9 | grep '^[A-Z]\.' | sed 's/^[A-Z]\. //' | sed 's/^[A-Z ]\+       \([A-Z][a-z]\)/\1/' | sed 's/"//g' | grep '[A-Z ]\+' | tail -n1 | sed 's/[a-z].*//' | sed 's/.$//' )
    #Get Body
    DESCRIPTION=$( grep "$n" c.txt  -B9 | grep '^[A-Z]\.' | sed 's/^[A-Z]\. //' | sed 's/^[A-Z ]\+\([A-Z][a-z]\)/\1/' | sed 's/"//g')

    if [[  -z $NAME ]]
    then
        NAME=$( grep $n c.txt  -B10 | grep '^[A-Z]\+' | head -n1 | sed 's/^[A-Z]\. //' | sed 's/[A-Z][a-z].*//g')
    fi
    #Get Handle
    HANDLE=$( echo $NAME | tr '[A-Z]' '[a-z]' | sed 's/ /-/g' | sed "s/$/-${n}/"| sed 's/[A-Z][a-z]//' )

    #Get Price
    PRICE=$(grep "$n" c.txt -A6 | grep -P '${n} $\d+\.\d+' -o | grep -P '\d+\.\d+' -o)
    if [[  -z $PRICE ]]
    then
        PRICE=$(grep "$n" c.txt -A6 | grep -P -o '\$\d+\.\d+' | sed 's/\$//g' |tr ' ' '\n' | head -n1)
    fi
    # Do Var Price Math
    FIFTEEN=$( echo "scale=2; (${PRICE}) * .15" | bc )
    VARPRICE=$( echo "scale=2; ${PRICE} - $FIFTEEN"| bc )
    # Add Sku to Name
    NAME=$(echo $NAME | sed "s/$/ - ${n}/" )
    if [[ ! -z $n ]]
    then
        FINAL=$(echo "\"$HANDLE\", \"$NAME\" , \"$DESCRIPTION\", \"Harley Davidson\", \"\" , , \"\", \"Title\", \"Default Title\", , , , , \"$n\", ,,,,,\"$VARPRICE\",\"$PRICE\"")
    fi
    if [[ ! -z $FINAL ]]
    then
        echo $FINAL
    fi
done

