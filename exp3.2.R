if(!require(xlsx)) install.packages("xlsx", dependencies = TRUE)
if(!require(XML)) install.packages("XML", dependencies = TRUE)
library(utils)
library(xlsx)
library(XML)

# CSV
csv_file <- "C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.csv"
if(file.exists(csv_file)){
  csv_data <- read.csv(csv_file)
  write.csv(csv_data, "C:/Users/Hp/OneDrive/Desktop/output_csv.csv", row.names = FALSE)
}

# Web CSV
web_csv <- read.csv("https://people.sc.fsu.edu/~jburkardt/data/csv/airtravel.csv")
write.csv(web_csv, "C:/Users/Hp/OneDrive/Desktop/web_output.csv", row.names = FALSE)

# Web TXT
web_txt <- read.table("https://people.sc.fsu.edu/~jburkardt/data/csv/hw_200.csv", header = TRUE, sep = ",")
write.table(web_txt, "C:/Users/Hp/OneDrive/Desktop/web_output.txt", row.names = FALSE, sep = ",")

# Excel (only if exists)
excel_file <- "C:/Users/Hp/OneDrive/Desktop/mental_health_and_technology_usage_2024.xlsx"
if(file.exists(excel_file)){
  excel_data <- read.xlsx(excel_file, sheetIndex = 1)
  write.csv(excel_data, "C:/Users/Hp/OneDrive/Desktop/excel_output.csv", row.names = FALSE)
}

# XML (only if exists)
xml_file <- "C:/Users/Hp/OneDrive/Desktop/sample.xml"
if(file.exists(xml_file)){
  xml_data <- xmlParse(xml_file)
  xml_root <- xmlRoot(xml_data)
  xml_df <- xmlToDataFrame(xml_root)
  write.csv(xml_df, "C:/Users/Hp/OneDrive/Desktop/xml_output.csv", row.names = FALSE)
}
