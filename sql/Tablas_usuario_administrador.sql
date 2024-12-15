-- Tablas relacionadas con el usuario administrador

-- Tabla: proveedores
CREATE TABLE proveedores (
    id_proveedor NUMBER CONSTRAINT pk_proveedores PRIMARY KEY,
    nombre_empresa VARCHAR2(100),
    correo VARCHAR2(100),
    telefono VARCHAR2(15)
);

-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria NUMBER CONSTRAINT pk_categorias PRIMARY KEY,
    nombre VARCHAR2(100),
    descripcion VARCHAR2(255)
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto NUMBER CONSTRAINT pk_productos PRIMARY KEY,
    nombre VARCHAR2(100),
    descripcion VARCHAR2(255),
    precio NUMBER(10, 2),
    cantidad_en_stock NUMBER,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto NUMBER(10, 2),
    id_categoria NUMBER CONSTRAINT fk1_productos REFERENCES categorias
);

-- Tabla: inventario
CREATE TABLE inventario (
    id_inventario NUMBER CONSTRAINT pk_inventario PRIMARY KEY,
    id_proveedor NUMBER,
    cantidad NUMBER,
    fecha_orden_de_compra TIMESTAMP DEFAULT SYSTIMESTAMP,
    id_producto NUMBER CONSTRAINT fk1_inventario REFERENCES productos,
    id_proveedor_ref NUMBER CONSTRAINT fk2_inventario REFERENCES proveedores
);

-- Otorgar permisos de referencias desde "productos" a otros usuarios
GRANT REFERENCES ON productos TO usuario_vendedor;
GRANT REFERENCES ON productos TO usuario_contador;

-- Permisos para la tabla 'productos' en el esquema 'usuario_administrador'
GRANT SELECT, UPDATE ON usuario_administrador.productos TO transact_user;