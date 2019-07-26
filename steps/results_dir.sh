#!/bin/bash

for program in "$@"; do
	mkdir -p $results_dir/$program/$name
	declare "$program"_out=$results_dir/$program/$name
done

