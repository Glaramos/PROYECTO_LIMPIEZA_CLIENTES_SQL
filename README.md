# Limpieza y Validación de Datos de Clientes con SQL Server

## Descripción del proyecto

Proyecto práctico de limpieza y validación de una base de datos de clientes utilizando Microsoft SQL Server y T-SQL.

Se trabajó con un conjunto de 15 registros que contenían distintos problemas de calidad de datos, con el objetivo de identificar inconsistencias, corregir errores y preparar la información para su posterior análisis.

## Herramientas utilizadas

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Lenguaje SQL (T-SQL)

## Proceso realizado

1. Creación de la base de datos y tabla de clientes.
2. Inserción de datos de prueba con inconsistencias.
3. Creación de una copia de trabajo para preservar los datos originales.
4. Diagnóstico de registros duplicados.
5. Limpieza de nombres y ciudades.
6. Validación de direcciones de correo electrónico.
7. Limpieza y validación de edades.
8. Normalización y conversión de fechas.
9. Identificación de valores faltantes (`NULL`).
10. Verificación final de la calidad de los datos.

## Problemas detectados

- Espacios en blanco innecesarios.
- Diferencias en mayúsculas y minúsculas.
- Correos electrónicos con formatos inválidos.
- Edades con valores no numéricos.
- Fechas con distintos formatos.
- Fechas inválidas.
- Campos con valores nulos o vacíos.

## Resultados

- 15 registros originales conservados.
- No se detectaron registros duplicados.
- Se corrigieron inconsistencias en los campos de texto.
- Se validaron edades y fechas.
- Se identificaron los valores faltantes sin inventar información.
- Se conservó la tabla original para mantener la trazabilidad.

## Archivos del proyecto

- `Limpieza_Clientes_SQL_Server.sql`: contiene las consultas SQL utilizadas durante el proceso de limpieza y validación.

## Objetivo de aprendizaje

Aplicar técnicas de limpieza, transformación y validación de datos mediante SQL Server, desarrollando buenas prácticas de trabajo con bases de datos.
