#!/bin/bash

set -x

# check environment variables
if [ -z "$bwa_index" ]; then
        echo Must set the variable bwa_index to path of index
        exit 1
fi

# load module and save version
module load bwa

date; bwa 2>&1

# calling "bwa" returns an exit code of 1
set -e

# run program
echo starting bwa - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	bwa mem -t $vCPU $bwa_index $1 > $name.sam
elif [ "$#" = 2 ]; then
	bwa mem -p -t $vCPU $bwa_index $1 $2 > $name.sam
else
	echo Accepts only one or two files - single or paired end reads
	exit 1
fi

echo finished bwa - $(basename "$1") $(basename "$2")

