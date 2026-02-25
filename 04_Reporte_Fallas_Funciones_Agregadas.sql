use Portafolio_Analista_Datos
GO

/* Archivo 04_ Reporte de daños por Zona
	Este script se usa para identificar el estado de los bultos así como su localización.
*/
SELECT
	U.Zona,
	-- Aquí se usa una función agregada: El COUNT(*) cuenta todas las filas.
	-- En palabras simples le estoy pidiendo a SQL que cuente cuantas veces aparece la zona en la lista.
	COUNT(*) AS Total_Bultos_Dañados
FROM
Detalle_Bultos as D
JOIN Cat_Ubicaciones as U ON D.Ubicacion_ID = U.Ubicacion_ID
JOIN Cat_Estados as E ON D.Estado_ID = E.Estado_ID
-- Filtramos para que unicamente busque los registros que esten dañados.
WHERE E.Descripcion = 'Dañado'
-- Como estoy haciendo uso de una función agregada forzosamente tengo que agrupar usando GROUP BY, una característica es que la condición del GROUP BY no debe estar incluido en la función agregada.
GROUP BY U.Zona
-- Para que hasta arriba salga la zona más problemática.
ORDER BY Total_Bultos_Dañados DESC;