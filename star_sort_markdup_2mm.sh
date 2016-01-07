#!/bin/bash
#
#SBATCH -J 2mm_sort # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 8000 # Memory request
#SBATCH -t 0-8:00 # 8 hours (D-HH:MM)
#SBATCH -o staralign/sort_dup_%A_%a.out # Standard output
#SBATCH -e staralign/sort_dup_%A_%a.err # Standard error

sra_id=( `cat "sra.txt" `)

samtools view -hu \
/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmAligned.out.sam > \
/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmAligned.out.bam

samtools sort \
/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmAligned.out.bam \
/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmSTARsorted

samtools index -b \
/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmSTARsorted.bam

java -Xmx6g -jar $CLASSPATH/MarkDuplicates.jar \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=10 \
INPUT=/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmSTARsorted.bam \
OUTPUT=/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmSTAR_dedupped.bam \
METRICS_FILE=/n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star"${sra_id[SLURM_ARRAY_TASK_ID]}"2mmSTARsortedMF.txt \
CREATE_INDEX=true
