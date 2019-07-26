#!/bin/bash

set -xe

# check environment variables
if [ -z "$gtf" ]; then
        echo Must set the variable gtf to path of annotation
        exit 1
fi

# load module and save version
module load subread

date; featureCounts -v

# run program
echo starting featurecounts - $(basename "$1")

featureCounts -T $vCPU -a $gtf -o counts.txt $1

echo finished featurecounts - $(basename "$1")

