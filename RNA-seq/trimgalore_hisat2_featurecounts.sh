#!/bin/bash

# check arguments
if [ "$#" != 2 ] && [ "$#" != 3 ]; then
        echo Expects the name of the read followed by one or two files - single or paired end reads
        exit 1
fi

# create variables
export name=$1
file=$2
file2=$3
steps=/shared/pipelines/steps

# create output directories
source $steps/results_dir.sh fastqc trimgalore hisat2 featurecounts

# fastqc - untrimmed
for x in $file $file2; do
        sbatch --export=ALL -J "$name"_fastqc -D $fastqc_out -o $logs_dir/%x_%j.out \
		$steps/fastqc.sh $x
done

# trimgalore
trimgalore_jid=$(sbatch --export=ALL -J "$name"_trimgalore -D $trimgalore_out -o $logs_dir/%x_%j.out \
	$steps/trimgalore.sh $file $file2 | cut -d ' ' -f 4)

# identify if trimgalore output is gzipped
if [[ $file = *.gz ]]; then
        ext=".gz"
fi

# update $file and $file2 to trimgalore output
if [ -z "$file2" ]; then
        file=$trimgalore_out/$(basename "$file" | cut -d. -f1)_trimmed.fq"$ext"
else
        file=$trimgalore_out/$(basename "$file" | cut -d. -f1)_val_1.fq"$ext"
        file2=$trimgalore_out/$(basename "$file2" | cut -d. -f1)_val_2.fq"$ext"
fi

# fastqc - trimmed
for x in $file $file2; do
        sbatch --export=ALL -J "$name"_fastqc_trim -D $fastqc_out -o $logs_dir/%x_%j.out \
                -d afterok:$trimgalore_jid $steps/fastqc.sh $x
done

# hisat2
hisat2_jid=$(sbatch --export=ALL -J "$name"_hisat2 -D $hisat2_out -o $logs_dir/%x_%j.out \
       	-d afterok:$trimgalore_jid $steps/hisat2.sh $file $file2 | cut -d ' ' -f 4)

# featurecounts
sbatch --export=ALL -J "$name"_featurecounts -D $featurecounts_out -o $logs_dir/%x_%j.out \
       	-d afterok:$hisat2_jid $steps/featurecounts.sh $hisat2_out/$name.sam

