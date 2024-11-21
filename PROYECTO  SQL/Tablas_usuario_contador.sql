-- Tablas relacionadas con el usuario contador

-- Tabla: clientes
CREATE TABLE clientes (
    id_cliente NUMBER CONSTRAINT pk_clientes PRIMARY KEY,
    nombre VARCHAR2(100),
    telefono VARCHAR2(15),
    direccion VARCHAR2(255),
    email VARCHAR2(100),
    fecha_registro TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- Tabla: contador
CREATE TABLE contador (
    id_contador NUMBER CONSTRAINT pk_contador PRIMARY KEY,
    transacciones NUMBER,
    fecha_registro TIMESTAMP DEFAULT SYSTIMESTAMP,
    id_producto NUMBER CONSTRAINT fk1_contador REFERENCES usuario_administrador.productos,
    id_factura NUMBER, -- Referencia opcional a factura en usuario_vendedor (crear luego)
    id_cliente NUMBER CONSTRAINT fk3_contador REFERENCES clientes
);

-- Tabla: reportes_financieros
CREATE TABLE reportes_financieros (
    id_reporte NUMBER CONSTRAINT pk_reportes_financieros PRIMARY KEY,
    id_factura NUMBER,
    fecha_reporte TIMESTAMP DEFAULT SYSTIMESTAMP,
    total_ventas NUMBER(10, 2),
    id_factura_ref NUMBER CONSTRAINT fk2_reporte REFERENCES usuario_vendedor.factura
);

-- Otorgar permisos de referencias a otros usuarios desde "clientes" y "contador"
GRANT REFERENCES ON clientes TO usuario_vendedor;
GRANT REFERENCES ON clientes TO usuario_administrador;

--**INSERT DE LAS TABLAS CONTADOR **--


-- Insertar en la tabla clientes
INSERT INTO clientes (id_cliente, nombre, telefono, direccion, email) 
VALUES (1, 'Pedro Ramírez', '2222-1212', 'Avenida 1, San José', 'pedro@cliente.com');

INSERT INTO clientes (id_cliente, nombre, telefono, direccion, email) 
VALUES (2, 'Laura Sánchez', '2222-1313', 'Calle 3, Alajuela', 'laura@cliente.com');

INSERT INTO clientes (id_cliente, nombre, telefono, direccion, email) 
VALUES (3, 'Miguel Álvarez', '2222-1414', 'Calle 5, Cartago', 'miguel@cliente.com');

INSERT INTO clientes (id_cliente, nombre, telefono, direccion, email) 
VALUES (4, 'Sofía Castro', '2222-1515', 'Avenida 6, Heredia', 'sofia@cliente.com');

INSERT INTO clientes (id_cliente, nombre, telefono, direccion, email) 
VALUES (5, 'Carlos Fernández', '2222-1616', 'Calle 7, Guanacaste', 'carlos@cliente.com');

-- Insertar en la tabla contador
INSERT INTO contador (id_contador, transacciones, id_producto, id_factura, id_cliente) 
VALUES (1, 5, 1, 101, 1);

INSERT INTO contador (id_contador, transacciones, id_producto, id_factura, id_cliente) 
VALUES (2, 10, 2, 102, 2);

INSERT INTO contador (id_contador, transacciones, id_producto, id_factura, id_cliente) 
VALUES (3, 8, 3, 103, 3);

INSERT INTO contador (id_contador, transacciones, id_producto, id_factura, id_cliente) 
VALUES (4, 7, 4, 104, 4);

INSERT INTO contador (id_contador, transacciones, id_producto, id_factura, id_cliente) 
VALUES (5, 6, 5, 105, 5);

-- Insertar en la tabla reportes_financieros
INSERT INTO reportes_financieros (id_reporte, id_factura, total_ventas, id_factura_ref) 
VALUES (1, 101, 120000.00, 101);

INSERT INTO reportes_financieros (id_reporte, id_factura, total_ventas, id_factura_ref) 
VALUES (2, 102, 250000.00, 102);

INSERT INTO reportes_financieros (id_reporte, id_factura, total_ventas, id_factura_ref) 
VALUES (3, 103, 180000.00, 103);

INSERT INTO reportes_financieros (id_reporte, id_factura, total_ventas, id_factura_ref) 
VALUES (4, 104, 50000.00, 104);

INSERT INTO reportes_financieros (id_reporte, id_factura, total_ventas, id_factura_ref) 
VALUES (5, 105, 30000.00, 105);
