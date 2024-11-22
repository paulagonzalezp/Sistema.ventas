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



-- **ASIGNACIÓN DE PERMISOS**
-- Permisos para usuarios sobre la tabla `factura` y operaciones relacionadas
GRANT SELECT, UPDATE ON factura TO usuario_administrador;
GRANT SELECT ON factura TO usuario_vendedor;
GRANT INSERT ON factura TO usuario_vendedor;
GRANT INSERT ON factura TO usuario_administrador;
GRANT SELECT ON factura TO usuario_contador;
GRANT SELECT ON usuario_vendedor.factura TO usuario_contador;

-- **FUNCIÓN: Calcular Descuento**
-- Esta función calcula un descuento del 5% si el total de la compra supera los 10,000. 
-- De lo contrario, retorna el mismo valor sin descuento.
CREATE OR REPLACE FUNCTION FN_CalcularDescuento (
    total IN NUMBER -- Total de la compra
) RETURN NUMBER AS
    total_con_descuento NUMBER;                 
    porcentaje_descuento CONSTANT NUMBER := 0.05; 
    limite_del_total CONSTANT NUMBER := 10000;  
BEGIN
    IF total > limite_del_total THEN
        total_con_descuento := total - (total * porcentaje_descuento);
    ELSE
        total_con_descuento := total;
    END IF;

    RETURN total_con_descuento;
END;
/



-- **PROCEDIMIENTO: Registrar Venta**
/*Este procedimiento registra una venta en la base de datos. Realiza lo siguiente:
Verifica si hay suficiente stock disponible para el producto que se está vendiendo.
Si el stock es suficiente, inserta un nuevo registro en la tabla factura, actualiza la cantidad en stock del producto vendido y confirma la transacción.
Si no hay suficiente stock, muestra un mensaje de error indicando que el producto no tiene suficiente inventario.*/


GRANT INSERT ON factura TO usuario_vendedor;

CREATE OR REPLACE PROCEDURE procRegistrarVenta (
    rCFactura IN factura%ROWTYPE 
) AS
    
    vStockActual NUMBER;       
    pudoRegistrar NUMBER := 0; 
BEGIN
    
    SELECT cantidad_en_stock 
    INTO vStockActual
    FROM productos
    WHERE id_producto = rCFactura.id_producto;

 
    IF vStockActual >= rCFactura.cantidad THEN
     
        INSERT INTO factura (
            id_factura, detalle, cantidad, total, fecha, id_producto, id_cliente, id_metodo_pago, id_sucursal
        ) VALUES (
            rCFactura.id_factura, 
            rCFactura.detalle, 
            rCFactura.cantidad, 
            rCFactura.total, 
            rCFactura.fecha, 
            rCFactura.id_producto, 
            rCFactura.id_cliente, 
            rCFactura.id_metodo_pago, 
            rCFactura.id_sucursal
        );

      
        UPDATE productos
        SET cantidad_en_stock = cantidad_en_stock - rCFactura.cantidad
        WHERE id_producto = rCFactura.id_producto;

        pudoRegistrar := 1; 
    END IF;

    IF pudoRegistrar = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Stock insuficiente para el producto: ' || rCFactura.id_producto);
    ELSE
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Venta registrada exitosamente con ID: ' || rCFactura.id_factura);
    END IF;
END procRegistrarVenta;
/
