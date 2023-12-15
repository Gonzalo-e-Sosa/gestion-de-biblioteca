USE biblioteca;
GO


IF EXISTS ( SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Cliente'
    AND SPECIFIC_NAME = N'agregarUsuario'
)
DROP PROCEDURE Cliente.agregarUsuario
GO

CREATE PROCEDURE Cliente.agregarUsuario
    @dni INT,
    @nombre VARCHAR(50),
    @correo VARCHAR(50),
    @clave VARCHAR(250)
AS
BEGIN
    DECLARE 
        @error VARCHAR(300),
        @usuarioID BIGINT;
    BEGIN TRY
        IF 
            @nombre IS NULL OR @nombre = '' OR
            @correo IS NULL OR @correo = '' OR
            @clave  IS NULL OR @clave = '' OR
            LEN(@nombre) = 0 OR
            LEN(@correo) = 0 OR
            LEN(@clave) = 0

        BEGIN
            SET @error = 'Parámetros no válidos. Proporcione valores para nombre, correo y clave.';
            THROW 50001, @error, 1;
        END

        IF PATINDEX('%@%.%', @correo) = 0
        BEGIN
            SET @error = 'Formato de correo no válido.';
            THROW 50001, @error, 1;
        END
        
        EXEC Sistema.buscarUsuarioPorNombre 
            @nombre, @usuarioID OUTPUT;

        IF @usuarioID IS NOT NULL
        BEGIN
            SET @error = 'Ya existe otro usuario con el mismo nombre.';
            THROW 50001, @error, 1;
        END

        EXEC Sistema.buscarUsuarioPorCorreo 
            @correo, @usuarioID OUTPUT;
        
        IF @usuarioID IS NOT NULL
        BEGIN
            SET @error = 'Ya existe otro usuario con el mismo correo.';
            THROW 50001, @error, 1;
        END
        
        DECLARE @claveCifrada VARCHAR(250);
        SET @claveCifrada = HASHBYTES('SHA2_256', @clave)

        INSERT INTO Seguridad.Usuario(
            dni, nombre, correo, clave
        )
        VALUES(
            @dni, @nombre, @correo, @claveCifrada
        )
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar agregar el usuario.' + ERROR_MESSAGE();
        THROW 50001, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Cliente'
    AND SPECIFIC_NAME = N'cambiarClave'
)
DROP PROCEDURE Cliente.cambiarClave
GO

CREATE PROCEDURE Cliente.cambiarClave
    @usuarioID BIGINT,
    @claveActual VARCHAR(250),
    @claveNueva VARCHAR(250)
AS
BEGIN
    DECLARE @error VARCHAR(100);
    BEGIN TRY
        IF NOT EXISTS( 
            SELECT 1 FROM Seguridad.Usuario 
            WHERE usuarioID = @usuarioID 
        )
        BEGIN
            SET @error = 'No existe el usuario.';
            THROW 50003, @error, 1;
        END

        IF NOT EXISTS(
            SELECT 1 FROM Seguridad.Usuario 
            WHERE clave = HASHBYTES('SHA2_256', @claveActual) 
        )
        BEGIN 
            SET @error = 'Clave incorrecta.';
            THROW 50003, @error, 1;
        END

        IF 
            @claveNueva IS NULL OR 
            @claveNueva = ''    OR
            LEN(@claveNueva) = 0
        BEGIN
            SET @error = 'Clave vacia.';
            THROW 50003, @error, 1;
        END
    
        UPDATE Seguridad.Usuario
        SET clave = HASHBYTES('SHA2_256', @claveNueva)
        WHERE usuarioID = @usuarioID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar cambiar la clave.' + ERROR_MESSAGE();
        THROW 50004, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Cliente'
    AND SPECIFIC_NAME = N'borrarUsuario'
)
DROP PROCEDURE Cliente.borrarUsuario
GO

CREATE PROCEDURE Cliente.borrarUsuario
    @usuarioID BIGINT
AS
    DECLARE @error VARCHAR(200);
    BEGIN TRY
        IF NOT EXISTS( 
            SELECT 1 FROM Seguridad.Usuario 
            WHERE usuarioID = @usuarioID 
        )
        BEGIN
            SET @error = 'No existe el usuario.';
            THROW 50003, @error, 1;
        END

        DELETE FROM Seguridad.Usuario
        WHERE usuarioID = @usuarioID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar borrar al usuario.' + ERROR_MESSAGE();
        THROW 50004, @error, 1;
    END CATCH
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Cliente'
    AND SPECIFIC_NAME = N'editarUsuario_dni'
)
DROP PROCEDURE Cliente.editarUsuario_dni
GO

CREATE PROCEDURE Cliente.editarUsuario_dni
    @usuarioID BIGINT,
    @dni INT
AS
    DECLARE @error VARCHAR(200);
    BEGIN TRY
        IF NOT EXISTS( 
            SELECT 1 FROM Seguridad.Usuario 
            WHERE usuarioID = @usuarioID 
        )
        BEGIN
            SET @error = 'No existe el usuario.';
            THROW 50003, @error, 1;
        END

        IF @dni <= 0
        BEGIN 
            SET @error = 'DNI no valido.';
            THROW 50003, @error, 1;
        END
    
        UPDATE Seguridad.Usuario 
        SET dni = @dni
        WHERE usuarioID = @usuarioID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar editar el dni del usuario.' + ERROR_MESSAGE();
        THROW 50004, @error, 1;
    END CATCH  
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Cliente'
    AND SPECIFIC_NAME = N'editarUsuario_nombre'
)
DROP PROCEDURE Cliente.editarUsuario_nombre
GO

CREATE PROCEDURE Cliente.editarUsuario_nombre
    @usuarioID BIGINT,
    @nombre VARCHAR(50)    
AS
    DECLARE @error VARCHAR(200);
    BEGIN TRY
        IF NOT EXISTS( 
            SELECT 1 FROM Seguridad.Usuario 
            WHERE usuarioID = @usuarioID 
        )
        BEGIN
            SET @error = 'No existe el usuario.';
            THROW 50003, @error, 1;
        END

        IF @nombre = '' OR LEN(@nombre) = 0
        BEGIN 
            SET @error = 'Nombre no valido.';
            THROW 50003, @error, 1;
        END
    
        UPDATE Seguridad.Usuario 
        SET nombre = @nombre
        WHERE usuarioID = @usuarioID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar editar el nombre del usuario.' + ERROR_MESSAGE();
        THROW 50004, @error, 1;
    END CATCH  
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Cliente'
    AND SPECIFIC_NAME = N'editarUsuario_correo'
)
DROP PROCEDURE Cliente.editarUsuario_correo
GO

CREATE PROCEDURE Cliente.editarUsuario_correo
    @usuarioID BIGINT,
    @correo VARCHAR(50)
AS
    DECLARE @error VARCHAR(200);
    BEGIN TRY
        IF NOT EXISTS(
            SELECT 1 FROM Seguridad.Usuario
            WHERE usuarioID = @usuarioID
        )
        BEGIN
            SET @error = 'No existe el usuario.';
            THROW 50003, @error, 1;
        END

        IF PATINDEX('%@%.%', @correo) = 0
        OR LEN(@correo) = 0
        BEGIN
            SET @error = 'Correo no valido.';
            THROW 50003, @error, 1;
        END

        UPDATE Seguridad.Usuario
        SET correo = @correo
        WHERE usuarioID = @usuarioID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar editar el correo del usuario.' + ERROR_MESSAGE();
        THROW 50004, @error, 1;
    END CATCH 
GO