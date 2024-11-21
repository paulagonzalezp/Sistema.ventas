
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
