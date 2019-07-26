#!/bin/bash

# define where your project is located
project_dir=..

# define where the pipeline results will be located
mkdir -p $project_dir/results
export results_dir=$project_dir/results

# define where the log files will be located
mkdir -p $project_dir/logs
export logs_dir=$project_dir/logs

# define the number of threads in a compute node
# see https://aws.amazon.com/ec2/instance-types/
export vCPU=1

# define required variables
export star_index=/shared/lib/indexes/star-grch38-97/
export rsem_index=/shared/lib/indexes/rsem-grch38-97/rsem-grch38-97

# run pipeline
pipeline=/path/to/pipeline.sh

while read line; do
	$pipeline $line
done < reads.txt

