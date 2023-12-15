USE biblioteca;
GO

-- Registros para probar buscarUsuarioPorNombre y buscarUsuarioPorCorreo
INSERT INTO Seguridad.Usuario (dni, nombre, correo, clave)
VALUES
    (123456789, 'Usuario1', 'usuario1@example.com', 'clave123'),
    (987654321, 'Usuario2', 'usuario2@example.com', 'clave456'),
    (555555555, 'Usuario3', 'usuario3@example.com', 'clave789');

SELECT * FROM Seguridad.Usuario

-- Registros para probar buscarAutor y buscarCategoria
INSERT INTO Seguridad.Autor (nombre) VALUES ('Autor1'), ('Autor2'), ('Autor3');

SELECT * FROM Seguridad.Autor

INSERT INTO Seguridad.Categoria (nombre, descripcion) VALUES ('Categoria1', 'Descripción1'), ('Categoria2', 'Descripción2');

SELECT * FROM Seguridad.Categoria

-- Registros para probar agregarUsuario
EXEC Cliente.agregarUsuario 111111111, 'NuevoUsuario', 'nuevousuario@example.com', 'clave123';

-- Registros para probar agregarAutor
EXEC OperacionesBiblioteca.agregarAutor 'NuevoAutor';

-- Registros para probar agregarCategoria
EXEC OperacionesBiblioteca.agregarCategoria 'NuevaCategoria', 'DescripciónNuevaCategoria';

-- Ver inserciones

SELECT * FROM Seguridad.Usuario
SELECT * FROM Seguridad.Autor
SELECT * FROM Seguridad.Categoria

-- Registros para probar agregarLibro
DECLARE @autorID BIGINT, @categoriaID BIGINT;

-- Obtener IDs de autor y categoría existentes
EXEC Sistema.buscarAutor 'Autor1', @autorID OUTPUT;
EXEC Sistema.buscarCategoria 'Categoria1', @categoriaID OUTPUT;

SELECT @autorID, @categoriaID

-- Agregar un libro con autor y categoría existentes
EXEC OperacionesBiblioteca.agregarLibro 'Libro1', 'Autor1', 'Categoria1', 200, '2023-01-01';

SELECT * FROM Seguridad.Libro

-- Agregar un libro con un nuevo autor y nueva categoría
EXEC OperacionesBiblioteca.agregarLibro 'Libro2', 'NuevoAutor', 'NuevaCategoria', 150, '2023-02-01';



/*Maxima cantidad de paginas en general*/

SELECT 
    L.titulo AS [Titulo],
    A.nombre AS [Autor],
    C.nombre AS [Categoria],
    L.fechaPublicacion AS [Fecha de Publicacion],
    L.cantpag AS [Paginas],
    MAX(cantpag) OVER() AS MaxPag
FROM Seguridad.Libro L
JOIN Seguridad.Autor A 
    ON L.autorID = A.autorID
JOIN Seguridad.Categoria C
    ON L.categoriaID = C.categoriaID


/*Maxima cantidad de paginas para una fecha*/

SELECT 
    L.titulo AS [Titulo],
    A.nombre AS [Autor],
    C.nombre AS [Categoria],
    L.fechaPublicacion AS [Fecha de Publicacion],
    L.cantpag AS [Paginas],
    MAX(cantpag) OVER(PARTITION BY L.fechaPublicacion) AS MaxPagParaFecha
FROM Seguridad.Libro L
JOIN Seguridad.Autor A 
    ON L.autorID = A.autorID
JOIN Seguridad.Categoria C
    ON L.categoriaID = C.categoriaID

/*Max cantidad de paginas para una categoria*/

SELECT 
    L.titulo AS [Titulo],
    A.nombre AS [Autor],
    C.nombre AS [Categoria],
    L.fechaPublicacion AS [Fecha de Publicacion],
    L.cantpag AS [Paginas],
    MAX(L.cantpag) OVER(PARTITION BY C.nombre) AS MaxCantPagPorCategoria
FROM Seguridad.Libro L
JOIN Seguridad.Autor A 
    ON L.autorID = A.autorID
JOIN Seguridad.Categoria C
    ON L.categoriaID = C.categoriaID


/*Max cantidad de usuarios creados para cada fecha (dia)*/

WITH CantidadUsuarios(FechaCreacion, Cantidad) AS
(
    SELECT 
    CAST(fechaCreacion AS DATE),
    COUNT(1) OVER(PARTITION BY CAST(fechaCreacion AS DATE))
    FROM Seguridad.Usuario
)
SELECT 
FechaCreacion AS [Fecha de Creacion], Cantidad
FROM CantidadUsuarios
GROUP BY FechaCreacion, Cantidad

select * from Seguridad.Usuario