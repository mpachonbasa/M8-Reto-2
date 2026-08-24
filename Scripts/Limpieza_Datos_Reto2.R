
# MÓDULO 8 - RETO 2
# Limpieza y preparación de datos
# Autora: Mónica Pachón Basallo


# NOTA:
# Las recodificaciones utilizadas en este script
# reproducen exactamente las aplicadas en
# "Código para el Reto 1.Rmd".
# -----------------------------------------------------
# 1. Carga de paquetes
# -----------------------------------------------------

# dplyr: manipulación de datos
# readr: importación y exportación de archivos csv
# tidyr: transformación y reestructuración de datos

library(dplyr)
library(readr)
library(tidyr)

# -----------------------------------------------------
# 2. Importación de datos
# -----------------------------------------------------

# Se carga la base de datos original de la
# European Social Survey Round 6 (ESS6).

estudio <- read_csv(
  "Datos/ESS6e02_7.csv",
  show_col_types = FALSE
)

# -----------------------------------------------------
# 2.1 Comprobación inicial
# -----------------------------------------------------

# Se revisa la estructura general de la base.

glimpse(estudio)

# Número de filas y columnas.

dim(estudio)


# -----------------------------------------------------
# 3. Selección de variables de interés
# -----------------------------------------------------

# Se conservan únicamente las variables necesarias
# para el proyecto de bienestar subjetivo.

vars <- c(
  "idno",
  "cntry",
  "anweight",
  "happy",
  "sclmeet",
  "inprdsc",
  "sclact",
  "health",
  "pstvms",
  "fltdpr",
  "slprl",
  "enjlf",
  "fltpcfl",
  "fltanx",
  "dclvlf",
  "accdng",
  "dngval",
  "tmdotwa",
  "sedirlf",
  "gndr",
  "yrbrn",
  "agea",
  "icpart1",
  "chldhhe",
  "dvrcdeva",
  "domicil",
  "eisced",
  "mnactic",
  "hincsrca",
  "hincfel"
)

# Creación de una base reducida únicamente
# con las variables seleccionadas.

df_dep <- estudio %>%
  select(any_of(vars))

# Comprobación de la base reducida

glimpse(df_dep)

dim(df_dep)


# -----------------------------------------------------
# 4. Limpieza de valores perdidos
# -----------------------------------------------------

# En ESS existen distintos códigos especiales para
# respuestas perdidas, rechazo a responder o
# desconocimiento de la respuesta.
#
# Estos códigos se transforman en NA para facilitar
# los análisis posteriores.

df_dep <- df_dep %>%
  mutate(
    
    # Escalas 0-10 con códigos 77, 88 y 99
    
    across(
      c(happy),
      ~ replace(.x, .x %in% c(77, 88, 99), NA_real_)
    ),
    
    across(
      c(sclmeet),
      ~ replace(.x, .x %in% c(77, 88, 99), NA_real_)
    ),
    
    across(
      c(inprdsc, tmdotwa, sedirlf),
      ~ replace(.x, .x %in% c(77, 88, 99), NA_real_)
    ),
    
    # Variables ordinales con códigos 7, 8 y 9
    
    across(
      c(
        sclact,
        health,
        pstvms,
        fltdpr,
        slprl,
        enjlf,
        fltpcfl,
        fltanx,
        dclvlf,
        accdng,
        dngval,
        hincfel
      ),
      ~ replace(.x, .x %in% c(7, 8, 9), NA_real_)
    ),
    
    # Variables demográficas
    
    across(
      c(yrbrn),
      ~ replace(.x, .x %in% c(7777, 8888, 9999), NA_real_)
    ),
    
    across(
      c(agea),
      ~ replace(.x, .x %in% c(999), NA_real_)
    ),
    
    across(
      c(gndr, icpart1),
      ~ replace(.x, .x %in% c(9), NA_real_)
    ),
    
    across(
      c(chldhhe),
      ~ replace(.x, .x %in% c(6, 7, 8, 9), NA_real_)
    ),
    
    across(
      c(dvrcdeva),
      ~ replace(.x, .x %in% c(7, 8, 9), NA_real_)
    ),
    
    across(
      c(domicil),
      ~ replace(.x, .x %in% c(7, 8, 9), NA_real_)
    ),
    
    across(
      c(eisced),
      ~ replace(.x, .x %in% c(0, 55, 77, 88, 99), NA_real_)
    ),
    
    across(
      c(mnactic),
      ~ replace(.x, .x %in% c(66, 77, 88, 99), NA_real_)
    ),
    
    across(
      c(hincsrca),
      ~ replace(.x, .x %in% c(77, 88, 99), NA_real_)
    )
    
  )

# Comprobación rápida de la estructura

glimpse(df_dep)

