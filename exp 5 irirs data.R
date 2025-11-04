# EXPERIMENT 5 on IRIS dataset

# Load dataset
data(iris)

# Select only numeric columns
num_data <- iris[, 1:4]

# Correlation matrix
cor_matrix <- cor(num_data)
print(cor_matrix)

# Correlation Plot
install.packages("corrplot")   # run only once
library(corrplot)
corrplot(cor_matrix, method = "circle", type = "upper", tl.col = "black", tl.srt = 45)

# Covariance matrix
cov_matrix <- cov(num_data)
print(cov_matrix)

# Pairwise scatterplot with species colors
pairs(num_data, col = iris$Species, main = "Scatterplot Matrix of Iris Data")

# ANOVA: Does Sepal.Length differ by Species?
anova_result <- aov(Sepal.Length ~ Species, data = iris)
summary(anova_result)

# Another ANOVA on Petal.Length
anova_result2 <- aov(Petal.Length ~ Species, data = iris)
summary(anova_result2)

# ANCOVA: Sepal.Length explained by Sepal.Width + Species
ancova_result <- aov(Sepal.Length ~ Sepal.Width + Species, data = iris)
summary(ancova_result)


