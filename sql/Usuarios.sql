
ALTER SESSION SET "_oracle_script"=true;

--Usuario ADMINISTRADOR
CREATE USER usuario_administrador IDENTIFIED BY usuario_administrador
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO usuario_administrador;

--Usuario VENDEDOR
CREATE USER usuario_vendedor IDENTIFIED BY usuario_vendedor
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO usuario_vendedor;

--Usuario CONTADOR
CREATE USER usuario_contador IDENTIFIED BY usuario_contador
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO usuario_contador;


--Permisos globales para creacion de procedimientos (PARA LA CREACION DE PRODECIMIENTOS)USUARIO SYS
GRANT CREATE PROCEDURE TO usuario_administrador;
GRANT CREATE PROCEDURE TO usuario_contador;
GRANT CREATE VIEW TO usuario_administrador; -- Si usas vistas en el procedimiento

--**permisos para usuario administrador triggers
GRANT CREATE TRIGGER TO usuario_administrador;--NUEVO PERMIRSO*********************************
GRANT CREATE ANY TRIGGER TO usuario_administrador;--NUEVO PERMIRSO*********************************
GRANT ALTER ANY TRIGGER TO usuario_administrador;--NUEVO PERMIRSO*********************************
GRANT EXECUTE ANY PROCEDURE TO usuario_administrador;--NUEVO PERMIRSO*********************************


--Permisos usuario vendedor trigger--
GRANT CREATE PROCEDURE TO usuario_vendedor;--NUEVO PERMISO*********************************
GRANT CREATE TRIGGER TO USUARIO_VENDEDOR;--NUEVO PERMISO*********************************



-- Consultas para verificar los privilegios y configuración de los usuarios

-- Verificar la configuración de los usuarios
SELECT username, default_tablespace, temporary_tablespace
FROM dba_users
WHERE username LIKE 'USUARIO%';

SELECT *
FROM dba_ts_quotas
WHERE username LIKE 'USUARIO%';

-- Verificar objetos creados
SELECT owner, object_name, object_type
FROM dba_objects
WHERE owner LIKE 'USUARIO%';

-- Verificar privilegios del sistema
SELECT *
FROM dba_sys_privs
WHERE grantee LIKE 'USUARIO%';

-- Verificar permisos en tablas específicos
SELECT *
FROM dba_tab_privs
WHERE grantee LIKE 'USUARIO%';
