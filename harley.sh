#!/bin/bash - 
#===============================================================================
#
#          FILE: harley.sh
# 
#         USAGE: ./harley.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/04/2017 15:17
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#head -n1 <(grep -o '^[0-9]\{7,8\}' xa$i)
#head -n1 <(grep 'A\.' <(clear;cat xa$i | grep -A1 'A\.')
#grep '^[0-9]\{7,\}' xa$i | ggrep -P '$\d+\.\d+' | head -n1 | ggrep -o -P '[a-zA-Z]+.*'

#PN=head -n1 <(grep 'A\.' <(clear;cat xa$i | grep -A1 'A\.'))

for i in {a..z}; 
do
   echo ''
   PN=$(head -n1 <(grep 'A\.' <(clear;cat xa$i | grep -A1 'A\.'))) ;
   echo 'hey'
   grep $PN xa$i | ggrep -P '$\d+\.\d+' | head -n1 | ggrep -o -P '[a-zA-Z]+.*'; 
   echo ''
done
