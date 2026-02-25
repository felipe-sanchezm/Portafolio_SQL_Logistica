USE Portafolio_Analista_Datos
GO

/* Archivo 05: Reporte de ubicación en áreas de tránsito
	Este script lo uso para saber qué bultos están todavía en el patio o en el andén.
	Básicamente es mi lista de "pendientes por acomodar".
*/

SELECT
	D.SKU,
	RM.Proveedor,
	CU.Zona
FROM
Detalle_Bultos AS D
JOIN Recepcion_Maestra AS RM ON D.Folio_Recibo = RM.Folio_Recibo
JOIN Cat_Ubicaciones AS CU ON D.Ubicacion_ID = CU.Ubicacion_ID
-- Al solo hacer el filtrado por dos condiciones opté por usar OR, problema sería si tuviera 4 condiciones o más.
WHERE CU.Zona = 'PATIO' OR CU.Zona = 'ANDEN'
ORDER BY CU.Zona ASC