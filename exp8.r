# Install (run once)
# install.packages(c("randomForest", "caret", "e1071", "dplyr", "ggplot2", "reshape2"))

# Load libraries
library(randomForest); library(caret); library(dplyr); library(ggplot2); library(reshape2)

# Load and prepare data
data <- na.omit(read.csv("C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.csv"))
data[c("Gender","Mental_Health_Status","Stress_Level",
       "Support_Systems_Access","Work_Environment_Impact","Online_Support_Usage")] <-
  lapply(data[c("Gender","Mental_Health_Status","Stress_Level",
                "Support_Systems_Access","Work_Environment_Impact","Online_Support_Usage")], as.factor)

# Train-test split
set.seed(123)
trainIndex <- createDataPartition(data$Stress_Level, p = 0.8, list = FALSE)
train <- data[trainIndex, ]; test <- data[-trainIndex, ]

# Multiple regression (Random Forest model)
predictors <- setdiff(names(data), c("User_ID", "Stress_Level"))
rf_model <- randomForest(Stress_Level ~ ., data = train[, c("Stress_Level", predictors)], ntree = 100)
pred <- predict(rf_model, test)

# Accuracy & performance metrics
conf <- confusionMatrix(pred, test$Stress_Level)
cat("\nAccuracy:", conf$overall["Accuracy"])
cat("\nPrecision:", round(mean(conf$byClass[,"Precision"], na.rm=TRUE),3))
cat("\nRecall:", round(mean(conf$byClass[,"Recall"], na.rm=TRUE),3))
cat("\nF1-Score:", round(mean(2*(conf$byClass[,"Precision"]*conf$byClass[,"Recall"]) /
                                (conf$byClass[,"Precision"]+conf$byClass[,"Recall"]), na.rm=TRUE),3), "\n")

# Central tendency & spread
num_data <- data %>% select_if(is.numeric)
cat("\nMean:\n"); print(colMeans(num_data))
cat("\nMedian:\n"); print(apply(num_data, 2, median))
cat("\nMode:\n"); print(apply(num_data, 2, function(x) names(sort(table(x), decreasing=TRUE))[1]))
cat("\nInterquartile Range (IQR):\n"); print(apply(num_data, 2, IQR))

# Entropy & Information Gain
entropy <- function(x){ p <- prop.table(table(x)); -sum(p * log2(p + 1e-9)) }
info_gain <- function(target, feature){
  overall <- entropy(target)
  weighted <- sum(sapply(unique(feature), function(v){
    s <- target[feature==v]; (length(s)/length(target))*entropy(s)
  }))
  overall - weighted
}
cat("\nEntropy of Stress_Level:", entropy(test$Stress_Level), "\n")
cat("\nInformation Gain:\n")
for(col in predictors[1:5]) { # limit to first 5 for brevity
  f <- train[[col]]; if(is.numeric(f)) f <- ifelse(f >= median(f), "High", "Low")
  cat(col, ":", round(info_gain(train$Stress_Level, f), 4), "\n")
}

# Correlation heatmap
corr <- cor(num_data, use="complete.obs")
ggplot(melt(corr), aes(Var1, Var2, fill=value)) +
  geom_tile(color="white") +
  scale_fill_gradient2(low="blue", high="red", mid="white", midpoint=0, limit=c(-1,1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  ggtitle("Correlation Heatmap of Numeric Variables")
