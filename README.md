# 🧹 Limpieza y Validación de Datos de Clientes con SQL Server

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-T--SQL-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" />
  <img src="https://img.shields.io/badge/Data-Cleaning-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" />
</p>

## 📌 Descripción del proyecto

Proyecto práctico de limpieza, transformación y validación de una base de datos de clientes utilizando **Microsoft SQL Server** y **T-SQL**.

Se trabajó con un conjunto de 15 registros que contenían diferentes problemas de calidad de datos. El objetivo fue identificar inconsistencias, corregir errores y preparar la información para su posterior análisis.

## 🛠️ Herramientas utilizadas

- 🗄️ Microsoft SQL Server
- 💻 SQL Server Management Studio (SSMS)
- 🔹 Lenguaje SQL (T-SQL)

## 🔍 Proceso de trabajo

El proyecto se desarrolló en diferentes etapas:

1. 🏗️ Creación de la base de datos y tabla de clientes.
2. 📥 Inserción de datos de prueba con inconsistencias.
3. 💾 Creación de una copia de trabajo para preservar los datos originales.
4. 🔎 Diagnóstico de registros duplicados.
5. 🧹 Limpieza de nombres y ciudades.
6. 📧 Validación de direcciones de correo electrónico.
7. 🔢 Limpieza y validación de edades.
8. 📅 Normalización y conversión de fechas.
9. ⚠️ Identificación de valores faltantes (`NULL`).
10. ✅ Verificación final de la calidad de los datos.

## 🚩 Problemas de calidad detectados

Durante el diagnóstico se identificaron:

- Espacios en blanco innecesarios.
- Diferencias en mayúsculas y minúsculas.
- Correos electrónicos con formatos inválidos.
- Edades con valores no numéricos.
- Fechas con distintos formatos.
- Fechas inválidas.
- Campos con valores nulos o vacíos.

## 📊 Resultados obtenidos

| Indicador | Resultado |
|---|---:|
| Registros originales | 15 |
| Registros finales | 15 |
| Registros duplicados | 0 |
| Nombres faltantes | 2 |
| Emails faltantes | 5 |
| Ciudades faltantes | 1 |
| Edades faltantes | 3 |
| Fechas faltantes | 3 |

### ✨ Principales mejoras

- Se conservaron los 15 registros originales.
- Se corrigieron inconsistencias en los campos de texto.
- Se validaron los formatos de correo electrónico.
- Se normalizaron las fechas y se creó una columna de tipo `DATE`.
- Se identificaron los valores faltantes sin inventar información.
- Se mantuvo la tabla original para garantizar la trazabilidad del proceso.

## 📂 Archivo del proyecto

📄 `Limpieza_Clientes_SQL_Server.sql`

Contiene las consultas SQL utilizadas durante las distintas etapas de diagnóstico, limpieza y validación.

## 🎯 Objetivo de aprendizaje

Aplicar técnicas de limpieza, transformación y validación de datos mediante SQL Server, incorporando buenas prácticas de trabajo con bases de datos y fortaleciendo habilidades para el análisis de datos.

---

<p align="center">
  💻 Proyecto desarrollado como práctica de análisis y calidad de datos - Gladys Ramos 
</p>
