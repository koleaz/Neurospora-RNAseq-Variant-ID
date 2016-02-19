#################################################
#mitochondrial genome site calling coverage plot#
#################################################

library("stringr")
library("ggplot2")

# Read in data for plot. 
# Reference and variant sites called across 10 or more strains
mito_coverage<-read.csv("2mm_joint_genotype_filtered_select10_all.csv", stringsAsFactors = FALSE)
#Coordinates of exons in mitochondrial genome
exons <- read.csv("mito_notations.csv", stringsAsFactors = F)
#Variant sites
snps <- read.csv("10_or_more_snp_positions.csv", stringsAsFactors = F)

# Extract Allele number (number of strains in which nucleotide was called) from VCF "INFO" column
mito_coverage$AN<-str_extract(mito_coverage$INFO, "(?<=AN=)..(?=;)")
mito_coverage$AN <- as.numeric(mito_coverage$AN)

#Specify location of exon ring
exons$yend <- 24
exons$ystart <- 24

#Specify loaction of variant sites ring
snps_ac <- merge(mito_coverage, snps, by.x="POS", by.y="pos")
snps$y<-snps_ac$AN

#Plot Allele Number across mitochondrial genome
ggplot(mito_coverage, aes(x=POS, y=AN)) + 
geom_point(size=1)  +
coord_polar() +   
  scale_y_continuous(limits=c(-50, 30), #specify y limits to force plotted region to outside of circle 
                     breaks=c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21)) + 
  scale_x_continuous(breaks =c(0, 10000, 20000, 30000, 40000, 50000, 60000))+
  expand_limits(x=0) + #enforces inclusion of 0 in position labels
  geom_point(aes(x=POS, y=28), size=1) + # ring showing sites with coverage in 10 or more strains
  theme_bw() + 
  theme(panel.grid.major.x = element_line(color="darkgray")) +
  geom_segment(aes(x=Start, xend=End, y=ystart, yend=yend, size=5),  colour="blue", data=exons)+ #plot exons as segments
  geom_point(aes(x=pos, y=y), color="orange", shape=8, data=snps, size=3) #plot variant sites as stars

ggsave("mitochondrial_coverage.pdf", width = 7, height = 7, units = "in", useDingbats=F)
ggsave("mitochondrial_coverage.tiff", width = 7, height = 7, units = "in")

