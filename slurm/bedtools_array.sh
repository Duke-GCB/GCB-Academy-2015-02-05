#!/bin/bash
#
#SBATCH --output=output/bedtools_%A_%a.out
#SBATCH --error=output/bedtools_%A_%a.err # Standard error
#SBATCH --job-name=bedtools_array
#SBATCH --time=10:00
#SBATCH --mem=200
#SBATCH --array=0-4

inputs=(wgEncodeCshlShortRnaSeqA549CellCiptapContigs.bedRnaElements wgEncodeCshlShortRnaSeqA549CellContigs.bedRnaElements wgEncodeCshlShortRnaSeqA549CytosolCiptapContigs.bedRnaElements wgEncodeCshlShortRnaSeqA549CytosolContigs.bedRnaElements wgEncodeCshlShortRnaSeqA549NucleusContigs.bedRnaElements)

bed_file=${inputs[$TASK_ID]}
sorted_bed_file=$(basename $bed_file).sort.bed
srun sleep 30
srun sort -k1,1 -k2,2n ~/cshl_rna_seq/$bed_file > ~/cshl_rna_seq/$sorted_bed_file
srun /opt/apps/sdg/nextgen/tools/BEDTools-Version-2.16.2/bin/bedtools merge -i ~/cshl_rna_seq/$sorted_bed_file
