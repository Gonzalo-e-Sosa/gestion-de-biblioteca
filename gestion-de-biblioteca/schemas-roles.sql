USE biblioteca;
GO


-- Esquema para tablas
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Seguridad')
BEGIN
    CREATE SCHEMA Seguridad;
END
ELSE
    DROP SCHEMA Seguridad;
GO

-- Esquema para registros de inserciones, borrados, etc
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Auditoria')
BEGIN
    CREATE SCHEMA Auditoria;
END
ELSE 
    DROP SCHEMA Auditoria;
GO

-- Esquema para uso general
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Sistema')
BEGIN
    CREATE SCHEMA Sistema;
END
ELSE
    DROP SCHEMA Sistema;
GO

-- Esquema para usuarios
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Cliente')
BEGIN
    CREATE SCHEMA Cliente;
END
ELSE
    DROP SCHEMA Cliente;
GO

-- Esquema para bibliotecarios
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'OperacionesBiblioteca')
BEGIN
    CREATE SCHEMA OperacionesBiblioteca;
END
ELSE
    DROP SCHEMA OperacionesBiblioteca;
GO

-- Creación de Roles
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE type_desc = 'DATABASE_ROLE' AND name = 'Admin')
BEGIN
    CREATE ROLE Admin;
END
ELSE
    DROP ROLE Admin;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE type_desc = 'DATABASE_ROLE' AND name = 'Bibliotecario')
BEGIN
    CREATE ROLE Bibliotecario;
END
ELSE
    DROP ROLE Bibliotecario;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE type_desc = 'DATABASE_ROLE' AND name = 'Usuario')
BEGIN
    CREATE ROLE Usuario;
END
ELSE
    DROP ROLE Usuario;
GO

-- Asignación de Roles a Usuarios
/*
ALTER ROLE Admin ADD MEMBER [nombre_de_usuario_admin];
ALTER ROLE Bibliotecario ADD MEMBER [nombre_de_usuario_bibliotecario];
ALTER ROLE Usuario ADD MEMBER [nombre_de_usuario_usuario];
*/

-- Asignación de Permisos de Esquema

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Seguridad TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Auditoria TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sistema TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::OperacionesBiblioteca TO Admin;

GRANT SELECT ON SCHEMA::Cliente TO Usuario

GRANT SELECT ON SCHEMA::Sistema TO Usuario
GRANT SELECT ON SCHEMA::Sistema TO Bibliotecario

GRANT SELECT ON SCHEMA::OperacionesBiblioteca TO Bibliotecario