#!/bin/sh

printhelp()
{
   echo ""
   echo "Usage: $0 {infile}"
   exit 1
}

if [ -z "$1" ]
then
    echo "ERROR: missing infile"
    printhelp
fi

bs64=$(base64 -w 0 "$1")
fname=$(basename "$1")
ext="${fname##*.}"
extlo=`echo "$ext" | tr '[:upper:]' '[:lower:]'`

if [ $extlo = jpg ] || [ $extlo = jpeg ]
then
    dat="jpeg"
elif [ $extlo = png ]
then
    dat="png"
elif [ $extlo = gif ]
then
    dat="gif"
fi

echo "<img src=\"data:image/$dat;base64,$bs64\">"
