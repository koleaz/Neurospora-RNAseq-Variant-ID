#!/bin/bash
#
#SBATCH -J 2mm_jg # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 16000 # Memory request
#SBATCH -t 0-12:00 # 12 hours (D-HH:MM)
#SBATCH -o staralign/2mm_jgall.out # Standard output
#SBATCH -e staralign/2mm_jgall.err # Standard error

cd /n/regal/pringle_lab/koleaz/mitosnps/gvcfs_2mm/

java -Xmx16g -jar /n/sw/fasrcsw/apps/Core/GenomeAnalysisTK/3.4.46-fasrc01/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.fa \
--variant /n/regal/pringle_lab/koleaz/mitosnps/gvcfs_2mm/2mm_vcfs_allsites.list \
-o /n/home01/kzimmerman/mito_fastqs/2mm_joint_genotype_allsites.vcf \
--includeNonVariantSites
