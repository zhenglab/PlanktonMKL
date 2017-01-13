#!/bin/bash
pathName='../../1ImagePreprocessing/ASLO/result/ASLOSquare'
extension='png'
dirName='ASLO/'

if [[ ! -d  $dirName ]]; then
	mkdir $dirName
fi

for i in $(ls $pathName); do
	txtName='./ASLO/'$i'ASLO.txt'
	if [ -f $txtName ]; then
		rm $txtName
	fi
	touch $txtName
	classNum=1
	for j in $(ls $pathName/$i); do
		for m in $(ls $pathName/$i/$j); do
			if [ ${m##*.} == ${extension} ]; then
				printf $pathName/$i/$j/$m'\t' >> $txtName
				printf $j'\t' >> $txtName
				printf $classNum'\n' >> $txtName
			fi
		done
		((classNum+=1))
	done
done