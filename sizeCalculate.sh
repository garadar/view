#!/bin/bash
workFile=/home/sizeFolder

du /home/ -h --apparent-size |grep user>$workFile
declare -A tab

c=0
while read ligne;do
	user=$(echo $ligne|awk '{print $2}')
	size=$(echo $ligne|awk '{print $1}')
	tab[$c]="$size-$user"
	c=$((c+1))
done<$workFile

#	echo "array Before"
for i in ${!tab[*]};do
	ikey=$(echo ${tab[$i]}|awk -F "-" '{print $1}')
	iuser=$(echo ${tab[$i]}|awk -F "-" '{print $2}')
#	echo $i : $iuser : $ikey
done

for i in $(seq 0 $((${#tab[*]}-1)) );do
	
	max=$i
	for j in $(seq $((i+1)) ${#tab[*]});do
		ikey=$(echo ${tab[$max]}|awk -F "M-" '{print $1}')
		jkey=$(echo ${tab[$j]}|awk -F "M-" '{print $1}')
		if [ $ikey -lt $jkey ]
		then
			max=$j
		fi
	done
	tmp=${tab[$i]}
	tab[$i]=${tab[$max]}
	tab[$max]=$tmp
done

#	echo "array After"
for i in ${!tab[*]};do
	ikey=$(echo ${tab[$i]}|awk -F "-" '{print $1}')
	iuser=$(echo ${tab[$i]}|awk -F "-" '{print $2}')
	echo $i : $iuser : $ikey
done
