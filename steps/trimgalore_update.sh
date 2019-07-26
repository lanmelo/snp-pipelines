#!/bin/bash

# identify if trimgalore output is gzipped
if [[ $file = *.gz ]]; then
        ext=".gz"
fi

# update $file and $file2 to trimgalore output
if [ -z "$file2" ]; then
        file=$trimgalore_out/$(basename "$file" | cut -d. -f1)_trimmed.fq"$ext"
else
        file=$trimgalore_out/$(basename "$file" | cut -d. -f1)_val_1.fq"$ext"
        file2=$trimgalore_out/$(basename "$file2" | cut -d. -f1)_val_2.fq"$ext"
fi

