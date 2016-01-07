# Introduction
This readme describes the various shell scripts and commands used to
identify Single Nucleotide Variants from RNAseq data of _Neurospora
crassa_ strains in the nuclear and mitochondrial genome. This analysis
is for the paper (Beyond Animals and Plants: Dynamic Maternal Effects in
the Fungus Neurospora crassa)[] These scripts follow the (Broad
Institute's GATK RNAseq variant calling best
practices)[https://www.broadinstitute.org/gatk/guide/article?id=3891]

The shell scripts are listed in the order in which they should be run.

Most of these shell scripts \(with "_array_" appended to description\) are
made to be run as array jobs on a cluster using SLURM with the following
command \(for 21 strains\):

``` sbatch --array=0-20 shellscript.sh ```

# Repository Contents

SRA IDs for each strain used in the experiment 
[sra.txt](sra.txt)

Download SRA files and convert to fastq _array_
[batch_fastq.sh](batch_fastq.sh)

Generate genome index files (nuclear and mitochondrial sequences in one
file) 
[star_gen.sh](star_gen.sh)

Create sequence dictionary for variant calling _array_
[seq_dict_index.sh](seq_dict_index.sh)

Align reads to nuclear and mitochondrial genomes _array_
[star_align_2mm.sh](star_align_2mm.sh)

Sort alignments and mark duplicate reads _array_
[star_sort_markdup_2mm.sh](star_sort_markdup_2mm.sh)

split and CIGAR reads _array_ 
[split_cigar_2mm.sh](split_cigar_2mm.sh)

Identify variants in each strain, with options enabled for joint
genotyping. _array_ 
[2mm_hap_caller.sh](2mm_hap_caller.sh)

Identify variants in each strain and also call reference sites _array_
[2mm_hap_caller_allsites.sh](2mm_hap_caller_allsites.sh)

Identify variant sites based on data from all strains
[joint_genotyping_2mm.sh](joint_genotyping_2mm.sh)

Identify variant and reference sites based on data from all strains
[joint_genotyping_2mm_allsites.sh](joint_genotyping_2mm_allsites.sh)

Filtering commands to select variant sites that meet specified criteria
[filtering_selection_commands.txt](filtering_selection_commands.txt)

R script to plot mitochondrial variants and sequencing coverage.
[mito_coverage_plot.R](mito_coverage_plot.R)

Data for mitochondrial genome coverage plot
[10_or_more_snp_positions.csv](10_or_more_snp_positions.csv)
[mito_notations.csv](mito_notations.csv)
[2mm_joint_genotype_filtered_select10_all.csv](2mm_joint_genotype_filtered_select10_all.csv)
