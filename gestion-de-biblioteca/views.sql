USE biblioteca;
GO


IF EXISTS (
SELECT *
    FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'Sistema'
    AND sys.views.name = N'verUsuarios'
)
DROP VIEW Sistema.verUsuarios
GO

CREATE VIEW Sistema.verUsuarios
AS
    SELECT 
        dni AS [DNI],
        nombre AS [Usuario],
        correo AS [Correo],
        fechaCreacion AS [Fecha de Creación]
    FROM Seguridad.Usuario
GO


IF EXISTS (
SELECT *
    FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'Sistema'
    AND sys.views.name = N'verPrestamos'
)
DROP VIEW Sistema.verPrestamos
GO

CREATE VIEW Sistema.verPrestamos
AS
    SELECT 
        P.fechaPrestamo AS [Fecha de Prestamo],
        P.fechaVencimiento AS [Fecha de Vencimiento],
        P.vencido AS [Vencido],
        P.fechaDevolucion AS [Fecha de Devolución],
        U.dni AS [DNI],
        U.nombre AS [Usuario],
        L.titulo AS [Libro]
    FROM Seguridad.Prestamo P
    JOIN Seguridad.Usuario U 
        ON U.usuarioID = P.usuarioID 
    JOIN Seguridad.Ejemplar E 
        ON E.ejemplarID = P.ejemplarID
    JOIN Seguridad.Libro L 
        ON E.libroID = L.libroID
GO


IF EXISTS (
SELECT *
    FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'Sistema'
    AND sys.views.name = N'verLibros'
)
DROP VIEW Sistema.verLibros
GO

CREATE VIEW Sistema.verLibros
AS
    SELECT 
        L.titulo AS [Titulo],
        A.nombre AS [Autor],
        C.nombre AS [Categoria],
        L.cantpag AS [Páginas],
        L.fechaPublicacion AS [Fecha de Publiación]
    FROM Seguridad.Libro L
    JOIN Seguridad.Autor A
        ON A.autorID = L.autorID
    JOIN Seguridad.Categoria C 
        ON C.categoriaID = L.categoriaID
GO


IF EXISTS (
SELECT *
    FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'Sistema'
    AND sys.views.name = N'verAutores'
)
DROP VIEW Sistema.verAutores
GO

CREATE VIEW Sistema.verAutores
AS
    SELECT 
        A.nombre AS [Autor] 
    FROM Seguridad.Autor A
GO


IF EXISTS (
SELECT *
    FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
    WHERE sys.schemas.name = N'Sistema'
    AND sys.views.name = N'verCategorias'
)
DROP VIEW Sistema.verCategorias
GO

CREATE VIEW Sistema.verCategorias
AS
    SELECT 
        C.nombre AS [Categoria],
        C.descripcion AS [Descripción]
    FROM Seguridad.Categoria C
GO

/*
-- Asignar Permiso de Lectura a la Vista
GRANT SELECT ON Seguridad.VistaLibros TO Bibliotecario;
GRANT SELECT ON Seguridad.VistaLibros TO Usuario;
*/