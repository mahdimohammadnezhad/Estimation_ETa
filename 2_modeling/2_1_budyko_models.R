library(devtools)
library(budyko)
library(readr)
library(ggplot2)
library(dplyr)
library(Metrics)
library(hydroGOF)

# Read the CSV file
data <- read_csv("E:/flux_ET_dataset/terra_climate/anomalydata.csv")


#"E:/flux_ET_dataset/terra_climate/data_basin.csv" 2.22
#"E:/flux_ET_dataset/terra_climate/data_monthly_basin.csv" 9.3
#"E:/flux_ET_dataset/terra_climate/New folder/anomalydata.csv" 4.1
#"E:/flux_ET_dataset/terra_climate/anomalydata.csv" 4.1
data <- data %>% rename(
  ET = aet,
  P = pr_delta,
  PET = pet
) %>% mutate(
  AET.P = ET / P,
  PET.P = PET / P
)


ogbudyko=budyko_sim()
blankBC+geom_line(data=ogbudyko)+coord_cartesian(xlim=c(0,5))

blankBC+geom_point(data=data)+coord_cartesian(xlim=c(0,5))


blankBC+
  geom_line(data=ogbudyko)+
  geom_point(data=data)+
  coord_cartesian(xlim=c(0,5))


fit1=budyko_fit(data=data,method="zhang",dif="mae",silent = TRUE) # Fu - turc-pike - wang-tang - zhang


sim1=budyko_sim(fit=fit1)

w_value <- round(as.numeric(fit1$`zhang`[1]), 2)

blankBC +
  geom_line(data = ogbudyko, aes(x = PET.P, y = AET.P), color = "red", size = 1) +
  geom_line(data = sim1, aes(x = PET.P, y = AET.P), color = "blue", size = 1) +
  geom_point(data = data, aes(x = PET.P, y = AET.P), color = "black") +
  annotate("text", x = 4, y = 0.5, label = paste0("W = ", w_value),
           size = 10, fontface = "bold", hjust = 0, vjust = 1,
           color = "black") +
  coord_cartesian(xlim = c(0, 5)) +
  ggtitle("Zhang's Equation at a LT Monthly Time Scale") + # Monthly Averaged - LT Monthly - Annual
  theme_minimal() +
  theme(
    axis.text = element_text(size = 16, face = "bold", color = "black"),
    axis.title = element_text(size = 16, face = "bold"),
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    panel.grid.major = element_line(color = "gray", size = 0.8),
    panel.grid.minor = element_line(color = "lightgray", size = 0.5),
    legend.position = "none"
  )
