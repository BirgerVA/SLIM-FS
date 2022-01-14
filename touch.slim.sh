#!/bin/bash
#[8][8][16]
#[SLIM-FS!][DISKSIZE][DISKLABEL]
#SLIM-FS!00000512New Volume
#[16][8][8]
#[filename][offset][size in bytes]
#DATEI 1         0000000000000000
#DATEI 2         0000000000000000
#?ATEI 3         0000000000000000
#DATEI 4         0000000000000000
#DATEI 5         0000000000000000
#DATEI 6         0000000000000000
#?ATEI 7         0000000000000000
#INDEX=1-32000
#DATA=32001..
filena="$1"
drive="$2"
filenam=$(echo -n "$filena" | tr [:lower:] [:upper:] | tr -d "\000\042\052\057\072\074\076\077\134\174")
spacer=''
for (( a=1; a<=$((16-${#filenam})) ; a++ ))
do
spacer="$spacer$(echo -n '?')"
done
filename="$filenam$spacer"
firstques=$(cat $drive | tr -d "\000" | fold -w 32 | cut -b 1 | grep -i -n "?" | head -n 1 | cut -d ":" -f 1 | tr -d "\n")
if [[ -z $firstques ]]
then
echo "INDEX IS FULL"
exit
fi
firstfree=$(($firstques*32-31))
echo "First free index-offset found by $firstfree"
offset="00000000"
size="00000000"
index="$filename$offset$size"
echo -n "$index" | dd conv=notrunc seek=$(($firstfree-1)) bs=1 of=$drive
echo "Inputname is: $filena"
echo "Filename is:  $filenam"
echo "File \"$filename\" created!"
#fold -w 32 | cut -b 1-16
#offsetint="0"
#magicstr=""
#echo "$magicstr" | dd bs="1" seek="$offsetint" of="$drive"
#((offsetint+=${#magicstr}))
#echo -n -e "$" | dd bs=1 seek=$offsetint "$drive"
#((offsetint+=${#}))
#clear
#drive="$1"
#offsetint="0"
