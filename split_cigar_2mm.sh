#!/bin/bash
#
#SBATCH -J 2mm_split # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 8000 # Memory request
#SBATCH -t 0-8:00 # 8 hours (D-HH:MM)
#SBATCH -o staralign/2mmsplit_%A_%a.out # Standard output
#SBATCH -e staralign/2mmsplit_%A_%a.err # Standard error

sra_id=( `cat "sra.txt" `)

java -Xmx6g -jar /n/sw/fasrcsw/apps/Core/GenomeAnalysisTK/3.4.46-fasrc01/GenomeAnalysisTK.jar \
-T SplitNCigarReads \
-R /n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.fa \
-I /n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmSTAR_dedupped.bam \
-o /n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mm_split.bam \
-U ALLOW_N_CIGAR_READS
