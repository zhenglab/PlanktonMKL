#!/bin/bash
pathName='./featuresFunction/IDSC/template'
outTxt='./ZooScan/Template.txt'

if [[ -f $outTxt ]]; then
	rm $outTxt
fi
touch $outTxt
for i in $(ls $pathName); do
	for j in $(ls $pathName/$i); do
			printf $pathName/$i/$j'\n' >> $outTxt
	done
done
