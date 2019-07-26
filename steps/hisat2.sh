#!/bin/bash

set -xe

# check environment variables
if [ -z "$hisat2_index" ]; then
        echo Must set the variable hisat2_index to path of index
        exit 1
fi

# load module and save version
module load hisat2

date; hisat2 --version

# identify which filetype flag to use
if [[ $1 = *.fa ]] || [[ $1 = *.fa.* ]] || [[ $1 = *.fasta* ]]; then
        ext="-f"
elif [[ $1 = *.fq* ]] || [[ $1 = *.fastq* ]]; then
        ext="-q"
else
        echo Accepts only fasta or fastq files
        exit 1
fi

# run program
echo starting hisat2 - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	hisat2 $ext -x $hisat2_index -U $1 -S $name.sam
elif [ "$#" = 2 ]; then
	hisat2 $ext -x $hisat2_index -1 $1 -2 $2 -S $name.sam
else
	echo Accepts only one or two files - single or paired end reads
	exit 1
fi

echo finished hisat2 - $(basename "$1") $(basename "$2")

