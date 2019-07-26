#!/bin/bash

set -xe

# load module and save version
module load cutadapt trimgalore

date; trim_galore --version

# run program
echo starting trimgalore - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	trim_galore -q 30 -j $vCPU $1
elif [ "$#" = 2 ]; then
	trim_galore -q 30 --paired -j $vCPU $1 $2
else
	echo Accepts only one or two files - single or paired end reads
	exit 1
fi

echo finished trimgalore - $(basename "$1") $(basename "$2")
