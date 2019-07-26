#!/bin/bash

set -xe

# check environment variables
if [ -z "$salmon_index" ]; then
        echo Must set the variable salmon_index to path of index
        exit 1
fi

# load module and save version
module load salmon

date; salmon --version

# run program
echo starting salmon - $(basename "$1") $(basename "$2")

if [ "$#" = 1 ]; then
	salmon quant -p $vCPU -i $salmon_index -l A -r $1 --validateMappings -o .
elif [ "$#" = 2 ]; then
	salmon quant -p $vCPU -i $salmon_index -l A -1 $1 -2 $2 --validateMappings -o .
else
	echo Accepts only one or two files - single or paired end reads
	exit 1
fi

echo finished salmon - $(basename "$1") $(basename "$2")
