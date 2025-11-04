# Load required libraries
library(ggplot2)   # For plotting
library(dplyr)     # For data wrangling

# Read your dataset (full path with forward slashes)
data <- read.csv("C:/Users/Hp/Downloads/DS DATASET/mental_health_and_technology_usage_2024.csv")

# Quick view
head(data)
str(data)


boxplot(as.numeric(factor(data$Stress_Level)) ~ data$Gender,
        main = "Boxplot of Stress Level by Gender",
        xlab = "Gender", ylab = "Stress Level (Numeric)",
        col = c("lightblue", "lightgreen"))

plot(data$Screen_Time_Hours, data$Sleep_Hours,
     main = "Scatter Plot of Screen Time vs Sleep Hours",
     xlab = "Screen Time (hrs)", ylab = "Sleep Hours",
     col = "blue", pch = 19)

hist(data$Screen_Time_Hours,
     main = "Histogram of Screen Time",
     xlab = "Screen Time (hrs)", col = "skyblue", border = "black")

barplot(table(data$Stress_Level),
        main = "Bar Chart of Stress Levels",
        col = c("lightblue", "orange", "pink"),
        ylab = "Count")

gender_counts <- table(data$Gender)
pie(gender_counts,
    main = "Pie Chart of Gender Distribution",
    col = c("pink", "lightblue"))



