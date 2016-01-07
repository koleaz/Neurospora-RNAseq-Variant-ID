#!/bin/bash
#
#SBATCH -J stargen # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 4000 # Memory request
#SBATCH -t 0-8:00 # 8 hours (D-HH:MM)
#SBATCH --mail-type=BEGIN
#SBATCH --mail-user=kzimmerman@fas.harvard.edu
#SBATCH -o staralign/staralign_%A_%a.out # Standard output
#SBATCH -e staralign/staralign_%A_%a.err # Standard error

sra_id=( `cat "sra.txt" `)

cd /n/regal/pringle_lab/koleaz/mitosnps/

STAR --runMode alignReads \
--runThreadN 1 \
--genomeDir /n/regal/pringle_lab/koleaz/mitosnps/genome_star/ \
--readFilesIn /n/regal/pringle_lab/koleaz/mitosnps/"${sra_id[SLURM_ARRAY_TASK_ID]}".fastq \
--outSAMattrRGline ID:"${sra_id[SLURM_ARRAY_TASK_ID]}" SM:"${sra_id[SLURM_ARRAY_TASK_ID]}" \
--outSAMmapqUnique 60 \
--outFilterMismatchNmax 2 \
--outFileNamePrefix /n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mm