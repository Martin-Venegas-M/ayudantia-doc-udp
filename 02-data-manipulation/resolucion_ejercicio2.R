
#**************************************************************************
# 0. Identificación -------------------------------------------------------
# Título: Resolución ejercicio ayudantía 2 (paso a paso)
# Encargado: Martín Venegas Márquez - Ayudante
# Institución: Universidad Diego Portales - Doctorado Psicología
# Resumen: Código de uso de dplyr para resolución ejercicio 2
#**************************************************************************

# Cargar paquetes
# install.packages(pacman) # Solo instalar si no está instalado
pacman::p_load(tidyverse) # Cargar tidyverse

# (1) Cargue el set de datos de la Encuesta Nacional de Salud, Sexualidad y Género 2023
load(url("https://datos.gob.cl/dataset/c6983439-49f6-4e71-85fe-e8de6e73dae0/resource/ed81f50c-1c7d-43d9-9083-dfc161e0cd66/download/20240516_enssex_data.rdata"))

# (2) Seleccione las variables de edad (p4), sexo (p1), región (region), calidad de vida (p8), percepción de salud (p10). Use select().
enssex_proc <- enssex4 %>% select(p4, p1, region, p8, p10) 

# (3) Renombre las variables escogidas por nombres más sustantivos. Use rename().
enssex_proc <- enssex_proc %>% rename(edad = p4, sexo = p1, calidad_vida = p8, perc_salud = p10)

# (4) Cree una nueva variable llamada edad_tramos, siguiendo los tramos de 18-24, 25-34, 35-44, 45-54, 55-54, +64 años. Use mutate() y case_when().
enssex_proc <- enssex_proc %>% mutate(
  edad_tramos = case_when(
    edad %in% 18:24 ~ "18-24",
    edad %in% 25:34 ~ "25-34",
    edad %in% 35:44 ~ "35-44",
    edad %in% 45:54 ~ "45-54",
    edad %in% 55:64 ~ "55-64",
    edad >= 65 ~ "65+"
    )
  )

# (5) Filtre el dataset por los individuos que no se encuentren en el tramo de 18-24 años. Use filter().
enssex_proc <- enssex_proc %>% filter(!edad_tramos %in% "18-24")

# (6) Genere una tabla con la media de las percepciones de salud a nivel región y guárdela en un nuevo objeto. Use group_by(), summarise() y ungroup().
medias_region <- enssex_proc %>% group_by(region) %>% summarise(media_perc_salud = mean(perc_salud))

# (7) Haga un join entre el dataset a nivel de personas y la tabla de la media de percepción de salud por región. Utilice left_join
enssex_proc <- enssex_proc %>% left_join(medias_region, by = "region")

# (8) Ordene las filas del dataset por edad ascendente. Utilice arrange()
enssex_proc <- enssex_proc %>% arrange(edad)
