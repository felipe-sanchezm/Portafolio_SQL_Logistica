-- 1. Catalogo de Ubicaciones (Para saber en que zona de la bodega está)
CREATE TABLE Cat_Ubicaciones (
Ubicacion_ID INT PRIMARY KEY IDENTITY (1,1),
Zona VARCHAR(10) NOT NULL,
Pasillo INT,
Nivel INT
);

-- 2. Catalogo de Estados (Para no usar texto repetido, sino IDs)
CREATE TABLE Cat_Estados (
Estado_ID INT PRIMARY KEY,
Descripcion VARCHAR(50)
);

/* 3. Tabla Maestra de Recepcion
    Esta tabla funciona como la cabecera, tiene el resumen general
*/
CREATE TABLE Recepcion_Maestra (
Folio_Recibo INT PRIMARY KEY IDENTITY(1000,1), -- El número de folio único del recibo
Proveedor VARCHAR(100) NOT NULL, -- ¿Quién nos mandó la mercancía?
Fecha_Arribo DATETIME DEFAULT GETDATE(), -- ¿Cuándo entró la mercancía al almacen.
Sello_Seguridad VARCHAR(50), -- Los sellos con los que el paquete ingresó a la bodega
Auditado BIT DEFAULT 0 -- 0 No auditado, 1 Auditado
);

/* 4. El "Corazon": Detalle de Bultos
    Aqui esta la información desglosada de la tabla Recepcion_Maestra
*/
CREATE TABLE Detalle_Bultos (
Bulto_ID INT PRIMARY KEY IDENTITY (1,1), --EL DNI único de cada bulto
Folio_Recibo INT NOT NULL, -- Aqui le decimos que este bulto pertenece al folio de la Recepcion_Maestra
Ubicacion_ID INT, -- Para no repetir el donde está guardado, lo relacionamos al catálogo de ubicaciones.
Estado_ID INT DEFAULT 1, --Para no repetir el estado, lo relacionamos al catálogo de estado.
SKU VARCHAR (20) NOT NULL, -- El código del producto
Cant_Esperada INT CHECK (Cant_Esperada > 0), -- Lo que dice el papel que debío haber llegado.
--El CHECK impide que alguien por error registre un bulto con cantidad cero o negativo.
Cant_Recibida INT, -- Lo que realmente llego
Diferencia AS (Cant_Esperada - Cant_Recibida), --Columna calculada, SQL hace la resta automáticamente.
-- Si llegó de menos, nos da un número negativo.


--Relaciones Externas: Conectamos con el catálogo de zonas y de estados.
CONSTRAINT FK_Folio FOREIGN KEY (Folio_Recibo) REFERENCES Recepcion_Maestra(Folio_Recibo),
CONSTRAINT FK_Ubicacion FOREIGN KEY (Ubicacion_ID) REFERENCES Cat_Ubicaciones(Ubicacion_ID),
CONSTRAINT FK_Estado FOREIGN KEY (Estado_ID) REFERENCES Cat_Estados(Estado_ID)
);

-- 5. Historial de Movimientos
CREATE TABLE Log_Movimientos (
Log_ID INT PRIMARY KEY IDENTITY (1,1),
Bulto_ID INT,
Fecha_Movimiento DATETIME DEFAULT GETDATE(),
Observaciones TEXT,

CONSTRAINT FK_Bulto_Log FOREIGN KEY (Bulto_ID) REFERENCES Detalle_Bultos(Bulto_ID)
);