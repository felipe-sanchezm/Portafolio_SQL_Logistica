# Portafolio de Análisis de Datos Logísticos 

¡Bienvenido! Este proyecto simula la operación real de una bodega, enfocándose en la trazabilidad de bultos, control de estados y auditoría de inventarios.

## Lo que este proyecto resuelve:
- **Integridad de Datos:** Uso de restricciones (Checks) y tipos de datos para evitar errores de captura.
- **Auditoría Automática:** Implementación de un Trigger para registrar cada movimiento de inventario (quién, qué y cuándo).
- **Reporteo Operativo:** Consultas avanzadas para detectar bultos dañados y mercancía pendiente de acomodo.
- **Seguridad:** Manejo de transacciones (Begin Tran / Rollback) para actualizaciones masivas críticas.

## Tecnologías utilizadas:
- **SQL Server (T-SQL)**: Creación de esquemas, Triggers, Vistas y subconsultas.
- **Lógica de Negocio**: Aplicación de reglas reales de almacenamiento y distribución.

## Estructura del proyecto:
1. `01_Creacion_Tablas_Logistica`: El "esqueleto" de la base de datos.
2. `03_Carga_Masiva_Datos`: Script generado con IA para crear datos random con los cuales se va a trabajar
3. `04_Reporte_Fallas_Funciones_Agregadas.sql`: Uso de funciones agregadas y GROUP BY.
4. `05_Reporte_Fallas_Sencillo.sql`: El WHERE es el protagonista.
5. `06_Actualizacion_Datos.sql`: Hacemos uso de transacciones para proteger la manipulación de datos.
6. `07_Creacion_Trigger.sql`: Se crea un disparador (trigger) para que cree un registro cada que se realicen los cambios sobre una tabla.

---
*Este proyecto demuestra mi capacidad para transformar datos crudos en información útil para la toma de decisiones en el sector logístico.*
