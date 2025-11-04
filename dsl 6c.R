# DS LAB 6C: Logistic Regression

# Load library
library(caTools)

# Set working directory
setwd("C:/Users/Hp/OneDrive/Desktop")

# Import dataset
data <- read.csv("mental_health_and_technology_usage_2024.csv", header = TRUE)

# Convert Mental_Health_Status to factor (Good=1, Poor=0 or similar)
data$Mental_Health_Status <- as.factor(data$Mental_Health_Status)

# Train-test split
set.seed(123)
split <- sample.split(data$Mental_Health_Status, SplitRatio = 0.8)
train <- subset(data, split == TRUE)
test <- subset(data, split == FALSE)

# Logistic Regression (predicting Mental Health Status from Technology Usage + Sleep + Stress)
model_log <- glm(Mental_Health_Status ~ Technology_Usage_Hours + Sleep_Hours + Stress_Level,
                 data = train, family = binomial)
print(summary(model_log))

# Predict probabilities
pred_prob <- predict(model_log, newdata = test, type = "response")

# Convert to binary (threshold 0.5)
pred_class <- ifelse(pred_prob > 0.5, 1, 0)

# Confusion matrix
table(Predicted = pred_class, Actual = test$Mental_Health_Status)
