-- =====================================================
-- PROYECTO: LIMPIEZA Y VALIDACION DE DATOS DE CLIENTES
-- HERRAMIENTA: SQL SERVER
-- LENGUAJE: T-SQL
-- =====================================================
--
-- OBJETIVO:
-- Realizar un proceso de limpieza y validacion de
-- una base de datos de clientes con problemas de calidad.
--
-- TAREAS REALIZADAS:
-- 1. Creacion de la base de datos.
-- 2. Creacion e insercion de datos de prueba.
-- 3. Copia de seguridad de la tabla original.
-- 4. Diagnostico de registros duplicados.
-- 5. Limpieza de nombres, emails y ciudades.
-- 6. Validacion y limpieza de edades.
-- 7. Normalizacion y conversion de fechas.
-- 8. Verificacion de valores faltantes.
-- 9. Validacion final de los registros.
--
-- RESULTADO:
-- Se conservaron los 15 registros originales.
-- Los valores faltantes se identificaron y conservaron
-- como NULL cuando no habia informacion disponible.
--
-- =====================================================

-- ==========================================
-- 01. CREACION DE BASE DE DATOS Y TABLA
-- ==========================================

-- Crear la base de datos
CREATE DATABASE PracticaClientes;
GO

-- Seleccionar la base de datos
USE PracticaClientes;
GO

-- Crear la tabla original de clientes
CREATE TABLE clientes_sucios (
    id_cliente INT PRIMARY KEY,
    nombre_apellido NVARCHAR(120),
    email NVARCHAR(150),
    ciudad NVARCHAR(100),
    edad NVARCHAR(20),
    fecha_registro NVARCHAR(30)
);
GO

-- Insertar los 15 registros originales
INSERT INTO clientes_sucios
(id_cliente, nombre_apellido, email, ciudad, edad, fecha_registro)
VALUES
(1, '  María Gómez  ', 'maria@gmail.com', 'Posadas', '28', '2025-01-15'),
(2, 'Juan Pérez', NULL, 'Iguazú', '35', '15/02/2025'),
(3, 'SOFIA RODRIGUEZ', 'sofia@gmail.com', '  Oberá  ', '42', '2025-03-10'),
(4, NULL, 'pedro@gmail.com', 'Eldorado', '30', '2025-04-12'),
(5, 'Lucía Fernández', 'lucia@gmail.com', NULL, ' 25 ', '2025-05-20'),
(6, 'Carlos López', 'carlosgmail.com', 'Posadas', 'desconocida', '2025-06-15'),
(7, 'Ana Martínez', 'ana@gmail.com', 'APOSTOLES', '31', NULL),
(8, '  Martín Díaz', 'martin@gmail.com ', 'Iguazú', '45', '20/07/2025'),
(9, 'Camila Torres', NULL, 'Oberá', NULL, '2025-08-12'),
(10, '  Nicolás Silva  ', 'nicolas@gmail.com', '  Eldorado ', '38', '2025-13-40'),
(11, 'Florencia Ruiz', 'florencia@gmail.com', 'Posadas', '27', '2025-09-10'),
(12, '  ', 'incorrecto.com', 'Iguazú', '29', '  '),
(13, 'Joaquín Romero', 'joaquin@gmail.com', 'Oberá', '33', '2025-10-15'),
(14, 'Valentina Sosa', NULL, 'Eldorado', '22', '2025-11-01'),
(15, 'Mateo Castro', 'mateo@gmail.com', 'Posadas', NULL, '01/12/2025');
GO

-- ==========================================
-- 02. CREACION DE COPIA DE TRABAJO
-- ==========================================

-- Crear una copia de la tabla original
-- para realizar la limpieza sin modificarla

SELECT *
INTO clientes_limpieza
FROM clientes_sucios;
GO


USE PracticaClientes;
GO

-- ==========================================
-- 03. DIAGNOSTICO DE REGISTROS DUPLICADOS
-- Objetivo: identificar clientes con datos repetidos
-- ==========================================

SELECT
    nombre_apellido,
    email,
    ciudad,
    edad,
    fecha_registro,

    -- Cuenta cuantas veces aparece cada combinacion
    COUNT(*) AS cantidad

FROM clientes_limpieza

