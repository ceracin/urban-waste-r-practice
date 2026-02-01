library(dplyr)
library(readxl)
library(ggplot2)
library(here)

# 1. Import data
urban_waste_raw <- read_excel(here("data", "urban_waste_data.xls"))

# 2. Rename columns
urban_waste_clean_columns_names <- urban_waste_raw %>%
  rename(
    year = "Siedlungsabfälle 1)",
    mio_tonnes_all = "...2",
    kg_inhabitant_all = "...3",
    mio_tonnes_collected = "...4",
    kg_inhabitant_collected = "...5",
    mio_tonnes_other = "...6",
    kg_inhabitant_other = "T 02.03.02.10"
  )

# 3. Keep only relevant rows (9:62 in the Excel file)
urban_waste_clean_rows <- urban_waste_clean_columns_names %>%
  mutate(year = as.numeric(year)) %>%
  drop_na(year)

# 4. Clean data types and decimals
urban_waste_clean <- urban_waste_clean_rows %>%
  mutate(
    year = as.integer(year),
    mio_tonnes_all = round(as.numeric(mio_tonnes_all), 2),
    kg_inhabitant_all = round(as.numeric(kg_inhabitant_all), 2),
    mio_tonnes_collected = round(as.numeric(mio_tonnes_collected), 2),
    kg_inhabitant_collected = round(as.numeric(kg_inhabitant_collected), 2),
    mio_tonnes_other = round(as.numeric(mio_tonnes_other), 2),
    kg_inhabitant_other = round(as.numeric(kg_inhabitant_other), 2)
  )

# 5. Summarize total and individual mean waste production by decade
urban_waste_decade <- urban_waste_clean %>%
  group_by(decade = (year %/% 10) * 10) %>%
  summarise(
    mean_total_waste_mt = mean(mio_tonnes_all),
    mean_inhabitant_kg = mean(kg_inhabitant_all)
  )

# 6. Plot 1: visualize trend in Swiss global waste production
total_waste_trend <- ggplot(
  data = urban_waste_decade
) +
  geom_point(mapping = aes(
    x = decade,
    y = mean_total_waste_mt,
    color = decade,
    size = factor(decade)
  )) +
  geom_line(mapping = aes(
    x = decade,
    y = mean_total_waste_mt
  ), color = "steelblue") +
  labs(
    title = "Global Waste Generation in Switzerland", x = "Decade", y = "Mean Total Waste (million tonnes)",
    subtitle = "Continuous Increase since the 1970s", caption = "Source: Swiss Federal Statistical Office (FSO), Urban Waste Statistics, 2025"
  ) + theme(plot.caption = element_text(size = 8)) +
  annotate("text",
    x = 2015, y = 5.5, label = "Flatter increase",
    fontface = "bold",
    color = "steelblue",
    size = 3
  )

print(total_waste_trend)

ggsave("total_waste_trend.png")

# 7. Plot 2: visualize trend in Swiss individual waste production
individual_waste_trend <- ggplot(
  data = urban_waste_decade
) +
  geom_point(mapping = aes(
    x = decade,
    y = mean_inhabitant_kg,
    color = decade,
    size = factor(decade)
  )) +
  geom_line(mapping = aes(
    x = decade,
    y = mean_inhabitant_kg
  ), color = "steelblue") +
  labs(
    title = "Per-Capita Waste Generation in Switzerland",
    x = "Decade",
    y = "Mean Waste per Inhabitant (kg)",
    subtitle = "Stabilisation After 2000", caption = "Source: Swiss Federal Statistical Office (FSO), Urban Waste Statistics, 2025"
  ) +
  annotate("text",
    x = 2015, y = 660, label = "Decrease",
    fontface = "bold",
    color = "steelblue",
    size = 3
  )

print(individual_waste_trend)

ggsave("individual_waste_trend")
