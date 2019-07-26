#!/bin/bash

# update $file and $file2 to trimmomatic output
if [ -z "$file2" ]; then
        file=$trimgalore_out/"$name".fq
else
        file=$trimmomatic_out/"$name"_1P.fq
        file2=$trimmomatic_out/"$name"_2P.fq
fi

