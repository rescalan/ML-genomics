# Function to check and install packages from CRAN
install_cran_packages <- function(packages) {
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) {
    install.packages(new_packages)
  }
}

# Function to check and install packages from Bioconductor
install_bioc_packages <- function(packages) {
  if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) {
    BiocManager::install(new_packages)
  }
}

# List of packages needed from CRAN
cran_packages <- c(
  "dplyr",
  "tidyr",
  "ggplot2",
  "pheatmap",
  "parallel"
)

# List of packages needed from Bioconductor
bioc_packages <- c(
  "recount3",
  "GSVA",
  "GSVAdata",
  "msigdbr",
  "SummarizedExperiment"
)

# Install all required packages
cat("Installing CRAN packages...\n")
install_cran_packages(cran_packages)

cat("\nInstalling Bioconductor packages...\n")
install_bioc_packages(bioc_packages)


# load data ---------------------------------------------------------------


# Verify installations
cat("\nVerifying installations...\n")
all_packages <- c(cran_packages, bioc_packages)
installed_packages <- installed.packages()[,"Package"]
missing_packages <- all_packages[!(all_packages %in% installed_packages)]

if(length(missing_packages) == 0) {
  cat("\nAll packages successfully installed!\n")
} else {
  cat("\nWarning: The following packages could not be installed:\n")
  cat(paste(missing_packages, collapse = ", "), "\n")
}

# Load all packages to verify they work
cat("\nLoading packages to verify functionality...\n")
tryCatch({
  library(recount3)
  library(GSVA)
  library(GSVAdata)
  library(msigdbr)
  library(SummarizedExperiment)
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(pheatmap)
  cat("\nAll packages loaded successfully!\n")
}, error = function(e) {
  cat("\nError loading packages:", e$message, "\n")
})

# Print session info for reproducibility
cat("\nSession information:\n")
sessionInfo()
