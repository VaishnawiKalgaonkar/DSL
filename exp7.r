# Load libraries
library(caTools); library(Metrics); library(corrplot)

# Load data
data <- read.csv("C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.csv")

# Convert Stress_Level to numeric if it's categorical
# (e.g., "High"=3, "Medium"=2, "Low"=1 automatically)
data$Stress_Level <- as.numeric(as.factor(data$Stress_Level))

# Keep only numeric relevant columns
data <- na.omit(data[, c("Technology_Usage_Hours", "Sleep_Hours", "Stress_Level")])

# Split dataset
set.seed(123)
split <- sample.split(data$Stress_Level, SplitRatio = 0.7)
train <- subset(data, split)
test  <- subset(data, !split)

# Train linear regression model
model <- lm(Stress_Level ~ Technology_Usage_Hours + Sleep_Hours, data = train)
summary(model)

# Predict and evaluate
pred <- predict(model, newdata = test)

cat("MSE:", mse(test$Stress_Level, pred),
    "\nRMSE:", rmse(test$Stress_Level, pred),
    "\nMAE:", mae(test$Stress_Level, pred), "\n")

# Correlation Heatmap
corrplot(cor(data), method = "color", type = "upper",
         tl.col = "black", tl.srt = 45, addCoef.col = "black",
         col = colorRampPalette(c("red", "white", "blue"))(200))
