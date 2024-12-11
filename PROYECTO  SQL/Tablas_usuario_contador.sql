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

