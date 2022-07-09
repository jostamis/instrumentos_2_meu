# Instrumentos de Análisis Urbano II
# MEU - UTDT

# Estudiante: TAMIS, Josefina

# Trabajo Práctico n° 1

# 0. Importar librerias

library(readr)
library(haven)
library(tidyverse)

# a. Importar una base de datos}

# Base de datos: Barrios Populares de Argentina
# .csv de Mapa de los barrios populares de Argentina registrados en el Registro Nacional de Barrios Populares actualizado al 16 de junio de 2022

barrios_populares <- read_csv(file =  "https://datosabiertos.desarrollosocial.gob.ar/dataset/0d022767-9390-486a-bff4-ba53b85d730e/resource/9a951270-60dd-4f21-aa19-4ef1205620bd/download/2022-05-15_info_publica.csv")

# b. Reconocimiento de la base

dim(barrios_populares)

# 5687, 17

names(barrios_populares)

head(barrios_populares)

summary(barrios_populares)

# Verificación de presencia de valores NA

apply(is.na(barrios_populares), 2, sum)

# La columna anio_de_creacion tiene un total de 4396 valores NA. En el resto de las variables su presencia no es significativa.

# c. Filtrar observaciones de la provincia de Buenos Aires

unique(barrios_populares$provincia)

barrios_populares_ba <- barrios_populares %>%
  filter(provincia == "Buenos Aires")

unique(barrios_populares_ba$provincia)

dim(barrios_populares_ba)

# 1933, 17

# d. Quitar de la base de datos las columnas provincia y anio_de_creacion

barrios_populares_ba <- barrios_populares_ba %>%
  select(-provincia, -anio_de_creacion)

dim(barrios_populares_ba)

# 1933, 15

#e. Generar una nueva columna de densidad de familias por superficie

barrios_populares_ba <- barrios_populares_ba %>%
  mutate(superficie_ha = superficie_m2/10000) %>%
  mutate(familias_ha = cantidad_familias_aproximada/superficie_ha) 

dim(barrios_populares_ba)

# 1933, 17

barrios_populares_ba <- arrange(barrios_populares_ba, desc(familias_ha))
 
head(barrios_populares_ba)

