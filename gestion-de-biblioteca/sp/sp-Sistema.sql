USE biblioteca;
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'buscarUsuarioPorNombre'
)
DROP PROCEDURE Sistema.buscarUsuarioPorNombre
GO

CREATE PROCEDURE Sistema.buscarUsuarioPorNombre
    @nombre VARCHAR(50),
    @usuarioID BIGINT OUTPUT
AS
BEGIN
    DECLARE @error VARCHAR(150);
    IF @nombre = '' OR LEN(@nombre) = 0
        RETURN;
    BEGIN TRY
        SELECT @usuarioID = usuarioID FROM Seguridad.Usuario
        WHERE nombre = @nombre
    END TRY
    BEGIN CATCH
        SET @error = ERROR_MESSAGE() + 'No se encontró un usuario con el nombre ' + @nombre + '.';
        THROW 50002, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'buscarUsuarioPorCorreo'
)
DROP PROCEDURE Sistema.buscarUsuarioPorCorreo
GO

CREATE PROCEDURE Sistema.buscarUsuarioPorCorreo
    @correo VARCHAR(50),
    @usuarioID BIGINT OUTPUT 
AS
BEGIN
    DECLARE @error VARCHAR(150);
    IF @correo = '' OR LEN(@correo) = 0
        RETURN;
    BEGIN TRY
        SELECT @usuarioID = usuarioID FROM Seguridad.Usuario
        WHERE correo = @correo
    END TRY
    BEGIN CATCH
        SET @error = ERROR_MESSAGE() + 'No se encontró un usuario con el correo ' + @correo;
        THROW 50002, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'buscarAutor'
)
DROP PROCEDURE Sistema.buscarAutor
GO

CREATE PROCEDURE Sistema.buscarAutor
    @autor VARCHAR(100),
    @autorID BIGINT OUTPUT
AS
BEGIN
    DECLARE @error VARCHAR(150);
    IF @autor = '' OR LEN(@autor) = 0
        RETURN;
    BEGIN TRY
        SELECT @autorID = autorID 
        FROM Seguridad.Autor
        WHERE nombre = @autor
    END TRY
    BEGIN CATCH
        SET @error = ERROR_MESSAGE() + 'No se encontró un autor con el nombre: ' + @autor + '.';
        THROW 50002, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'buscarCategoria'
)
DROP PROCEDURE Sistema.buscarCategoria
GO

CREATE PROCEDURE Sistema.buscarCategoria
    @categoria VARCHAR(100),
    @categoriaID BIGINT OUTPUT
AS
BEGIN
    DECLARE @error VARCHAR(150);
    IF @categoria = '' OR LEN(@categoria) = 0
        RETURN;
    BEGIN TRY
        SELECT @categoriaID = categoriaID 
        FROM Seguridad.Categoria
        WHERE nombre = @categoria
    END TRY
    BEGIN CATCH
        SET @error = ERROR_MESSAGE() + 'No se encontró una categoria con el nombre: ' + @categoria + '.';
        THROW 50002, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'buscarLibroPorTitulo'
)
DROP PROCEDURE Sistema.buscarLibroPorTitulo
GO

CREATE PROCEDURE Sistema.buscarLibroPorTitulo
    @titulo VARCHAR(250),
    @libroID BIGINT OUTPUT
AS
BEGIN
    DECLARE @error VARCHAR(300);
    IF @titulo = '' OR LEN(@titulo) = 0
        RETURN;
    BEGIN TRY
        SELECT @libroID = libroID
        FROM Seguridad.Libro
        WHERE titulo = @titulo
    END TRY
    BEGIN CATCH
        SET @error = ERROR_MESSAGE() + 'No se encontró un libro con el titulo: ' + @titulo + '.';
        THROW 50002, @error, 1;
    END CATCH
END
GO