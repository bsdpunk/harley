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
   BROAD=$(grep '[A-Z]\.' b.txt -A2 -B2)
   #LIST=$(grep '[A-Z]\.' b.txt -A2 -B2 | grep -o '^[0-9]\{7,8\}')
   #LIST=$(grep '[A-Z]\.' b.txt -A2 -B2 | grep -o '^[0-9]\{7,8\}' | sort | uniq)
   LIST=$(grep '[A-Z]\.' h.txt -A2 -B2 | grep -o '^[0-9]\{7,8\}' | sort | uniq | tail -n740)

   for n in $(cat <(echo $LIST) )
   do
   #PN=$( echo $BROAD |  grep -o '^[0-9]\{7,8\}' )
   #PN=$(head -n1 <(grep -o '^[0-9]\{7,8\}' b.txt))
   #head -n1 <(grep 'A\.' <(clear;cat xa$ibk | grep -A1 'A\.'))) ;
   NAME=$( grep "$n" h.txt -A2 -B2 |  grep '[A-Z]\.'  | grep '[A-Z]\. [A-Z -]\+[a-z]' -o  | gsed 's/  //g' | gsed 's/A\. //' | cut -d' ' -f1-4 | head -n1 | sed 's/^[A-Z]\. //')
   HANDLE=$( grep "$n" h.txt -A2 -B2 | grep '[A-Z]\.'  | grep '[A-Z]\. [A-Z -]\+[a-z]' -o  | gsed 's/  //g' | gsed 's/A\. //' | cut -d' ' -f1-4 | head -n1 | sed 's/^[A-Z]\. //' | tr '[A-Z]' '[a-z]' | sed 's/ /-/g' | sed "s/$/-${n}/" )
   DESCRIPTION=$( grep "$n" b.txt  -B1 | grep '[A-E]\.' | sed 's/^[A-Z]\. //' | gsed 's/^[A-Z ]\+\([A-Z][a-z]\)/\1/' | sed 's/"//g')
   #grep 'A\.' b.txt -A2 -B2 | grep '^A.*\.$' -A2 | grep "$PN" -B2 | head -n1)
   #NAME=$(grep 'A\.' b.txt | grep 'A\. [A-Z -]\+[a-z]' -o  | sed 's/  //g'| sed 's/A\. //' | cut -d' ' -f1-4 )
   #grep 'A\.' b.txt | grep -v '[a-z]' | gsed 's/^A\. //g')
   if [[ ! -z $n ]]
   then
#   echo 'hey'\
   FINAL=$(echo "\"$HANDLE\", \"$NAME\" , \"$DESCRIPTION\", \"Harley Davidson\", ")
   fi
      if [[ ! -z $FINAL ]]
   then
        echo $FINAL
    fi
    done

