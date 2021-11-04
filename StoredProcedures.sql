--Obtener Usuario
CREATE PROCEDURE SP_OBTENER_USUARIO 
@nombreUsuario varchar(50),
@contrasenia varchar(50)
AS
BEGIN
	select * from USUARIOS u
	where (u.nombreUsuario = @nombreUsuario)
	and (u.contrasenia = @contrasenia)
END

--Insertar Usuario
CREATE PROCEDURE SP_INSERTAR_USUARIO 
@nombreUsuario varchar(50),
@contrasenia varchar(50)
AS
BEGIN
	insert into USUARIOS
	values(@nombreUsuario,@contrasenia)
END
-----------------------------------------
----------------------------------------
--Obtener id ultimo cliente
CREATE PROCEDURE OBTENER_PROXIMO_ID
@proximoID int output
AS
	BEGIN
		if (SELECT  MAX(idCliente) + 1 FROM CLIENTES) is not null
			 set @proximoID = (SELECT  MAX(idCliente) + 1 FROM CLIENTES)
		else
			set @proximoID = 1
		select @proximoID
	END
----------------------------------------
--Obtener id ultimo movimiento
CREATE PROCEDURE OBTENER_PROXIMO_ID_MOVIMIENTO
@proximoID int output
AS
	BEGIN
		if (SELECT  MAX(idMovimiento) + 1 FROM MOVIMIENTOS) is not null
			 set @proximoID = (SELECT  MAX(idMovimiento) + 1 FROM MOVIMIENTOS)
		else
			set @proximoID = 1
		select @proximoID
	END
----------------------------------------
--Obtener Tipos de Cuenta
CREATE PROCEDURE OBTENER_TIPOS_CUENTA
AS
	BEGIN
		select * from
		TIPOS_CUENTA
	END
----------------------------------------
----------------------------------------
--Validar CBU Repetida
CREATE PROCEDURE VALIDAR_CBU_REPETIDA
@cbu decimal(22,0)
AS
	BEGIN
		select cbu from
		CUENTAS
		where cbu = @cbu
	END
----------------------------------------
--Insertar Cliente
CREATE PROCEDURE SP_INSERTAR_CLIENTE
@idCliente int,
@nombre varchar(50),
@apellido varchar(50),
@dni int
AS
	BEGIN
		INSERT INTO CLIENTES
		VALUES(@idCliente,@nombre,@apellido,@dni,null)
	END
----------------------------------------
--Insertar Cuenta
CREATE PROCEDURE SP_INSERTAR_CUENTA
@idCliente int,
@cbu decimal(22,0),
@saldo decimal(19,4),
@idTipoCuenta int

AS
	BEGIN
		INSERT INTO CUENTAS
		VALUES(@idCliente,@cbu,@saldo,@idTipoCuenta,null,null)
	END
----------------------------------------
--Eliminar cliente y cuentas
CREATE PROCEDURE SP_ELIMINAR_CLIENTE
@idCliente int
AS
	BEGIN
		UPDATE CLIENTES
		SET fechaBaja = GETDATE()
		where idCliente = @idCliente

		UPDATE CUENTAS
		SET fechaBaja = GETDATE()
		where idCliente = @idCliente
	END
----------------------------------------
----------------------------------------
--Eliminar cuenta
CREATE PROCEDURE SP_ELIMINAR_CUENTA
@cbu decimal(22,0)
AS
	BEGIN
		UPDATE CUENTAS
		SET fechaBaja = GETDATE()
		where cbu = @cbu
	END
----------------------------------------
----------------------------------------
--Insertar Movimiento
CREATE PROCEDURE SP_INSERTAR_MOVIMIENTO
@idMovimiento int,
@cbuOrigen decimal(22,0),
@cbuDestino decimal(22,0),
@monto decimal(19,4)
AS
	BEGIN
		INSERT INTO MOVIMIENTOS
		VALUES(@idMovimiento,@cbuOrigen,@cbuDestino,@monto,GETDATE())

		UPDATE CUENTAS
		set saldo = saldo + @monto
		where cbu = @cbuDestino

		UPDATE CUENTAS
		set saldo = saldo - @monto,
		ultimoMovimiento = @idMovimiento
		where cbu = @cbuOrigen
	END
----------------------------------------
----------------------------------------
--Obtener Clientes 
CREATE PROCEDURE SP_OBTENER_CLIENTES
AS
	BEGIN
		select * 
		from CLIENTES
	END
----------------------------------------

----------------------------------------
--Obtener cuentas de un cliente
CREATE PROCEDURE SP_OBTENER_CLIENTE_CUENTAS
@idCliente int
AS
	BEGIN
		select * 
		from CUENTAS
		where idCliente = @idCliente
	END
----------------------------------------
----------------------------------------
