#!/bin/bash

set -xe

# check environment variables
if [ -z "$adapter" ]; then
	echo "Must set the variable adapter to the name of the adapter"
	exit 1
fi

# load module and save version
module load trimmomatic

date; trimmomatic -version

# run program
echo starting trimmomatic - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	trimmomatic SE -threads $vCPU $1 -baseout $name.fq \
		ILLUMINACLIP:$adapter:2:30:10 SLIDINGWINDOW:4:15
elif [ "$#" = 2 ]; then
	trimmomatic PE -threads $vCPU $1 $2 -baseout $name.fq \
		ILLUMINACLIP:$adapter:2:30:10 SLIDINGWINDOW:4:15
else
	echo "Accepts only one or two files (single or paired end reads)"
	exit 1
fi

echo finished trimmomatic - $(basename "$1") $(basename "$2")

