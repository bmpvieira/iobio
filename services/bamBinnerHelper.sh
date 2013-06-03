#!/bin/bash

bamtools="/Users/chase/Tools/qbamtools/bin/qbamtools"
region=$1;

#/Users/chase/Tools/qbamtools/bin/qbamtools convert -format json -in <(samtools view -u http://s3.amazonaws.com/1000genomes/data/HG00096/alignment/HG00096.chrom11.ILLUMINA.bwa.GBR.low_coverage.20111114.bam 11:108473-188673)

cmd="" 

for i in ${@:2}
do   
   cmd=$cmd" -in <(samtools view -u $i $region)"
done

# cmd="-in <(samtools view -u http://s3.amazonaws.com/1000genomes/data/HG00096/alignment/HG00096.chrom11.ILLUMINA.bwa.GBR.low_coverage.20111114.bam 11:108473-188673)"
min=$(echo $region | grep -oP '(?<=\d:)\d+(?=-\d+)')
max=$(echo $region | grep -oP '(?!.*-)\d+')

cmd=$bamtools" merge "$cmd" | "$bamtools" coverage | cut -f3 |./binner.sh $min $max 100"
eval $cmd
