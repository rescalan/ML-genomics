# Load required libraries
library(fs)
library(glue)
library(here)

# Function to create R Markdown content
create_rmd_content <- function(image_files) {
  header <- '---
title: "Image Slideshow"
output: ioslides_presentation
---

'
  
  slides <- sapply(image_files, function(img) {
    glue('
## {tools::file_path_sans_ext(basename(img))}

![]({{img}})
')
  })
  
  paste0(header, paste(slides, collapse = "\n"))
}

# Set the directory where your images are located
image_dir <- here::here("class_2_PCA_UMAP/class_2_SVD_PCA_UMAP_images/")

# Get all image files (adjust extensions as needed)
image_files <- dir_ls(image_dir, regexp = "\\.(jpg|jpeg|png|gif)$")

# Create R Markdown content
rmd_content <- create_rmd_content(image_files)

# Write R Markdown file
writeLines(rmd_content, "image_slideshow.Rmd")

# Render the R Markdown file (uncomment to automatically render)
# rmarkdown::render("image_slideshow.Rmd")

cat("R Markdown file 'image_slideshow.Rmd' has been created.\n")
cat("You can now open and render this file in RStudio or using rmarkdown::render().\n")

