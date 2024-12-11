alter session set "_oracle_script"=true;
CREATE ROLE ADMIN_ROL;

-- Permitir crear y administrar funciones, procedimientos y triggers
GRANT CREATE PROCEDURE TO ADMIN_ROL;
GRANT CREATE TRIGGER TO ADMIN_ROL;
GRANT ALTER ANY PROCEDURE TO ADMIN_ROL;
GRANT ALTER ANY TRIGGER TO ADMIN_ROL;

-- Permitir manejar tablas
GRANT CREATE TABLE TO ADMIN_ROL;
GRANT DROP ANY TABLE TO ADMIN_ROL;

-- Pendiente Permitir gesti�n de usuarios y roles
GRANT CREATE USER TO ADMIN_ROL;
GRANT GRANT ANY PRIVILEGE TO ADMIN_ROL;

-- Asignar el rol a usuario_administrador
GRANT ADMIN_ROL TO usuario_administrador;

--*********************************************

CREATE ROLE VENDEDOR_ROL;

-- Permitir manipular datos en las tablas de ventas y productos
GRANT SELECT, INSERT, UPDATE, DELETE ON usuario_administrador.productos TO VENDEDOR_ROL;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuario_administrador.inventario TO VENDEDOR_ROL;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuario_administrador.categorias TO VENDEDOR_ROL;


-- Asignar el rol al usuario_vendedor
GRANT VENDEDOR_ROL TO usuario_vendedor;

--*****************************************************

CREATE ROLE CONTADOR_ROL;

-- Permitir consultar tablas de clientes, transacciones y reportes financieros

GRANT SELECT, INSERT, UPDATE, DELETE ON usuario_contador.reportes_financieros TO CONTADOR_ROL;

-- Permitir consultar las tablas relacionadas con facturas y devoluciones
GRANT SELECT ON usuario_vendedor.devoluciones TO CONTADOR_ROL;
GRANT SELECT, INSERT, DELETE ON usuario_vendedor.factura TO CONTADOR_ROL;
-- Asignar el rol al usuario_contador
GRANT CONTADOR_ROL TO usuario_contador;

--*************************************************

--Permisos de ejecuci�n de funciones, procedimientos y triggers

GRANT EXECUTE ON nombre_funcion TO VENDEDOR_ROL;
GRANT EXECUTE ON nombre_procedimiento TO CONTADOR_ROL;

