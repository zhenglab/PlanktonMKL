#!/bin/bash
pathName='./featuresFunction/IDSC/template'
outTxt='./ASLO/Template.txt'

if [[ -f $outTxt ]]; then
	rm $outTxt
fi
touch $outTxt
for i in $(ls $pathName); do
	
	for j in $(ls $pathName/$i); do
		for m in $(ls $pathName/$i/$j); do
			printf $pathName/$i/$j/$m'\n' >> $outTxt
		done	
	done
done