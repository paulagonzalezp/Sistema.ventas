--Pasos para usuaio_general
-- 1. Crear el Rol
CREATE ROLE rol_cliente;

-- 2. Conceder privilegios al Rol (Permiso para insertar en la tabla de clientes y hacer select)
GRANT INSERT ON usuario_contador.clientes TO rol_cliente;
GRANT SELECT ON usuario_contador.clientes TO rol_cliente;

-- 3. Crear el Usuario
CREATE USER usuario_general IDENTIFIED BY usuario_general;

-- 4. Asignar el Rol al Usuario
GRANT rol_cliente TO usuario_general;

-- 5. Conceder permisos adicionales al Usuario (Conexión y otros privilegios)
GRANT CONNECT, RESOURCE TO usuario_general;

-- 6. Conceder permisos para manipular la base de datos
GRANT CREATE SESSION TO usuario_general;