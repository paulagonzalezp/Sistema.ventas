-- Tablas relacionadas con el usuario vendedor

-- Tabla: metodos_pago
CREATE TABLE metodos_pago (
    id_metodo_pago NUMBER CONSTRAINT pk_metodos_pago PRIMARY KEY,
    nombre_metodo VARCHAR2(100),
    descripcion VARCHAR2(255)
);

-- Tabla: sucursales
CREATE TABLE sucursales (
    id_sucursal NUMBER CONSTRAINT pk_sucursales PRIMARY KEY,
    provincia VARCHAR2(50),
    direccion VARCHAR2(255),
    telefono VARCHAR2(15)
);

-- Tabla: empleados
CREATE TABLE empleados (
    id_empleado NUMBER CONSTRAINT pk_empleados PRIMARY KEY,
    nombre VARCHAR2(100),
    email VARCHAR2(100),
    telefono VARCHAR2(15),
    direccion VARCHAR2(255),
    fecha_contratado TIMESTAMP DEFAULT SYSTIMESTAMP,
    id_sucursal NUMBER CONSTRAINT fk1_empleados REFERENCES sucursales
);

-- Tabla: factura
CREATE TABLE factura (
    id_factura NUMBER PRIMARY KEY,
    detalle VARCHAR2(255),
    cantidad NUMBER,
    total NUMBER(10, 2),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_producto NUMBER CONSTRAINT fk1_factura REFERENCES usuario_administrador.productos,
    id_cliente NUMBER CONSTRAINT fk2_factura REFERENCES usuario_contador.clientes,
    id_metodo_pago NUMBER CONSTRAINT fk3_factura REFERENCES metodos_pago,
    id_sucursal NUMBER CONSTRAINT fk4_factura REFERENCES sucursales
);

-- Tabla: devoluciones
CREATE TABLE devoluciones (
    id_devolucion NUMBER CONSTRAINT pk_devoluciones PRIMARY KEY,
    motivo VARCHAR2(255),
    fecha_devolucion TIMESTAMP DEFAULT SYSTIMESTAMP,
    id_factura NUMBER CONSTRAINT fk1_devoluciones REFERENCES factura
);

-- Otorgar permisos de referencias desde "factura" y "devoluciones" a otros usuarios
GRANT REFERENCES ON factura TO usuario_administrador;
GRANT REFERENCES ON factura TO usuario_contador;
GRANT REFERENCES ON devoluciones TO usuario_contador;



--**INSERT DE LA TABLAS**--

-- Insertar en la tabla metodos_pago
INSERT INTO metodos_pago (id_metodo_pago, nombre_metodo, descripcion) 
VALUES (1, 'Tarjeta de Crédito', 'Pago mediante tarjeta de crédito');

INSERT INTO metodos_pago (id_metodo_pago, nombre_metodo, descripcion) 
VALUES (2, 'Efectivo', 'Pago en efectivo al momento de la compra');

INSERT INTO metodos_pago (id_metodo_pago, nombre_metodo, descripcion) 
VALUES (3, 'Transferencia Bancaria', 'Pago mediante transferencia a cuenta bancaria');

INSERT INTO metodos_pago (id_metodo_pago, nombre_metodo, descripcion) 
VALUES (4, 'PayPal', 'Pago mediante la plataforma de pagos PayPal');

INSERT INTO metodos_pago (id_metodo_pago, nombre_metodo, descripcion) 
VALUES (5, 'Pago Móvil', 'Pago mediante plataformas de pago móvil');

-- Insertar en la tabla sucursales
INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono) 
VALUES (1, 'San José', 'Avenida Central, San José', '2222-1111');

INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono) 
VALUES (2, 'Alajuela', 'Calle 2, Alajuela', '2222-2222');

INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono) 
VALUES (3, 'Cartago', 'Calle 3, Cartago', '2222-3333');

INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono) 
VALUES (4, 'Heredia', 'Calle 4, Heredia', '2222-4444');

INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono) 
VALUES (5, 'Guanacaste', 'Calle 5, Guanacaste', '2222-5555');

-- Insertar en la tabla empleados
INSERT INTO empleados (id_empleado, nombre, email, telefono, direccion, id_sucursal) 
VALUES (1, 'Carlos Gómez', 'carlos@tienda.com', '2222-6666', 'Avenida Central, San José', 1);

INSERT INTO empleados (id_empleado, nombre, email, telefono, direccion, id_sucursal) 
VALUES (2, 'María López', 'maria@tienda.com', '2222-7777', 'Calle 2, Alajuela', 2);

INSERT INTO empleados (id_empleado, nombre, email, telefono, direccion, id_sucursal) 
VALUES (3, 'Juan Pérez', 'juan@tienda.com', '2222-8888', 'Calle 3, Cartago', 3);

INSERT INTO empleados (id_empleado, nombre, email, telefono, direccion, id_sucursal) 
VALUES (4, 'Ana Rodríguez', 'ana@tienda.com', '2222-9999', 'Calle 4, Heredia', 4);

INSERT INTO empleados (id_empleado, nombre, email, telefono, direccion, id_sucursal) 
VALUES (5, 'Luis Martínez', 'luis@tienda.com', '2222-1010', 'Calle 5, Guanacaste', 5);
