library(ggplot2)
library(readxl)
library(tidyr)
library(envalysis)
library(dplyr)  # Make sure this is loaded for `select` and `rename`

# Load the data
file_path <- "E:/Term2/WERI/ML_Budyko/3- result/edit/fig5/Annual_change_Terra.xlsx"
data <- read_excel(file_path, sheet = "Sheet1")  # Specify the sheet if needed

# Delete unnecessary columns and rename others
data <- data %>%
  select(-c(def, pet)) %>%  # Delete unnecessary columns
  rename(
    AET = aet,      # Rename `aet` to `AET`
    P = pr,         # Rename `pr` to `P`
    TWSC = delta,   # Rename `delta` to `TWSC`
    EP = pr_delta,  # Rename `pr_delta` to `EP`
    R = ro          # Rename `ro` to `Q`
  )

# Reshape the data
data_long <- pivot_longer(data, cols = -Year, names_to = "Parameter", values_to = "Value")

# Create the plot
ggplot(data_long, aes(x = Year, y = Value, color = Parameter)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    x = "Year",
    y = "mm"
  ) +
  scale_x_continuous(
    breaks = seq(min(data$Year), max(data$Year), by = 5),  # Divide x-axis by 5 years
    limits = c(min(data$Year), max(data$Year))             # Set x-axis limits
  ) +
  theme_publish(base_size = 14) +  # Use theme_publish with base font size
  theme_bw() +  # Ensure a white background
  theme(
    legend.position = "right",       # Move legend to the right
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Centered title
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 11),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12),
    panel.background = element_rect(fill = "white", color = "black"),  # White panel background
    plot.background = element_rect(fill = "white", color = NA),  # White plot background
    panel.grid.major = element_line(color = "gray90"),  # Light gray grid
    panel.grid.minor = element_line(color = "gray95")
  )

# Print the plot
#print(p)

ggsave("E:/Term2/WERI/ML_Budyko/3- result/edit/fig5/Time_series_Terraclimate_1.png", width = 8, height = 6, dpi = 300)



