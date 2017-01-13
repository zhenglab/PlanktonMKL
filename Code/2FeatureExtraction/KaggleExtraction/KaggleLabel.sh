#!/bin/bash
pathName='../../1ImagePreprocessing/Kaggle/result/KaggleNonoise'
extension='png'
dirName='Kaggle/'
if [[ ! -d  $dirName ]]; then
	mkdir $dirName
fi

txtName='./Kaggle/Kaggle.txt'
if [ -f $txtName ]; then
	rm $txtName
fi
touch $txtName
classNum=1
for i in $(ls $pathName); do
	if [ ! -d "$pathName/$i" ]; then
		break
	fi
	for j in $(ls $pathName/$i); do
		if [ ${j##*.} == ${extension} ]; then
			printf $pathName/$i/$j'\t' >> $txtName
			printf $i'\t' >> $txtName
			printf $classNum'\n' >> $txtName
		fi
	done
	((classNum+=1))
done