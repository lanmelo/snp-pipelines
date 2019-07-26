#!/bin/bash

set -xe

# check environment variables
if [ -z "$bowtie_index" ]; then
	echo Must set the variable bowtie_index to path of index
        exit 1
fi

# load module and save version
module load bowtie

date; bowtie --version

# run program
echo starting bowtie - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	bowtie -p $vCPU $bowtie_index $1 -S $name.sam
elif [ "$#" = 2 ]; then
	bowtie -p $vCPU $bowtie_index -1 $1 -2 $2 -S $name.sam	
else
	echo Accepts only one or two files - single or paired end reads
	exit 1
fi

echo finished bowtie - $(basename "$1") $(basename "$2")
