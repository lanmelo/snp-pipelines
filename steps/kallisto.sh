#!/bin/bash

set -xe

# check environment variables
if [ -z "$kallisto_index" ]; then
        echo Must set the variable kallisto_index to path of index
        exit 1
fi

# load module and save version
module load kallisto

date; kallisto version

# run program
echo starting kallisto - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	kallisto quant --single -t $vCPU -i $kallisto_index -o . $1
elif [ "$#" = 2 ]; then
	kallisto quant -t $vCPU -i $kallisto_index -o . $1 $2
else
	echo Accepts only one or two files - single or paired end reads
	exit 1
fi

echo finished kallisto - $(basename "$1") $(basename "$2")