-- Agrupa los registros que tienen los mismos datos
GROUP BY
    nombre_apellido,
    email,
    ciudad,
    edad,
    fecha_registro

-- Muestra solamente los grupos que aparecen mas de una vez
HAVING COUNT(*) > 1;

USE PracticaClientes;
GO

-- ==========================================
-- 03.2 DIAGNOSTICO DE EMAILS DUPLICADOS
-- Objetivo: identificar direcciones de email repetidas
-- ==========================================

SELECT
    email,
    COUNT(*) AS cantidad
FROM clientes_limpieza
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;

USE PracticaClientes;
GO

-- ==========================================
-- 03.3 DIAGNOSTICO DE NOMBRES DUPLICADOS
-- Objetivo: identificar nombres repetidos
-- ==========================================

SELECT
    nombre_apellido,
    COUNT(*) AS cantidad
FROM clientes_limpieza
WHERE nombre_apellido IS NOT NULL
GROUP BY nombre_apellido
HAVING COUNT(*) > 1;

USE PracticaClientes;
GO

-- ==========================================
-- 04. DIAGNOSTICO DE VALORES NULL Y VACIOS
-- Objetivo: identificar nombres faltantes o vacios
-- ==========================================

SELECT *
FROM clientes_limpieza
WHERE nombre_apellido IS NULL
   OR TRIM(nombre_apellido) = '';

USE PracticaClientes;
GO

-- ==========================================
-- 04.1 LIMPIEZA DE NOMBRES VACIOS
-- Objetivo: reemplazar espacios vacios por NULL
-- ==========================================

UPDATE clientes_limpieza
SET nombre_apellido = NULL
WHERE TRIM(nombre_apellido) = '';

-- Verificar los cambios
SELECT *
FROM clientes_limpieza
WHERE nombre_apellido IS NULL;

USE PracticaClientes;
GO

-- ==========================================
-- 04.2 DIAGNOSTICO DE EMAILS VACIOS
-- Objetivo: identificar emails NULL o vacios
-- ==========================================

SELECT *
FROM clientes_limpieza
WHERE email IS NULL
   OR TRIM(email) = '';


USE PracticaClientes;
GO

-- ==========================================
-- 04.3 DIAGNOSTICO DE CIUDADES VACIAS
-- Objetivo: identificar ciudades NULL o vacias
-- ==========================================

SELECT *
FROM clientes_limpieza
WHERE ciudad IS NULL
   OR TRIM(ciudad) = '';

USE PracticaClientes;
GO

-- ==========================================
-- 04.4 DIAGNOSTICO DE EDADES
-- Objetivo: identificar edades NULL, vacias o invalidas
-- ==========================================

SELECT *
FROM clientes_limpieza
WHERE edad IS NULL
   OR TRIM(edad) = ''
   OR TRY_CONVERT(INT, TRIM(edad)) IS NULL;

USE PracticaClientes;
GO

-- ==========================================
-- 04.5 LIMPIEZA DE EDADES INVALIDAS
-- Objetivo: reemplazar textos no numericos por NULL
-- ==========================================

UPDATE clientes_limpieza
SET edad = NULL
WHERE TRY_CONVERT(INT, TRIM(edad)) IS NULL
  AND edad IS NOT NULL;

-- Verificar los cambios
SELECT *
FROM clientes_limpieza
WHERE edad IS NULL;

-- Verificar que no queden edades con texto inválido

SELECT *
FROM clientes_limpieza
WHERE edad IS NOT NULL
  AND TRY_CONVERT(INT, TRIM(edad)) IS NULL;

USE PracticaClientes;
GO

-- ==========================================
-- 04.6 DIAGNOSTICO DE FECHAS
-- Objetivo: identificar fechas NULL, vacias o invalidas
-- ==========================================

SELECT *
FROM clientes_limpieza
WHERE fecha_registro IS NULL
   OR TRIM(fecha_registro) = ''
   OR (
       TRY_CONVERT(DATE, TRIM(fecha_registro), 23) IS NULL
       AND TRY_CONVERT(DATE, TRIM(fecha_registro), 103) IS NULL
   );

   USE PracticaClientes;
GO

-- ==========================================
-- 04.7 LIMPIEZA DE FECHAS INVALIDAS
-- Objetivo: reemplazar fechas incorrectas o vacias por NULL
-- ==========================================

