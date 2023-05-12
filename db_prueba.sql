--PASOS
--1. Insertar en tablas los datos de CLIENTES, GENERO, PRODUCTOS y MONEDA. La base de datos a utilizar el que conocen, ORACLE, POSTGRES, SQL SERVER, etc.

/* La insercion se realizó a través de la opcion IMPORT DATA y eligiendo el tipo de archivo .xls*/

--2. Crear una vista de clientes
--	A) Mostrar todas las columnas de la tabla clientes. *
--  B) Agregar una columna con la descripción del género. Ejemplo F: FEMENINO *
--	C) Agregar la edad del cliente en base a la fecha de nacimiento, columna FECHA_NACIMIENTO.
create or alter view [dbo].[v_cliente]
as 
	select [CODIGO_CLIENTE], 
			[NOMBRE_CLIENTE],
			[TIPO_PERSONA],
			[dbo].[genero].[DESCRIPCION] GENERO,
			[FECHA_NACIMIENTO],
			DATEDIFF(YEAR, [FECHA_NACIMIENTO] ,GETDATE()) as EDAD,
			[LOCALIDAD],
			[FECHA_ALTA_CLIENTE]
	from cliente
	join genero on cliente.GENERO=genero.COD_GENERO
GO

select * from v_cliente

GO
--3. Crear una vista de saldos_productos
--   A) Mostrar todas las columnas de la tabla productos
--   B) Calcular el saldo total del producto. SALDO_CAPITAL + SALDO_INTERES
--   C) Agregar la cotización y la descripción de la moneda que se encuentra en la tabla MONEDA.

create or alter view [dbo].[v_saldos_productos]
as 
	select [OPERACION],
			[CODIGO_CLIENTE],
			[DESCRIPCION] MONEDA,
			[TIPO_CARTERA],
			[SALDO_CAPITAL],
			[SALDO_INTERES],
			[FECHA_PROCESO],
			[FECHA_VENCIMIENTO],
			[SALDO_CAPITAL] + [SALDO_INTERES] TOTALPRODUCTO
	from [dbo].[productos]
	join [dbo].[moneda] ON [COD_MONEDA]=[MONEDA]
GO

select * from v_saldos_productos

--4) Crear un PBI (Power BI)
--   A) Calcule el total de la cartera guaranizado (Saldo total * Cotización) y por periodo.
--	  Obs.: Para el periodo tener en cuenta la fecha del proceso.
--   B) Total de clientes por Tipo persona sin importar que posea o no productos.
--   C) Total de productos que tiene un cliente, Saldo total por cliente.
--   D) Total de clientes por Edad.
--   E) Total de clientes por localidad y Saldo total de los mismos.
--   F) Agrupar los totales por tipo de cartera.