#!/bin/bash
#
#SBATCH -J fastqBatch # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 4000 # Memory request
#SBATCH -t 0-2:00 # 2 hours (D-HH:MM)
#SBATCH -o fastq_%A_%a.out # Standard output
#SBATCH -e fastq_%A_%a.err # Standard error

sra_id=( `cat "sra.txt" `)

fastq-dump -O /n/regal/pringle_lab/koleaz/mitosnps "${sra_id[SLURM_ARRAY_TASK_ID]}" 

