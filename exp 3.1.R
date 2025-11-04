# Install and load required packages
if(!require(xlsx)) install.packages("xlsx", dependencies = TRUE)
if(!require(XML)) install.packages("XML", dependencies = TRUE)

library(utils)
library(xlsx)
library(XML)

# --- Set your dataset path ---
dataset_path <- "C:\\Users\\Hp\\OneDrive\\Desktop\\mental_health_and_technology_usage_2024.csv"

# --- Check if file exists ---
if (!file.exists(dataset_path)) {
  stop("Dataset not found at path: ", dataset_path)
}

# --- Read the dataset ---
data <- read.csv(dataset_path)
cat("Dataset loaded successfully!\n\n")

# --- Display basic info ---
cat("Number of rows:", nrow(data), "\n")
cat("Number of columns:", ncol(data), "\n\n")
cat("Column names:\n")
print(colnames(data))

# --- Save as a cleaned output copy ---
output_path <- "C:/Users/Hp/Downloads/mental_health_and_technology_usage_2024_output.csv"
write.csv(data, output_path, row.names = FALSE)

cat("\nDataset successfully saved as:", output_path, "\n")

# --- Preview first few rows ---
cat("\nPreview of the dataset:\n")
print(head(data))
