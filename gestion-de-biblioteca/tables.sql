USE biblioteca;
GO

/* DROP TABLES */

IF OBJECT_ID('Seguridad.Prestamo', 'U') IS NOT NULL
DROP TABLE Seguridad.Prestamo;
GO

IF OBJECT_ID('Seguridad.Ejemplar', 'U') IS NOT NULL
DROP TABLE Seguridad.Ejemplar;
GO

IF OBJECT_ID('Seguridad.Libro', 'U') IS NOT NULL
DROP TABLE Seguridad.Libro;
GO

IF OBJECT_ID('Seguridad.Autor', 'U') IS NOT NULL
DROP TABLE Seguridad.Autor;
GO

IF OBJECT_ID('Seguridad.Categoria', 'U') IS NOT NULL
DROP TABLE Seguridad.Categoria;
GO

IF OBJECT_ID('Seguridad.Usuario', 'U') IS NOT NULL
DROP TABLE Seguridad.Usuario;
GO


/* CREATE TABLES */

CREATE TABLE Seguridad.Usuario
(
    usuarioID BIGINT IDENTITY(1, 1) PRIMARY KEY,
    dni INT NOT NULL CHECK(dni > 0),
    nombre VARCHAR(50) NOT NULL UNIQUE,
    correo VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(250) NOT NULL,
    activo BIT DEFAULT 1,
    fechaCreacion DATETIME DEFAULT GETDATE(),
);
GO

CREATE TABLE Seguridad.Autor
(
    autorID BIGINT IDENTITY(1, 1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Seguridad.Categoria
(
    categoriaID BIGINT IDENTITY(1, 1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250) 
);
GO


CREATE TABLE Seguridad.Libro
(
    libroID BIGINT IDENTITY(1, 1) PRIMARY KEY, 
    titulo VARCHAR(250) NOT NULL,
    autorID BIGINT FOREIGN KEY REFERENCES Seguridad.Autor(autorID),
    categoriaID BIGINT FOREIGN KEY REFERENCES Seguridad.Categoria(categoriaID),
    cantpag INT,
    fechaPublicacion DATE
);
GO

CREATE TABLE Seguridad.Ejemplar
(
    ejemplarID BIGINT NOT NULL,
    libroID BIGINT NOT NULL,
    PRIMARY KEY(ejemplarID, libroID),
    FOREIGN KEY(libroID) REFERENCES Seguridad.Libro(libroID) ON DELETE CASCADE,
);
GO

CREATE TABLE Seguridad.Prestamo
(
    prestamoID BIGINT IDENTITY(1, 1) PRIMARY KEY, 
    usuarioID BIGINT FOREIGN KEY REFERENCES Seguridad.Usuario(usuarioID),
    libroID BIGINT NOT NULL,
    ejemplarID BIGINT NOT NULL,
    fechaPrestamo DATE DEFAULT GETDATE(),
    fechaVencimiento DATE DEFAULT DATEADD(DAY, 7, GETDATE()),
    vencido BIT DEFAULT 0,
    fechaDevolucion DATE,
    CONSTRAINT fk_prestamo_ejemplar FOREIGN KEY(libroID, ejemplarID) REFERENCES Seguridad.Ejemplar(ejemplarID, libroID)
);
GO