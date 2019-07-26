#!/bin/bash

set -xe

# load module and save version
module load fastqc

date; fastqc --version

# run program
echo starting fastqc - $(basename "$1")

fastqc $1 -o .

echo finished fastqc - $(basename "$1") 
