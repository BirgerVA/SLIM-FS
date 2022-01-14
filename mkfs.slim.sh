#!/bin/bash
label="$1"
disk="$2"
dd status=progress if=/dev/zero of="$disk"
dsklab=$(echo -n "$label" | tr [:lower:] [:upper:] | tr ' ' '_' | tr -d "\000\042\052\057\072\074\076\077\134\174" | head -c 16)
spaces=''
for (( a=1; a<=$((16-${#dsklab})) ; a++ ))
do
spaces="$spaces$(echo -n ' ')"
done
disklabel="$dsklab$spaces"
dsksiz=$(lsblk -n -b -o SIZE "$disk" | tr -d '\n')
nulls=''
for (( a=1; a<=$((8-${#dsksiz})) ; a++ ))
do
nulls="$nulls$(echo -n '0')"
done
disksize="$nulls$dsksiz"
echo -n -e "SLIM-FS!$disksize$disklabel" | dd status=none conv=notrunc bs=1 of="$disk"
for i in {1..999}
do
echo -n -e "?" | dd status=none conv=notrunc seek=$(($i*32)) bs=1 of="$disk"
((i++))
done
echo "Disklabel is $dsklab"
echo "Disksize  is $dsksiz"
echo "mkslimfs done"
exit
#echo -n -e "SLIM-FS!$disksize$disklabel?               0000000000000000" | dd conv=notrunc bs=1 of=$1
#echo -n 'DATA-SECTION' | dd status=none conv=notrunc seek=32000 bs=1 of=$disk
