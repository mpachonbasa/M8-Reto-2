# Módulo 8 - Reto 2
## Bienestar subjetivo y desigualdades sociales en Europa (ESS6)

### Autora

Mónica Pachón Basallo

### Descripción

Proyecto de Ciencia de Datos Reproducible desarrollado para el Máster en Behavioral Data Science.

El proyecto utiliza datos de la European Social Survey (ESS Round 6) para analizar cómo distintos factores socioeconómicos, educativos y familiares se relacionan con el bienestar subjetivo de la población europea.

A partir del análisis exploratorio de datos (EDA) se identificaron los principales factores asociados al bienestar y se desarrolló un dashboard interactivo para explorar los resultados de forma dinámica y reproducible.

### Objetivo general

Analizar cómo distintos factores sociales, educativos y económicos se relacionan con el bienestar subjetivo en Europa.

### Principales hallazgos

- La percepción de ingresos del hogar constituye el factor más estrechamente asociado al bienestar subjetivo.
- El nivel educativo presenta un gradiente positivo consistente en la mayoría de indicadores de bienestar.
- Las variables familiares y sociodemográficas muestran asociaciones más moderadas y funcionan principalmente como variables de segmentación.
- Los resultados obtenidos sirvieron como base para el diseño del dashboard interactivo incluido en el proyecto.

### Herramientas utilizadas

- R
- RStudio / Posit Cloud
- R Markdown
- GitHub
- ESS Round 6

### Estructura del repositorio

### Estructura del repositorio

```text
Dashboard/
└── dashboard.Rmd

Datos/
├── ESS6e02_7.csv
├── estudio_depurado.csv
└── depurada/
    ├── base_final_reto2.csv
    ├── estudio_recodificado.csv
    ├── tarea1_resumen_categoricas.csv
    ├── tarea1_resumen_numericas.csv
    ├── tarea1_frecuencias_categoricas.csv
    ├── tarea1_resumen_continuas.csv
    └── tablas auxiliares y resúmenes del análisis exploratorio

Graficos/
└── Visualizaciones generadas durante el análisis

Informes/
├── informe_tecnico.Rmd
├── informe_tecnico.html
└── Reto1M8.pdf

Presentación/
├── presentacion_reto2.Rmd
└── presentacion_reto2.html

Scripts/
├── Limpieza_Datos_Reto2.R
└── Código para Reto 1 M8.Rmd

README.md
```