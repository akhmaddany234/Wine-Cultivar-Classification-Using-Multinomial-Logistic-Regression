#============================== PREPROCESSING ================================
library(readr)
library(dplyr)
library(caret)
library(ggplot2)
library(corrplot)
install.packages("caret")

# Load data
data_wine <- read.csv("C:/Users/lenovo/OneDrive/Documents/SEMESTER 4/Analisis Multivariat/P11/Terbaru/whine.csv", header = TRUE, check.names = TRUE)
head(data_wine)
# 1. Cek duplikat untuk mengecek apakah data sudah independen
duplicate_rows <- data_wine %>% duplicated() %>% sum()
cat("Jumlah duplikat:", duplicate_rows, "\n")

# Jumlah missing value per kolom
colSums(is.na(data_wine))

# 2. Hitung matriks korelasi (tanpa kolom class) untuk mengetahui fitur yang memiliki korelasi tinggi
numeric_data <- data_wine %>% select(-class)
corr_matrix <- cor(numeric_data, use = "complete.obs")

# menampilkan heatmap korelasi
corrplot(
  corr_matrix, 
  method = "color",   # pakai warna gradasi
  type = "full",     # hanya tampilkan bagian atas
  addCoef.col = "black", # kasih angka di dalam kotak (warna hitam)
  tl.col = "black",   # warna label (nama fitur)
  tl.srt = 45,        # putar label sumbu x 45 derajat
  number.cex = 0.7    # ukuran teks angka di kotak
)

table(data_wine$class)
data_wine$class <- data_wine$class - 1
table(data_wine$class)


#======================== MULTINOMIAL LOGISTIC REGRESSION ===========================
head(data_wine)

library(tidyverse)
# --- Pastikan Target sebagai Faktor ---
data_wine1 <- data_wine %>%
  mutate(
    class = factor(class, 
                       labels = c("cultur 1",
                                  "cultur 2",
                                  "cultur 3")))

str(data_wine)

ggplot(data_wine1, aes(x = Alcohol, y = Color_intensity, color = class)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal()

#Multinomial with 1 IV
library("nnet")
fit_wine <- multinom(class ~ Alcohol, data = data_wine1)

#Summary log odds interpret
summary(fit_wine)

#or
library("broom")
library("kableExtra")

tidy(fit_wine, conf.int = TRUE) %>%
  kable() %>%
  kable_styling("basic", full_width = FALSE)


##---Multinomial with Multiple IV----
fit_full <- multinom(class ~ Alcohol + Malicacid + Color_intensity + Proline, data = data_wine)

##---1. Interpret for the relative log odds----
summary(fit_full)
#or
tidy(fit_full, conf.int = TRUE) %>%
  kable() %>%
  kable_styling("basic", full_width = FALSE)

##---2. Interpret for the relative risk ratios----
exp(coef(fit_full))
#or
tidy(fit_full, conf.int = TRUE, exponentiate = TRUE) %>%
  kable() %>%
  kable_styling("basic", full_width = FALSE)

##---3. Interpret for the marginal effect----
library("marginaleffects")
library("checkmate")
install.packages("marginaleffects")
install.packages("checkmate")

mfx_fit_full <- avg_comparisons(fit_full, type = "probs")
mfx_fit_full

library(caret)

pred <- predict(fit_full, newdata = data_wine)
confusionMatrix(pred, data_wine$class)
