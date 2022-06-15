#!/bin/bash
filename=$1
#status=0
linea=0
while read p; do 
    ((linea+=1))
    # echo "$line"
    if [[ "$p" =~ ^$ ]]; then
      #linea vuota: ignoro comunque
      echo "LINE $linea: IGNORE" > /dev/null
    elif [[ "$p" =~ \#+ ]]; then
      echo "LINE $linea: END_TR<<<<<<<<<<"
    else
     echo "$p"
    fi
done < $filename
