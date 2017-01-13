#!/bin/bash

datasetPath='../../Dataset/'
datasetName[0]='ASLO'
datasetName[1]='ZooScan'
datasetName[2]='Kaggle'
txtPath='./result/'

for (( k = 0; k < 3; k++ )); do
	imgPath=$datasetPath${datasetName[k]}
	if [[ -d ${datasetName[k]} ]]; then
		rm -r ${datasetName[k]}
	fi
	mkdir ${datasetName[k]}

	for i in $(ls $imgPath); do
		txtName=$i'Original.txt'
		if [[ -f ${datasetName[k]}/$txtName ]]; then
			rm ${datasetName[k]}/$txtName
		fi
		touch ${datasetName[k]}/$txtName
		for j in $(ls $imgPath/$i); do
			for m in $(ls $imgPath/$i/$j); do
				printf $j'\n' >> ${datasetName[k]}/$txtName
			done
		done
	done
done
