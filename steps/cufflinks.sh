#!/bin/bash

set -x

# check environment variables
if [ -z "$gtf" ]; then
        echo Must set the variable gtf to path of annotation
        exit 1
fi

# load module and save version
module load python/2.7.16 cufflinks

date; cufflinks 2>&1 | head -n 2

# calling "cufflinks" returns an exit code of 1
set -e

# run program
echo starting cufflinks - $(basename "$1")

cufflinks -v -p $vCPU -g $gtf $1

echo finished cufflinks - $(basename "$1")

