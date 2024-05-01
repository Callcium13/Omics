#!/bin/bash

#SBATCH --job-name=default_cpu_job
#SBATCH --output=default_cpu_job.out
#SBATCH --error=default_cpu_job.err

#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=3400

echo "Hello World" 