UPDATE clientes_limpieza
SET fecha_registro = NULL
WHERE fecha_registro IS NOT NULL
  AND (
      TRIM(fecha_registro) = ''
      OR (
          TRY_CONVERT(DATE, TRIM(fecha_registro), 23) IS NULL
          AND TRY_CONVERT(DATE, TRIM(fecha_registro), 103) IS NULL
      )
  );

-- Verificar los registros con fecha NULL
SELECT *
FROM clientes_limpieza
WHERE fecha_registro IS NULL;

USE PracticaClientes;
GO

-- ==========================================
-- 04.8 LIMPIEZA DE ESPACIOS EN LOS NOMBRES
-- Objetivo: eliminar espacios al inicio y al final
-- ==========================================

UPDATE clientes_limpieza
SET nombre_apellido = TRIM(nombre_apellido)
WHERE nombre_apellido IS NOT NULL;

-- Verificar los resultados
SELECT id_cliente, nombre_apellido
FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 04.9 DIAGNOSTICO DE ESPACIOS EN CIUDADES
-- Objetivo: identificar espacios innecesarios
-- ==========================================

SELECT
    id_cliente,
    ciudad
FROM clientes_limpieza
WHERE ciudad <> TRIM(ciudad);

USE PracticaClientes;
GO

-- ==========================================
-- 04.10 LIMPIEZA DE ESPACIOS EN CIUDADES
-- Objetivo: eliminar espacios al inicio y al final
-- ==========================================

UPDATE clientes_limpieza
SET ciudad = TRIM(ciudad)
WHERE ciudad IS NOT NULL;

-- Verificar los resultados
SELECT
    id_cliente,
    ciudad
FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 04.11 NORMALIZACION DE NOMBRE DE CIUDAD
-- Objetivo: unificar la escritura de Apostoles
-- ==========================================

UPDATE clientes_limpieza
SET ciudad = 'Apóstoles'
WHERE UPPER(ciudad) = 'APOSTOLES';

-- Verificar los resultados
SELECT id_cliente, ciudad
FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 04.12 LIMPIEZA DE CIUDADES DESCONOCIDAS
-- Objetivo: reemplazar valores desconocidos por NULL
-- ==========================================

UPDATE clientes_limpieza
SET ciudad = NULL
WHERE UPPER(TRIM(ciudad)) = 'DESCONOCIDO';

-- Verificar los resultados
SELECT id_cliente, ciudad
FROM clientes_limpieza;USE PracticaClientes;
GO

-- ==========================================
-- 04.12 LIMPIEZA DE CIUDADES DESCONOCIDAS
-- Objetivo: reemplazar valores desconocidos por NULL
-- ==========================================

UPDATE clientes_limpieza
SET ciudad = NULL
WHERE UPPER(TRIM(ciudad)) = 'DESCONOCIDO';

-- Verificar los resultados
SELECT id_cliente, ciudad
FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 04.13 DIAGNOSTICO DE EMAILS INVALIDOS
-- Objetivo: identificar emails sin formato valido
-- ==========================================

SELECT
    id_cliente,
    nombre_apellido,
    email
FROM clientes_limpieza
WHERE email IS NOT NULL
  AND (
      email NOT LIKE '%_@_%._%'
      OR email LIKE '% %'
  );

USE PracticaClientes;
GO

-- ==========================================
-- 04.14 LIMPIEZA DE EMAILS
-- Objetivo: quitar espacios y normalizar emails invalidos
-- ==========================================

-- Paso 1: eliminar espacios al inicio y al final
UPDATE clientes_limpieza
SET email = TRIM(email)
WHERE email IS NOT NULL;

-- Paso 2: reemplazar emails invalidos por NULL
UPDATE clientes_limpieza
SET email = NULL
WHERE email IS NOT NULL
  AND email NOT LIKE '%_@_%._%';

-- Paso 3: verificar los resultados
SELECT
    id_cliente,
    nombre_apellido,
    email
FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 04.15 NORMALIZACION DE NOMBRES
-- Objetivo: unificar mayusculas, minusculas y tildes
-- ==========================================

UPDATE clientes_limpieza
SET nombre_apellido = 'Sofía Rodríguez'
WHERE id_cliente = 3;

-- Verificar el resultado
SELECT id_cliente, nombre_apellido
FROM clientes_limpieza;

