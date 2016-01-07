#!/bin/bash
#
#SBATCH -J dict # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 8000 # Memory request
#SBATCH -t 0-2:00 # 8 hours (D-HH:MM)
#SBATCH -o staralign/dict_%A_%a.out # Standard output
#SBATCH -e staralign/dict_%A_%a.err # Standard error

java -Xmx6g -jar $CLASSPATH/CreateSequenceDictionary.jar \
R=/n/regal/pringle_lab/koleaz/mitosnps/mito.fa \
O=/n/regal/pringle_lab/koleaz/mitosnps/mito.dict

java -Xmx6g -jar $CLASSPATH/CreateSequenceDictionary.jar \
R=/n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.fa \
O=/n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.dict

cd /n/regal/pringle_lab/koleaz/mitosnps/
samtools faidx /n/regal/pringle_lab/koleaz/mitosnps/mito.fa
samtools faidx /n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.fa