# DS LAB 6B: Multiple Linear Regression

# Load library
library(caTools)

# Set working directory
setwd("C:/Users/Hp/OneDrive/Desktop")

# Import dataset
data <- read.csv("mental_health_and_technology_usage_2024.csv", header = TRUE)

# Train-test split
set.seed(123)
split <- sample.split(data$Sleep_Hours, SplitRatio = 0.8)
train <- subset(data, split == TRUE)
test <- subset(data, split == FALSE)

# Multiple Linear Regression (predict Sleep Hours using Technology Usage + Screen Time + Stress Level)
model_multi <- lm(Sleep_Hours ~ Technology_Usage_Hours + Screen_Time_Hours + Stress_Level, data = train)
print(summary(model_multi))

# Predict on test set
pred <- predict(model_multi, newdata = test)

# Evaluate performance (Mean Squared Error)
mse <- mean((test$Sleep_Hours - pred)^2, na.rm = TRUE)
print(paste("Mean Squared Error:", mse))
