# --- Install once ---
install.packages(c("caret", "randomForest", "e1071", "ggplot2", "dplyr"))

# --- Load libraries ---
library(caret)
library(randomForest)
library(e1071)
library(ggplot2)
library(dplyr)

# --- Load and prepare data ---
df <- read.csv("C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.csv")

# Remove unnecessary columns and convert categorical data
df <- df %>%
  select(-User_ID) %>%
  mutate(across(where(is.character), as.factor)) %>%
  na.omit()

# --- Split data (70% train, 30% test) ---
set.seed(123)
trainIndex <- createDataPartition(df$Mental_Health_Status, p = 0.7, list = FALSE)
train <- df[trainIndex, ]
test  <- df[-trainIndex, ]

# --- Train Random Forest Model ---
model <- randomForest(Mental_Health_Status ~ ., data = train, importance = TRUE)

# --- Predict on test set ---
pred <- predict(model, test)

# --- Evaluate performance ---
conf <- confusionMatrix(pred, test$Mental_Health_Status)
print(conf)

# Display core metrics
cat("\nAccuracy :", round(conf$overall["Accuracy"], 3))
cat("\nPrecision:", round(mean(conf$byClass[,"Precision"], na.rm = TRUE), 3))
cat("\nRecall   :", round(mean(conf$byClass[,"Recall"], na.rm = TRUE), 3))
cat("\nF1-score :", round(mean(conf$byClass[,"F1"], na.rm = TRUE), 3), "\n")

# --- Feature Importance Plot ---
varImpPlot(model, main = "Feature Importance (Random Forest)")
