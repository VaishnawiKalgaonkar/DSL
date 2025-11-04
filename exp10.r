# Install & Load Required Packages
packages <- c("cluster", "factoextra", "ggplot2", "dplyr")
lapply(packages, function(p) if (!require(p, character.only=TRUE)) install.packages(p))
lapply(packages, library, character.only=TRUE)

#  Load and Prepare Data
data <- read.csv("C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.csv")
data <- na.omit(data)
num_data <- scale(data[sapply(data, is.numeric)])

#  (a, d) Find Optimal Clusters
fviz_nbclust(num_data, kmeans, method="wss") + ggtitle("Elbow Method")
fviz_nbclust(num_data, kmeans, method="silhouette") + ggtitle("Silhouette Method")

#  (a) Apply K-Means Clustering
set.seed(123)
k <- 3
km <- kmeans(num_data, centers=k, nstart=25)
data$KMeans_Cluster <- as.factor(km$cluster)

#  (b) Visualize Clusters
fviz_cluster(km, data=num_data, geom="point", ellipse.type="norm", 
             palette="jco", ggtheme=theme_minimal())

#  (a, b) Hierarchical Clustering
hc <- hclust(dist(num_data), method="ward.D2")
plot(hc, main="Hierarchical Clustering Dendrogram", xlab="", sub="")
data$HC_Cluster <- as.factor(cutree(hc, k))

#  (c) Cluster Summaries — Interpret Differences
cat("\nK-Means Cluster Sizes:\n"); print(table(data$KMeans_Cluster))
cat("\nHierarchical Cluster Sizes:\n"); print(table(data$HC_Cluster))

cat("\nCluster-wise Averages (K-Means):\n")
print(aggregate(num_data, by=list(Cluster=data$KMeans_Cluster), FUN=mean))

#  (c) Example: Compare Distribution of One Variable
boxplot(num_data[,1] ~ data$KMeans_Cluster,
        main=paste("Distribution of", colnames(num_data)[1], "by Cluster"),
        xlab="Cluster", ylab=colnames(num_data)[1])

cat("\n Clustering completed successfully!\n")


