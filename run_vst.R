# This script is based on main_r.ipynb and is the bare-minimum needed to run the VST using DESeq2
# Example usage: Rscript --vanilla run_vst.R three_class_sample

# Process arguments
args = commandArgs(trailingOnly=TRUE)
dataset_name <- args[1] # e.g., label_1
project_dir <- args[2] # e.g., /data/BIDS-HPC/private/projects/dmi2

# Set variables and load libraries
library_file <- paste0(project_dir, "/checkout/target_class_lib.R")
cts_file <- paste0(project_dir, "/data/datasets/", dataset_name, "/gene_counts.tsv")
anno_file <- paste0(project_dir, "/data/datasets/", dataset_name, "/annotation.csv")
data_dir <- paste0(project_dir, "/data/datasets/", dataset_name)
library("DESeq2")
source(library_file)

# Load data exported from Python into a DESeqDataSet object
dds <- DESeqDataSetFromPython(cts_file=cts_file, anno_file=anno_file)

# Transform the loaded data as desired
vsd <- vst(dds, blind=FALSE)

# Export the data to read back into Python
saveData(vsd, "variance-stabilizing", data_dir)
