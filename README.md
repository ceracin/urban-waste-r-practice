# Urban Waste Trends in Switzerland (R Practice)

This repository contains an R project developed as a learning exercise to practice data import, cleaning, summarization, and visualization using real-world data from Swiss cities.

## Data

The dataset comes from the Swiss Federal Statistical Office (FSO), Urban Waste Statistics (2025), downloaded from [opendata.swiss](https://opendata.swiss/fr/dataset/siedlungsabfalle4).  

The original Excel file contains merged cells and non-standard headers and required cleaning before analysis.

## Objective

The goal of this project is to:

- Import and clean raw Excel data  
- Summarize waste generation by decade  
- Visualize global and per-capita waste trends using `ggplot2`  

This project does not aim to provide causal analysis or policy evaluation, but demonstrates a reproducible data workflow.

## Repository Structure
```
urban-waste-r-practice/
├── urban_waste.R # Optional R script version of workflow
├── urban_waste_trend.Rmd # Main R Markdown file generating plots
├── README.md # Project overview and instructions
└── data/
    └── urban_waste_data.xls # Excel dataset (OFS)
```
## Reproducing the Analysis

Clone this repository and open `urban_waste_trend.Rmd` in RStudio.  

Knit the R Markdown file to HTML to reproduce the plots.  

The Excel dataset `urban_waste_data.xls` is included in the `data/` folder, and the `here()` function ensures it is imported from this location.

## Author

Cécile Racine
