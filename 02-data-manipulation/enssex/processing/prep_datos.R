
#**************************************************************************
# 0. Identificación -------------------------------------------------------
# Título: Script de ejemplo preparación de datos (ejercicio ayudantía 2)
# Encargado: Martín Venegas Márquez - Ayudante
# Institución: Universidad Diego Portales - Doctorado Psicología
# Resumen: Ejemplo de un script para hacer una preparación de datos (en base a ej2)
#**************************************************************************

rm(list = ls()) # Elimina todo el ambiente

# 1. Cargar paquetes ------------------------------------------------------
# install.packages(pacman) # Solo instalar si no está instalado
pacman::p_load(tidyverse) # Cargar tidyverse

# 2. Cargar datos ---------------------------------------------------------

# OPCIÓN1: A través de la web
load(url("https://datos.gob.cl/dataset/c6983439-49f6-4e71-85fe-e8de6e73dae0/resource/ed81f50c-1c7d-43d9-9083-dfc161e0cd66/download/20240516_enssex_data.rdata"))

# OPCIÓN2: Se descarga y se carga desde el computador
# load("input/original/20240516_enssex_data.rdata")

# 3. Preparar datos -------------------------------------------------------
enssex_proc <- enssex4 %>% 
  select(edad = p4, sexo = p1, region, calidad_vida = p8, perc_salud = p10) %>% 
  mutate(
    edad_tramos = case_when(
      edad %in% 18:24 ~ "18-24",
      edad %in% 25:34 ~ "25-34",
      edad %in% 35:44 ~ "35-44",
      edad %in% 45:54 ~ "45-54",
      edad %in% 55:64 ~ "55-64",
      edad >= 65 ~ "65+"
      )
    ) %>% 
  filter(!edad_tramos %in% "18-24") %>% 
  group_by(region) %>% 
  mutate(media_perc_salud = mean(perc_salud)) %>% 
  ungroup() %>% 
  arrange(edad)
  
# 4. Guardar datos --------------------------------------------------------
saveRDS(enssex_proc, "input/proc/enssex_proc.RDS")
