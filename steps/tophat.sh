#!/bin/bash

set -xe

# check environment variables
if [ -z "$bowtie2_index" ]; then
        echo Must set the variable bowtie2_index to path of index
        exit 1
fi

# load module and save version
module load python/2.7.16 bowtie2 samtools tophat

date; tophat --version

# run program
echo starting tophat - $(basename "$1") $(basename "$2")

tophat -p $vCPU -o . -G $gtf $bowtie2_index $1 $2

echo finished tophat - $(basename "$1") $(basename "$2")
