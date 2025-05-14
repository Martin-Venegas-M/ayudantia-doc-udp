
#**************************************************************************
# 0. Identificación -------------------------------------------------------
# Título: Manipulación de datos ayudantía 2
# Institucion: Doctorado UDP
# Encargado: Martín Venegas - Ayudante
# Resumen ejectivo: Código de ejemplo para manipulación de datos
#**************************************************************************

rm(list = ls()) # ELiminar todo el ambiente de trabajo (buena práctica)

# 1. Carga de paquetes ----------------------------------------------------

if(!require("pacman")) install.packages("pacman") # Si no está instalado "pacman", instalar

pacman::p_load(
  tidyverse,
  haven
  ) # Cargar tidyverse

# 2. Carga de datos -------------------------------------------------------

load(url("https://datos.gob.cl/dataset/c6983439-49f6-4e71-85fe-e8de6e73dae0/resource/ed81f50c-1c7d-43d9-9083-dfc161e0cd66/download/20240516_enssex_data.rdata"))

df <- enssex4 # Crear otro objeto con el nombre "df"

rm(enssex4) # Eliminar objeto original

# 3. Manipulación con R base ----------------------------------------------

names(df)

df_proc <- df[, c("folio_encuesta", "p1", "p3", "p4")] # Seleccionar folio, sexo al nacer, genero y edad

df_proc <- head(df_proc, n = 30) # Seleccionar las primeras 30 filas


# 3.1 Estructuras fundamentales -------------------------------------------

# Uso de $
df_proc$p1

# Uso de [[]]
df_proc[["p1"]]

# Uso de [,]
df_proc[1,1] # Primera fila de la primera columna


# 3.2 Estructuras poco prácticas ------------------------------------------

# with
with(df_proc, p1)
with(df_proc, p1*2)

# within
within(df_proc, edad2 <- p1*2)

# atach y detach

p1 # Llamemos a la edad
# Por qué no funciona?

attach(df_proc)

p1 # Ahora funciona

detach(df_proc)

p1 # Nuevamente no funciona

df_proc$p1 # Ahora si


# 4. Manipulación con tidyverse -------------------------------------------




