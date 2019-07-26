#!/bin/bash

set -xe

# check environment variables
if [ -z "$star_index" ]; then
        echo Must set the variable star_index to path of index
        exit 1
fi

# load module and save version
module load star

date; STAR --version

# run program
echo starting star - $(basename "$1") $(basename "$2")

if [[ $1 = *.gz ]]; then
	STAR --runThreadN $vCPU --genomeDir $star_index --quantMode TranscriptomeSAM --readFilesCommand gunzip -c --readFilesIn $1 $2
else
	STAR --runThreadN $vCPU --genomeDir $star_index --quantMode TranscriptomeSAM --readFilesIn $1 $2
fi

echo finished star - $(basename "$1") $(basename "$2")