USE PracticaClientes;
GO


USE PracticaClientes;
GO

-- ==========================================
-- 04.16 LIMPIEZA DE ESPACIOS EN EDADES
-- Objetivo: eliminar espacios innecesarios
-- ==========================================

UPDATE clientes_limpieza
SET edad = TRIM(edad)
WHERE edad IS NOT NULL;

-- Verificar los resultados
SELECT id_cliente, nombre_apellido, edad
FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 04.17 DIAGNOSTICO DE CONVERSION DE FECHAS
-- Objetivo: comprobar que las fechas sean convertibles
-- ==========================================

SELECT
    id_cliente,
    fecha_registro,
    COALESCE(
        TRY_CONVERT(DATE, TRIM(fecha_registro), 23),
        TRY_CONVERT(DATE, TRIM(fecha_registro), 103)
    ) AS fecha_convertida
FROM clientes_limpieza
WHERE fecha_registro IS NOT NULL;

USE PracticaClientes;
GO

-- ==========================================
-- 04.18 CREACION DE COLUMNA DE FECHA LIMPIA
-- Objetivo: almacenar las fechas como tipo DATE
-- ==========================================

ALTER TABLE clientes_limpieza
ADD fecha_registro_limpia DATE;
GO

-- Convertir las fechas de texto a tipo DATE
UPDATE clientes_limpieza
SET fecha_registro_limpia =
    COALESCE(
        TRY_CONVERT(DATE, TRIM(fecha_registro), 23),
        TRY_CONVERT(DATE, TRIM(fecha_registro), 103)
    );

-- Verificar la conversion
SELECT
    id_cliente,
    fecha_registro,
    fecha_registro_limpia
FROM clientes_limpieza
ORDER BY id_cliente;

USE PracticaClientes;
GO

-- ==========================================
-- 05. CONTROL FINAL DE CALIDAD
-- Objetivo: verificar espacios en columnas de texto
-- ==========================================

SELECT *
FROM clientes_limpieza
WHERE
    (nombre_apellido IS NOT NULL
     AND nombre_apellido <> TRIM(nombre_apellido))
    OR
    (email IS NOT NULL
     AND email <> TRIM(email))
    OR
    (ciudad IS NOT NULL
     AND ciudad <> TRIM(ciudad))
    OR
    (edad IS NOT NULL
     AND edad <> TRIM(edad));

-- ==========================================
-- 05. VERIFICACION FINAL DE DATOS LIMPIOS
-- Objetivo: revisar todos los registros
-- ==========================================

SELECT *
FROM clientes_limpieza
ORDER BY id_cliente;

USE PracticaClientes;
GO

-- ==========================================
-- 06. RESUMEN DE CALIDAD DE DATOS
-- Objetivo: contar los valores NULL por columna
-- ==========================================

SELECT
    COUNT(*) AS total_clientes,

    SUM(CASE WHEN nombre_apellido IS NULL THEN 1 ELSE 0 END)
        AS nombres_faltantes,

    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END)
        AS emails_faltantes,

    SUM(CASE WHEN ciudad IS NULL THEN 1 ELSE 0 END)
        AS ciudades_faltantes,

    SUM(CASE WHEN edad IS NULL THEN 1 ELSE 0 END)
        AS edades_faltantes,

    SUM(CASE WHEN fecha_registro_limpia IS NULL THEN 1 ELSE 0 END)
        AS fechas_faltantes

FROM clientes_limpieza;

USE PracticaClientes;
GO

-- ==========================================
-- 07. COMPARACION DE TABLA ORIGINAL Y LIMPIA
-- Objetivo: comprobar la cantidad de registros
-- ==========================================

SELECT
    (SELECT COUNT(*) FROM clientes_sucios)
        AS total_original,

    (SELECT COUNT(*) FROM clientes_limpieza)
        AS total_limpio;

USE PracticaClientes;
GO

-- ==========================================
-- 08. VISUALIZACION DE LA TABLA LIMPIA
-- Objetivo: revisar los datos después
-- de realizar todas las correcciones
-- ==========================================

SELECT
    id_cliente,
    nombre_apellido,
    email,
    ciudad,
    edad,
    fecha_registro,
    fecha_registro_limpia
FROM clientes_limpieza
ORDER BY id_cliente;