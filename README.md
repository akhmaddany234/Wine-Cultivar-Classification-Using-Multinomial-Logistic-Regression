
# 🍷 Wine Cultivar Classification using Multinomial Logistic Regression

This project implements a **Multinomial Logistic Regression** model using R to classify wine cultivars based on their chemical properties. The dataset is sourced from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/wine), containing 13 numeric features derived from the analysis of Italian wines grown in the same region but from three different cultivars.

## Dataset
The dataset includes features such as:
- Alcohol
- Malic Acid
- Ash
- Alcalinity of Ash
- Magnesium
- Total phenols
- Flavanoids
- Nonflavanoid phenols
- Proanthocyanins
- Color Intensity
- Hue
- OD280/OD315 of diluted wines
- Proline

The target variable is the `class` of the wine (cultivar 1, 2, or 3).

## Features
- Data preprocessing: checking duplicates, missing values, and correlation matrix.
- Visualization: correlation heatmap and scatter plot of Alcohol vs Color Intensity by class.
- Modeling:
  - Multinomial logistic regression with 1 IV (`Alcohol`)
  - Multinomial logistic regression with multiple IVs
- Interpretations:
  - Relative log-odds
  - Relative risk ratios
  - Marginal effects
- Model evaluation: Confusion Matrix using `caret`

## Libraries Used
- `readr`, `dplyr`, `ggplot2`, `corrplot` for data handling and visualization
- `nnet` for multinomial logistic regression
- `broom`, `kableExtra` for tidy output formatting
- `marginaleffects`, `checkmate` for marginal effect analysis
- `caret` for classification evaluation

#
## Author
Nuraisi Maba Alhuda – 23031554054
Akhmad Dany – 23031554234
Moh Annas Shobari – 23031554241
Rizki Wahyu Widodo – 23031554242
