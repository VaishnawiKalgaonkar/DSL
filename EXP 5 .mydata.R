# --- Load the dataset ---
data <- read.csv("C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.csv")

# --- Convert Yes/No values to numeric (1 and 0) ---
data[data == "Yes"] <- 1
data[data == "No"]  <- 0

# --- Convert character or factor columns to numeric ---
data[] <- lapply(data, function(x) {
  if (is.character(x) || is.factor(x)) {
    as.numeric(as.factor(x))
  } else {
    x
  }
})

# --- Compute the correlation matrix ---
M <- cor(data, use = "pairwise.complete.obs")

# --- Install and load corrplot if not already installed ---
if(!require(corrplot)) install.packages("corrplot", dependencies = TRUE)
library(corrplot)

# --- Generate the correlation heatmap ---
corrplot(M,
         method = "square",       # Type of visualization
         type = "upper",          # Show only upper triangle
         tl.col = "black",        # Text color for labels
         tl.srt = 45,             # Rotate labels by 45 degrees
         addCoef.col = "black",   # Display correlation values
         number.cex = 0.6)        # Text size for numbers

cat("\nCorrelation plot generated successfully!\n")
