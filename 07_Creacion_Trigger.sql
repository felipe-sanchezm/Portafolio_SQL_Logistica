CREATE TRIGGER TR_Auditoria_Bultos -- Se crea el trigger y se le da un nombre
ON Detalle_Bultos -- La tabla que se estará monitoreando
AFTER UPDATE --Se dispara (ejecuta) justo después de que el cambio ocurre
AS --Que es lo que hará este trigger
BEGIN
	INSERT INTO Log_Movimientos (Bulto_ID, Fecha_Movimiento, Observaciones) --Escribirá en la tabla Log_Movimientos
	-- El SELECT aquí funciona para agregar registros de forma masiva, va a buscar TODOS los registros en las tablas temporales Inserted y Deleted y usará su información para guardarla en la tabla de Log_Movimientos
	SELECT
		i.Bulto_ID,
		GETDATE(),
		-- Explicación de la bitácora:
		-- Combinamos texto fijo con los datos de las tablas DELETED e INSERTED.
		-- Usamos CAST porque no se puede "pegar" texto con número directamente.
		'Cambio detectado: ' + -- Texto fijo para empezar el reporte
		'Ub. Anterior: ' + 
		CAST(d.Ubicacion_ID AS VARCHAR) + --Tomamos el ID de la tabla DELETED y lo convertimos a texto
		' -> Nueva: ' + 
		CAST(i.Ubicacion_ID AS VARCHAR) +  --Tomamos el ID de la tabla INSERTED y lo convertimos a texto
		' | ' + -- Una rayita simple para separar la ubicación del estado de los bultos
		'Edo. Anterior: ' + 
		CAST(d.Estado_ID AS VARCHAR) + -- El estado viejo
		' -> Nuevo: ' + CAST(i.Estado_ID AS VARCHAR) --El estado nuevo
	FROM Inserted i -- Esta es una tabla de sistema, guarda de manera temporal el estado actual de los registros que se cambian.
	JOIN Deleted d -- Esta es una tabla de sistema, guarda de manera temporal el estado anterior de los registros que se cambian.
	ON i.Bulto_ID = d.Bulto_ID;
END
GO