# -----------------------------------------------------
# 5. Recodificación de variables
# -----------------------------------------------------

# Se crean variables categóricas con etiquetas
# comprensibles para facilitar la interpretación
# de resultados y visualizaciones posteriores.

df_rec <- df_dep %>%
  mutate(
    
    # Sexo
    
    gndr_num = case_when(
      gndr == 1 ~ 1,
      gndr == 2 ~ 2,
      TRUE ~ NA_real_
    ),
    
    gndr = factor(
      gndr_num,
      levels = c(1, 2),
      labels = c("Hombre", "Mujer")
    ),
    
    # Convivencia en pareja
    
    icpart1_num = case_when(
      icpart1 == 1 ~ 1,
      icpart1 == 2 ~ 2,
      TRUE ~ NA_real_
    ),
    
    icpart1 = factor(
      icpart1_num,
      levels = c(1, 2),
      labels = c("Sí", "No")
    ),
    
    # Hijos en el hogar
    
    chldhhe_num = case_when(
      chldhhe == 1 ~ 1,
      chldhhe == 2 ~ 2,
      TRUE ~ NA_real_
    ),
    
    chldhhe = factor(
      chldhhe_num,
      levels = c(1, 2),
      labels = c("Sí", "No")
    ),
    
    # Divorcio
    
    dvrcdeva_num = case_when(
      dvrcdeva == 1 ~ 1,
      dvrcdeva == 2 ~ 2,
      TRUE ~ NA_real_
    ),
    
    dvrcdeva = factor(
      dvrcdeva_num,
      levels = c(1, 2),
      labels = c("Sí", "No")
    ),
    
    # Tipo de residencia
    
    domicil = factor(
      domicil,
      levels = 1:5,
      labels = c(
        "Gran ciudad",
        "Suburbios o afueras",
        "Ciudad o pueblo pequeño",
        "Pueblo rural",
        "Granja o casa en el campo"
      )
    ),
    
    # Educación
    
    eisced = factor(
      eisced,
      levels = 1:7,
      labels = c(
        "Menos que secundaria inferior",
        "Secundaria inferior",
        "Secundaria superior (nivel bajo)",
        "Secundaria superior (nivel alto)",
        "Formación avanzada / subgrado",
        "Terciaria inferior / grado",
        "Terciaria superior / máster+"
      ),
      ordered = TRUE
    ),
    
    # Actividad principal
    
    mnactic = factor(
      mnactic,
      levels = 1:9,
      labels = c(
        "Trabajo remunerado",
        "Educación",
        "Desempleado busca trabajo",
        "Desempleado no busca trabajo",
        "Enfermo/discapacitado",
        "Jubilado",
        "Servicio comunitario/militar",
        "Tareas domésticas/cuidado",
        "Otro"
      )
    ),
    
    # Fuente principal de ingresos
    
    hincsrca = factor(
      hincsrca,
      levels = 1:8,
      labels = c(
        "Salarios",
        "Autónomo",
        "Agricultura",
        "Pensiones",
        "Subsidio desempleo",
        "Otras ayudas sociales",
        "Ahorros/inversiones",
        "Otras fuentes"
      )
    ),
    
    # Percepción de ingresos (invertida)
    
    hincfel_num = case_when(
      hincfel == 1 ~ 4,
      hincfel == 2 ~ 3,
      hincfel == 3 ~ 2,
      hincfel == 4 ~ 1,
      TRUE ~ NA_real_
    ),
    
    hincfel = factor(
      hincfel_num,
      levels = c(1, 2, 3, 4),
      labels = c(
        "Mucha dificultad",
        "Dificultad",
        "Satisface",
        "Muy satisfecho"
      ),
      ordered = TRUE
    ),
    
    # Salud percibida (invertida)
    
    health_num = case_when(
      health == 1 ~ 5,
      health == 2 ~ 4,
      health == 3 ~ 3,
      health == 4 ~ 2,
      health == 5 ~ 1,
      TRUE ~ NA_real_
    ),
    
    health = factor(
      health_num,
      levels = c(1, 2, 3, 4, 5),
      labels = c(
        "Muy mala",
        "Mala",
        "Regular",
        "Buena",
        "Muy buena"
      ),
      ordered = TRUE
    )
  )

# Comprobación rápida

glimpse(df_rec)

dim(df_rec)

# -----------------------------------------------------
# 6. Exportación de la base final
# -----------------------------------------------------

# Esta base constituye la fuente oficial de datos
# para el informe técnico, el dashboard y la
# presentación del proyecto.

write_csv(
  df_rec,
  "Datos/depurada/base_final_reto2.csv",
  na = ""
)

# Comprobación final

cat("Base depurada exportada correctamente.\n")
cat("Observaciones:", nrow(df_rec), "\n")
cat("Variables:", ncol(df_rec), "\n")

