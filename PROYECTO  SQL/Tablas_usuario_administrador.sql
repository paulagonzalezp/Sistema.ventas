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



-- ** INSERT DE ADMININISTRADOR

-- Insertar en la tabla proveedores
-- Insertar en la tabla proveedores
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (1, 'Ropa Tica', 'contacto@ropatica.cr', '2222-3456');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (2, 'Estilo Costarricense', 'ventas@estilocr.com', '2299-8765');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (3, 'Moda Pura Vida', 'info@modapuravida.cr', '2233-1122');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (4, 'Fashion CR', 'atencion@fashioncr.cr', '2444-2233');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (5, 'Cultura y Estilo', 'cultura@estilocr.com', '2555-6677');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (6, 'Trendy Shop', 'soporte@trendystore.cr', '2666-4433');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (7, 'Accesorios Costarricenses', 'contacto@accesorioscr.com', '2777-8899');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (8, 'Look Tico', 'contacto@looktico.cr', '2888-3344');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (9, 'Vestir Tico', 'ventas@vestirtico.cr', '2999-5566');
INSERT INTO proveedores (id_proveedor, nombre_empresa, correo, telefono) VALUES (10, 'Ropa Tropical', 'info@ropatropical.cr', '3111-7788');


-- Insertar en la tabla categorias
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (1, 'Camisas', 'Camisas de diferentes estilos y materiales');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (2, 'Pantalones', 'Pantalones formales e informales para todo tipo de ocasión');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (3, 'Accesorios', 'Accesorios como bolsos, bufandas y joyería');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (4, 'Zapatos', 'Zapatos de diferentes tipos y diseños');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (5, 'Chaquetas', 'Chaquetas y abrigos para clima frío y lluvioso');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (6, 'Ropa Deportiva', 'Ropa cómoda y deportiva para todo tipo de actividad');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (7, 'Ropa Infantil', 'Ropa de niños con diseños divertidos y cómodos');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (8, 'Trajes de Baño', 'Trajes de baño para playa y piscina');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (9, 'Ropa Formal', 'Ropa elegante para eventos formales');
INSERT INTO categorias (id_categoria, nombre, descripcion) VALUES (10, 'Ropa Casual', 'Ropa cómoda para uso diario');



-- Insertar en la tabla productos
INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (1, 'Camisa Azul', 'Camisa de algodón azul, talla M', 12000, 50, '20/11/24 19:59:48', 10000, 1);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (2, 'Pantalón Negro', 'Pantalón negro de vestir, talla 34', 25000, 30, '20/11/24 19:59:48', 24000, 2);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (3, 'Bufanda Roja', 'Bufanda de lana roja, unisex', 8000, 20, '20/11/24 19:59:48', 7000, 3);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (4, 'Zapatos Deportivos', 'Zapatos deportivos, talla 42', 35000, 15, '20/11/24 19:59:48', 34000, 4);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (5, 'Chaqueta de Cuero', 'Chaqueta de cuero para clima frío', 80000, 10, '20/11/24 19:59:48', 78000, 5);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (6, 'Short Deportivo', 'Short cómodo para ejercicio', 15000, 40, '20/11/24 19:59:48', 14000, 6);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (7, 'Camiseta Infantil', 'Camiseta divertida para niños', 6000, 100, '20/11/24 19:59:48', 5000, 7);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (8, 'Bikini Playa', 'Bikini de dos piezas, talla S', 18000, 25, '20/11/24 19:59:48', 17000, 8);

INSERT INTO productos (id_producto, nombre, descripcion, precio, cantidad_en_stock, fecha_agregado, monto, id_categoria) 
VALUES (9, 'Traje Formal', 'Traje formal para hombre, talla 40', 120000, 5, '20/11/24 19:59:48', 115000, 9);


-- Insertar en la tabla inventario
INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (1, 1, 100, '01/10/24 12:00:00', 1, 1);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (2, 2, 80, '03/10/24 15:00:00', 2, 2);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (3, 3, 50, '05/10/24 09:00:00', 3, 3);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (4, 4, 30, '10/10/24 13:00:00', 4, 4);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (5, 5, 20, '12/10/24 16:00:00', 5, 5);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (6, 6, 150, '15/10/24 14:00:00', 6, 6);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (7, 7, 120, '17/10/24 11:00:00', 7, 7);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (8, 8, 60, '20/10/24 18:00:00', 8, 8);

INSERT INTO inventario (id_inventario, id_proveedor, cantidad, fecha_orden_de_compra, id_producto, id_proveedor_ref) 
VALUES (9, 9, 40, '25/10/24 10:00:00', 9, 9);


-- **ASIGNACIÓN DE PERMISOS**
-- Otorgar permisos a los usuarios para realizar actualizaciones en la tabla `productos`
GRANT UPDATE ON productos TO USUARIO_ADMINISTRADOR;
GRANT UPDATE ON productos TO USUARIO_VENDEDOR;

-- **PROCEDIMIENTO: Actualizar Inventario**
-- Este procedimiento permite actualizar el inventario de un producto. Si ya existe un registro para el producto 
-- y proveedor, incrementa la cantidad. De lo contrario, inserta un nuevo registro.
CREATE OR REPLACE PROCEDURE PA_ActualizarInventario (
    p_id_producto IN NUMBER,     
    p_cantidad IN NUMBER,        
    p_id_proveedor IN NUMBER    
) AS
    p_existente NUMBER;          
BEGIN
    
    SELECT COUNT(*)
    INTO p_existente
    FROM inventario
    WHERE id_producto = p_id_producto AND id_proveedor_ref = p_id_proveedor;

    IF p_existente > 0 THEN
       
        UPDATE inventario
        SET cantidad = cantidad + p_cantidad
        WHERE id_producto = p_id_producto AND id_proveedor_ref = p_id_proveedor;
    ELSE
      
        INSERT INTO inventario (id_producto, cantidad, id_proveedor_ref)
        VALUES (p_id_producto, p_cantidad, p_id_proveedor);
    END IF;

    
    UPDATE productos
    SET cantidad_en_stock = cantidad_en_stock + p_cantidad
    WHERE id_producto = p_id_producto;


    COMMIT;
END;
/

-- **Funcion: 3.Obtener Inventario Disponible **
-- Esta función calcula el inventario total disponible para un producto específico. 
-- Recibe como parámetro el identificador del producto (p_id_producto) y retorna la 
-- suma de las cantidades registradas en la tabla `inventario` para ese producto.
-- Si no existen registros para el producto, retorna 0.

CREATE OR REPLACE FUNCTION FN_ObtenerInventarioDisponible (
    p_id_producto IN NUMBER
) RETURN NUMBER AS
    v_inventario_disponible NUMBER; 
BEGIN

    v_inventario_disponible := 0;

  
    SELECT NVL(SUM(cantidad), 0)
    INTO v_inventario_disponible
    FROM inventario
    WHERE id_producto = p_id_producto;

   
    RETURN v_inventario_disponible;
END FN_ObtenerInventarioDisponible;
/
