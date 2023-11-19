USE master
GO

IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'biblioteca'
)
CREATE DATABASE biblioteca
COLLATE Latin1_General_CS_AS
GO