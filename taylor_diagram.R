library(plotrix)
library(readr)
library(openair)
data <- read_csv("C:/Users/acer/Desktop/result/taylor/ml_train_21Apr.csv")
# "E:/flux_ET_dataset/ml_2Nov_train.csv"
# "E:/Term2/WERI/ML_Budyko/3- result/edit/budyko/ml_20Jan_train.csv"

TaylorDiagram(data, obs = "observed", mod = "simulated", group = "model", main = "Calibration", mar = c(2, 2, 2, 2))

