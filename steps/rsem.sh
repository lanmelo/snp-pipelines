#!/bin/bash

set -xe

# check environment variables
if [ -z "$rsem_index" ]; then
        echo Must set the variable rsem_index to path of index
        exit 1
fi

# load module and save version
module load rsem

date; rsem-calculate-expression --version

# run program
echo starting rsem - $(basename "$1")

if [ "$2" = "paired" ]; then
	rsem-calculate-expression --paired-end --alignments -p $vCPU --bam $1 $rsem_index $name
else
	rsem-calculate-expression --alignments -p $vCPU --bam $1 $rsem_index $name
fi

echo finished rsem - $(basename "$1")

