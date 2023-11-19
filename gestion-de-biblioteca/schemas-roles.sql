USE biblioteca;
GO

-- Creación de Esquemas
CREATE SCHEMA Seguridad;
GO

CREATE SCHEMA Auditoria;
GO

CREATE SCHEMA Sistema;
GO

CREATE SCHEMA Cliente;
GO

-- Creación de Roles
CREATE ROLE Admin;
CREATE ROLE Bibliotecario;
CREATE ROLE Usuario;

-- Asignación de Roles a Usuarios
/*
ALTER ROLE Admin ADD MEMBER [nombre_de_usuario_admin];
ALTER ROLE Bibliotecario ADD MEMBER [nombre_de_usuario_bibliotecario];
ALTER ROLE Usuario ADD MEMBER [nombre_de_usuario_usuario];
*/

-- Asignación de Permisos de Esquema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Seguridad TO Admin;

/*
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Seguridad TO Bibliotecario;
GRANT SELECT ON SCHEMA::Seguridad TO Usuario;
*/

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Auditoria TO Admin;

-- Puedes seguir asignando más permisos según tus necesidades
