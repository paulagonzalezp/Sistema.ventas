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

CREATE TABLE Compras (
	idPeticion number constraint pk_compras primary key, 
	idProducto number,
	cantidadPorCompar number,
	estado number);
    
    
CREATE TABLE Rechazos (
idPeticion number,
idProducto number,
cantidadSolicitada number,
cantidadRechazada number);

-- Permisos para la tabla 'compras' en el esquema 'usuario_vendedor'
GRANT SELECT, INSERT, UPDATE ON usuario_vendedor.Compras TO transact_user;

-- Permisos para la tabla 'rechazos' en el esquema 'usuario_vendedor'
GRANT SELECT, INSERT ON usuario_vendedor.Rechazos TO transact_user;
