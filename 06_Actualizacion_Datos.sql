/* Archivo 06: Actualización de datos
    NOTA PERSONAL: Usar transacciones (BEGIN TRAN) para evitar accidentes.
*/

-- Reviso cuales son las ubicaciones que tengo en mi catálogo.
SELECT * From Cat_Ubicaciones
-- Ubicacion_ID = 6


SELECT * FROM Detalle_Bultos WHERE Ubicacion_ID = 6

-- Primero reviso que archivos son los que voy a modificar, simplemente reviso el numero de filas que me regresa esta consulta para hacer la comparativa cuando haga el update.
SELECT * FROM Detalle_Bultos WHERE Ubicacion_ID IN (SELECT Ubicacion_ID FROM Cat_Ubicaciones WHERE Zona = 'PATIO')


BEGIN TRAN --Aquí es donde inicia la transacción es como decirle a SQL todo lo que haré a partir de aquí, sostenlo, no lo sueltes, no hagas el cambio permanente todavía.
UPDATE Detalle_Bultos
SET Ubicacion_ID = 6 --Este es el dato por el que se va a reemplazar.
-- Esta subconsulta busca los IDs de todo lo que sea 'PATIO' para no hacerlo uno por uno
WHERE Ubicacion_ID IN (SELECT Ubicacion_ID FROM Cat_Ubicaciones WHERE Zona = 'PATIO')

--Si veo que las filas afectadas son correctas, guardo los cambios, si hay algún error o me arrepentí, lo deshago.
--COMMIT (Esto "guarda" los cambios).
--ROLLBACK (Esto "deshace" los cambios).