#!/bin/bash
#
#SBATCH -J stargen # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 8000 # Memory request
#SBATCH -t 0-8:00 # 8 hours (D-HH:MM)
#SBATCH --mail-type=BEGIN
#SBATCH --mail-user=kzimmerman@fas.harvard.edu
#SBATCH -o stargen_%A_%a.out # Standard output
#SBATCH -e stargen_%A_%a.err # Standard error

STAR --runThreadN 1 --runMode genomeGenerate \
--genomeDir /n/regal/pringle_lab/koleaz/mitosnps/genome_star/ \
--genomeFastaFiles /n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.fa \
--sjdbGTFfile /n/regal/pringle_lab/koleaz/mitosnps/nc12_mito.gtf \
--sjdbOverhang 35 \
--genomeSAindexNbases 11
