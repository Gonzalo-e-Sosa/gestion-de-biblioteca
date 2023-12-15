USE biblioteca;
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'OperacionesBiblioteca'
    AND SPECIFIC_NAME = N'agregarAutor'
)
DROP PROCEDURE OperacionesBiblioteca.agregarAutor
GO

CREATE PROCEDURE OperacionesBiblioteca.agregarAutor
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
WHERE SPECIFIC_SCHEMA = N'OperacionesBiblioteca'
    AND SPECIFIC_NAME = N'agregarCategoria'
)
DROP PROCEDURE OperacionesBiblioteca.agregarCategoria
GO

CREATE PROCEDURE OperacionesBiblioteca.agregarCategoria
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
WHERE SPECIFIC_SCHEMA = N'OperacionesBiblioteca'
    AND SPECIFIC_NAME = N'agregarLibro'
)
DROP PROCEDURE OperacionesBiblioteca.agregarLibro
GO

CREATE PROCEDURE OperacionesBiblioteca.agregarLibro
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


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'AdminBiblioteca'
    AND SPECIFIC_NAME = N'editarAutor'
)
DROP PROCEDURE AdminBiblioteca.editarAutor
GO

CREATE PROCEDURE AdminBiblioteca.editarAutor
    @autorID BIGINT,
    @nombreNuevo VARCHAR(100)
AS
BEGIN
    DECLARE @error VARCHAR(100);
    IF 
        @nombreNuevo IS NULL OR
        @nombreNuevo = '' OR
        LEN(@nombreNuevo) = 0
    BEGIN
        SET @error = 'Parametros no validos.';
        THROW 50004, @error, 1;
    END
    BEGIN TRY
        UPDATE Seguridad.Autor
        SET nombre = @nombreNuevo
        WHERE autorID = @autorID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al editar el nombre del autor.' + ERROR_MESSAGE();
        THROW 50003, @error, 1;
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'AdminBiblioteca'
    AND SPECIFIC_NAME = N'editarCategoria'
)
DROP PROCEDURE AdminBiblioteca.editarCategoria
GO

CREATE PROCEDURE AdminBiblioteca.editarCategoria
    @categoriaID BIGINT,
    @nombreNuevo VARCHAR(100) = NULL,
    @descripcionNueva VARCHAR(250)= NULL
AS
BEGIN
    DECLARE @error VARCHAR(100);
    IF 
        @nombreNuevo = '' OR 
        @descripcionNueva = '' OR
        LEN(@nombreNuevo) = 0 OR
        LEN(@descripcionNueva) = 0
    BEGIN 
        SET @error = 'Parametros no validos.';
        THROW 50004, @error, 1;
    END
    IF 
        @nombreNuevo IS NULL AND 
        @descripcionNueva IS NULL
    BEGIN
        SET @error = 'Ambos paramatetros NULL.';
        THROW 50004, @error, 1;
    END
    BEGIN TRY
        IF @nombreNuevo IS NULL
        BEGIN
            UPDATE Seguridad.Categoria
            SET descripcion = @descripcionNueva
            WHERE categoriaID = @categoriaID
        END
        ELSE
            UPDATE Seguridad.Categoria
            SET nombre = @nombreNuevo
            WHERE categoriaID = @categoriaID        
    END TRY
    BEGIN CATCH
        SET @error = 'Error al editar la categoria.' + ERROR_MESSAGE();
        THROW 50003, @error, 1;
    END CATCH
END    
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'AdminBiblioteca'
    AND SPECIFIC_NAME = N'editarLibro'
)
DROP PROCEDURE AdminBiblioteca.editarLibro
GO

CREATE PROCEDURE AdminBiblioteca.editarLibro
    @libroID BIGINT,
    @autorID BIGINT,
    @categoriaID BIGINT,
    @tituloNuevo VARCHAR(250) = NULL,
    @cantpagNuevo INT = NULL,
    @fechaPublicacionNueva DATE = NULL
AS
BEGIN
    DECLARE @error VARCHAR(100);
    IF 
        @tituloNuevo = '' OR 
        LEN(@tituloNuevo) = 0
    BEGIN
        SET @error = 'Parametros no validos.';
        THROW 50003, @error, 1;
    END
    IF 
        @tituloNuevo IS NULL AND 
        @cantpagNuevo IS NULL AND
        @fechaPublicacionNueva IS NULL
    BEGIN
        SET @error = 'Todos los parametros son NULL.';
        THROW 50003, @error, 1;
    END    
    BEGIN TRY
        IF @tituloNuevo IS NOT NULL
        BEGIN
            UPDATE Seguridad.Libro
            SET titulo = @tituloNuevo
            WHERE categoriaID = @categoriaID     
        END
        IF @cantpagNuevo IS NOT NULL
        BEGIN
            UPDATE Seguridad.Libro
            SET cantpag = @cantpagNuevo
            WHERE categoriaID = @categoriaID     
        END
        IF @fechaPublicacionNueva IS NOT NULL
        BEGIN
            UPDATE Seguridad.Libro
            SET fechaPublicacion = @fechaPublicacionNueva
            WHERE categoriaID = @categoriaID     
        END 
    END TRY
    BEGIN CATCH
        SET @error = 'Error al editar el libro.' + ERROR_MESSAGE();
        THROW 50004, @error, 1;    
    END CATCH
END
GO


IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'AdminBiblioteca'
    AND SPECIFIC_NAME = N'borrarAutor'
)
DROP PROCEDURE AdminBiblioteca.borrarAutor
GO

CREATE PROCEDURE AdminBiblioteca.borrarAutor
    @autorID BIGINT
AS
    DECLARE @error VARCHAR(100);
    BEGIN TRY
        IF
        
        DELETE FROM Seguridad.Autor
        WHERE autorID = @autorID
    END TRY
    BEGIN CATCH
        SET @error = 'Error al eliminar el autor.' + ERROR_MESSAGE();
        THROW 50005, @error, 1;
    END CATCH
GO