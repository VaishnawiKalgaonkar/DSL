# DS LAB 6A: Sampling, Covariance, Correlation, Deviation, Linear Regression

# Load libraries
library(caTools)

# Set working directory (change if needed)
setwd("C:/Users/Hp/OneDrive/Desktop")

# Import dataset
data <- read.csv("mental_health_and_technology_usage_2024.csv", header = TRUE)

# Sampling (80% training, 20% testing)
set.seed(123)
split <- sample.split(data$Technology_Usage_Hours, SplitRatio = 0.8)
train <- subset(data, split == TRUE)
test <- subset(data, split == FALSE)

# Covariance between Technology Usage and Screen Time
cov_val <- cov(train$Technology_Usage_Hours, train$Screen_Time_Hours, use = "complete.obs")
print(paste("Covariance:", cov_val))

# Correlation between Technology Usage and Sleep Hours
cor_val <- cor(train$Technology_Usage_Hours, train$Sleep_Hours, use = "complete.obs")
print(paste("Correlation:", cor_val))

# Deviation (standard deviation)
sd_val <- sd(train$Technology_Usage_Hours, na.rm = TRUE)
print(paste("Standard Deviation:", sd_val))

# Linear Regression (predicting Sleep Hours from Technology Usage)
model <- lm(Sleep_Hours ~ Technology_Usage_Hours, data = train)
print(summary(model))

# Plot regression
plot(train$Technology_Usage_Hours, train$Sleep_Hours, col = "blue", pch = 19,
     xlab = "Technology Usage Hours", ylab = "Sleep Hours",
     main = "Linear Regression: Technology Usage vs Sleep Hours")
abline(model, col = "red", lwd = 2)
