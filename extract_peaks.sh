#!/bin/bash

for file in $(ls ./ | grep ".narrowPeak$")
do
  awk 'BEGIN{FS="\t"; OFS=FS} {print $1,$2,$3}' ${file} > ${file%%.*}.bed
done

cat *.bed | sort -k1,1 -k2,2n - | mergeBed -i - | sort -u - | \
            awk 'BEGIN{FS="\t"; OFS=FS} {print $1,$2,$3,"peaks_"FNR}' - > merged.peaks

for file in $(ls ./ | grep ".bed$")
do
  sort -k1,1 -k2,2n ${file} | bedtools intersect -a merged.peaks -b ${file} -wa | \
                              sort -u - > ${file%%.*}.peaks
done

rm *.bed
