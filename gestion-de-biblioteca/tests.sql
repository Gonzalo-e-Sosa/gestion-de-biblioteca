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
EXEC Sistema.agregarAutor 'NuevoAutor';

-- Registros para probar agregarCategoria
EXEC Sistema.agregarCategoria 'NuevaCategoria', 'DescripciónNuevaCategoria';

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
EXEC Sistema.agregarLibro 'Libro1', 'Autor1', 'Categoria1', 200, '2023-01-01';

SELECT * FROM Seguridad.Libro

-- Agregar un libro con un nuevo autor y nueva categoría
EXEC Sistema.agregarLibro 'Libro2', 'NuevoAutor', 'NuevaCategoria', 150, '2023-02-01';
