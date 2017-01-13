#!/bin/bash
pathName='../../1ImagePreprocessing/ASLO/result/ASLOBinarySquare'
# extension='png'
dirName='ASLO/'

if [[ ! -d  $dirName ]]; then
	mkdir $dirName
fi

for i in $(ls $pathName); do
	txtName='./ASLO/'$i'ASLOBinary.txt'
	if [ -f $txtName ]; then
		rm $txtName
	fi
	touch $txtName
	for j in $(ls $pathName/$i); do
		for m in $(ls $pathName/$i/$j); do
			# if [ ${m##*.} == ${extension} ]; then
				printf $pathName/$i/$j/$m'\n' >> $txtName
			# fi
		done
	done
done