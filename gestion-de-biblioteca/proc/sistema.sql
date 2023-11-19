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


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'agregarAutor'
)
DROP PROCEDURE Sistema.agregarAutor
GO

CREATE PROCEDURE Sistema.agregarAutor
    @autor VARCHAR(100)
AS
    DECLARE 
        @error VARCHAR(150),
        @autorID BIGINT;
    BEGIN TRY
        EXEC Sistema.buscarAutor @autor, @autorID OUTPUT;
        IF @autorID IS NOT NULL
        BEGIN
            SET @error = 'Ya existe otro autor con el mismo nombre.';
            THROW 50001, @error, 1;
        END

        INSERT INTO Seguridad.Autor(nombre) VALUES(@autor);
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar agregar al autor: ' + @autor + '.' + ERROR_MESSAGE();
        THROW 50001, @error, 1;
    END CATCH
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'agregarCategoria'
)
DROP PROCEDURE Sistema.agregarCategoria
GO

CREATE PROCEDURE Sistema.agregarCategoria
    @nombre VARCHAR(100),
    @descripcion VARCHAR(250) = NULL
AS
BEGIN
    DECLARE 
        @error VARCHAR(150),
        @categoriaID BIGINT;
    BEGIN TRY
        EXEC Sistema.buscarCategoria @nombre, @categoriaID OUTPUT;

        IF @categoriaID IS NOT NULL
        BEGIN
            SET @error = 'Ya existe otra categoria con el mismo nombre.'; 
        THROW 50001, @error, 1;
        END
        
        INSERT INTO Seguridad.Categoria(
            nombre, descripcion
        )
        VALUES(
            @nombre, @descripcion
        )
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar agregar la categoria: ' + @nombre + '.' + ERROR_MESSAGE(); 
        THROW 50001, @error, 1;
    END CATCH
END
GO

IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Sistema'
    AND SPECIFIC_NAME = N'agregarLibro'
)
DROP PROCEDURE Sistema.agregarLibro
GO

CREATE PROCEDURE Sistema.agregarLibro
    @titulo VARCHAR(250),
    @autor VARCHAR(100),
    @categoria VARCHAR(100),
    @cantpag INT = NULL,
    @fechaPublicacion DATE = NULL
AS
BEGIN
    DECLARE 
        @error VARCHAR(300),
        @autorID BIGINT,
        @categoriaID BIGINT,
        @libroID BIGINT;
    BEGIN TRY
        EXEC Sistema.buscarLibroPorTitulo
            @titulo, @libroID OUTPUT

        IF @libroID IS NOT NULL
        BEGIN
            SET @error = 'Ya existe un libro con el mismo título.';
            THROW 50001, @error, 1;
        END
        
        EXEC Sistema.buscarAutor 
            @autor, @autorID OUTPUT;
        
        IF @autorID IS NULL
        BEGIN
            SET @error = 'No se encontró al autor ' + @autor + '.';
            THROW 50001, @error, 1;
        END

        EXEC Sistema.buscarCategoria 
            @categoria, @categoriaID OUTPUT;
        
        IF @categoriaID IS NULL
        BEGIN
            SET @error = 'No se encontró la categoria ' + @categoria + '.';
            THROW 50001, @error, 1;
        END

        INSERT INTO Seguridad.Libro(
            titulo, autorID, categoriaID, cantpag, fechaPublicacion
        )
        VALUES(
            @titulo, @autorID, @categoriaID, @cantpag, @fechaPublicacion
        )
    END TRY
    BEGIN CATCH
        SET @error = 'Error al intentar agregar libro con el titulo: ' + @titulo + '.' + ERROR_MESSAGE();
        THROW 50001, @error, 1;
    END CATCH
END
GO