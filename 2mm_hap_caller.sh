#!/bin/bash
#
#SBATCH -J 2mm_gvcf # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -p serial_requeue # Partition
#SBATCH --mem 12000 # Memory request
#SBATCH -t 0-8:00 # 8 hours (D-HH:MM)
#SBATCH -o staralign/2mm_gvcf_%A_%a.out # Standard output
#SBATCH -e staralign/2mm_gvcf_%A_%a.err # Standard error

sra_id=( `cat "sra.txt" `)

java -Xmx12g -jar /n/sw/fasrcsw/apps/Core/GenomeAnalysisTK/3.4.46-fasrc01/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /n/regal/pringle_lab/koleaz/mitosnps/nc12_mito_star.fa \
-I /n/regal/pringle_lab/koleaz/mitosnps/two_mismatch_star/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mm_split.bam \
-dontUseSoftClippedBases \
--emitRefConfidence GVCF \
-stand_call_conf 20.0 \
-stand_emit_conf 20.0 \
--sample_ploidy 1 \
-o /n/regal/pringle_lab/koleaz/mitosnps/gvcfs_2mm/"${sra_id[SLURM_ARRAY_TASK_ID]}"2mm.g.vcf
