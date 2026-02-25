USE Portafolio_Analista_Datos;
GO

-- 1. Limpieza total para iniciar desde cero
DELETE FROM Log_Movimientos;
DELETE FROM Detalle_Bultos;
DELETE FROM Recepcion_Maestra;
DELETE FROM Cat_Ubicaciones;
DELETE FROM Cat_Estados;
GO

-- 2. Catálogos (10 Ubicaciones y 5 Estados)
INSERT INTO Cat_Estados (Estado_ID, Descripcion) VALUES 
(1, 'Recibido OK'), (2, 'Discrepancia/Faltante'), (3, 'Dañado'), (4, 'Excedente'), (5, 'En Auditoría');

INSERT INTO Cat_Ubicaciones (Zona, Pasillo, Nivel) VALUES 
('ANDEN',1,0), ('ANDEN',2,0), ('RACK-A',1,1), ('RACK-A',1,2), ('RACK-B',2,1),
('RACK-B',2,2), ('RACK-C',3,1), ('RACK-C',3,2), ('PATIO',0,0), ('CUARENTENA',99,9);

-- 3. Proveedores Maestros
INSERT INTO Recepcion_Maestra (Proveedor, Sello_Seguridad, Fecha_Arribo) VALUES 
('Nike Global', 'NK-99', GETDATE()), ('Adidas Store', 'AD-88', GETDATE()),
('Puma S.A.', 'PM-77', GETDATE()-1), ('Levi Strauss', 'LV-66', GETDATE()-2),
('Apple Inc', 'AP-55', GETDATE());

-- 4. BUCLE DE GENERACIÓN MASIVA (100 Bultos)
DECLARE @Contador INT = 1;
DECLARE @FolioRandom INT;
DECLARE @UbicacionRandom INT;
DECLARE @EstadoRandom INT;
DECLARE @CantEsp INT;
DECLARE @CantRec INT;

WHILE @Contador <= 100
BEGIN
    -- Seleccionamos IDs aleatorios de lo que ya insertamos
    SELECT TOP 1 @FolioRandom = Folio_Recibo FROM Recepcion_Maestra ORDER BY NEWID();
    SELECT TOP 1 @UbicacionRandom = Ubicacion_ID FROM Cat_Ubicaciones ORDER BY NEWID();
    
    -- Lógica de errores: La mayoría (70%) serán Estado 1 (OK), el resto variados
    SET @EstadoRandom = CASE 
        WHEN @Contador % 5 = 0 THEN 2 -- Cada 5, un faltante
        WHEN @Contador % 12 = 0 THEN 3 -- Cada 12, un dañado
        WHEN @Contador % 20 = 0 THEN 4 -- Cada 20, un excedente
        ELSE 1 END;

    SET @CantEsp = FLOOR(RAND()*(100-10+1)+10); -- Cantidad entre 10 y 100
    
    -- Simular la recepción basada en el estado
    SET @CantRec = CASE 
        WHEN @EstadoRandom = 1 THEN @CantEsp
        WHEN @EstadoRandom = 2 THEN @CantEsp - 2
        WHEN @EstadoRandom = 3 THEN @CantEsp - 1
        WHEN @EstadoRandom = 4 THEN @CantEsp + 5
        ELSE @CantEsp END;

    INSERT INTO Detalle_Bultos (Folio_Recibo, Ubicacion_ID, Estado_ID, SKU, Cant_Esperada, Cant_Recibida)
    VALUES (@FolioRandom, @UbicacionRandom, @EstadoRandom, 
            'SKU-' + CAST(ABS(CHECKSUM(NEWID())) % 1000 AS VARCHAR), 
            @CantEsp, @CantRec);

    SET @Contador = @Contador + 1;
END
GO