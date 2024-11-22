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




-- **ASIGNACIÓN DE PERMISOS**

-- Permisos para el procedimiento de generar reporte financiero
GRANT INSERT, SELECT ON reportes_financieros TO usuario_administrador;
GRANT INSERT, SELECT ON reportes_financieros TO usuario_vendedor;

-- Permisos para la función de calcular total de ventas por producto
GRANT EXECUTE ON calcular_total_ventas_por_producto TO usuario_contador;

-- Permisos específicos sobre tablas relacionadas con clientes
GRANT SELECT ON usuario_contador.clientes TO usuario_vendedor;
GRANT SELECT ON clientes TO usuario_vendedor;

-- Permisos adicionales para facturas
GRANT SELECT ON factura TO usuario_contador;
GRANT SELECT ON factura TO usuario_administrador;
GRANT SELECT ON usuario_vendedor.factura TO usuario_contador;
GRANT INSERT ON factura TO usuario_vendedor;
GRANT SELECT, INSERT ON factura TO usuario_vendedor;


-- **PROCEDIMIENTOS **

-- **Procedimiento: Generar Reporte Financiero Mensual**
-- Este procedimiento calcula el total de ventas para un mes y año específicos,
-- genera un nuevo ID para el reporte, e inserta los datos en la tabla `reportes_financieros`.
CREATE OR REPLACE PROCEDURE GENERAR_REPORTE_FINANCIERO (
    p_mes IN NUMBER,  
    p_ano IN NUMBER   
) AS
    v_total_ventas NUMBER(10, 2); -- Variable para almacenar el total de ventas calculado
    v_id_reporte NUMBER;         -- Variable para almacenar el nuevo ID del reporte
BEGIN
    -- Calcular el total de ventas del mes y año proporcionados
    SELECT NVL(SUM(total), 0) 
    INTO v_total_ventas
    FROM usuario_vendedor.factura
    WHERE EXTRACT(MONTH FROM fecha) = p_mes
      AND EXTRACT(YEAR FROM fecha) = p_ano;

    -- Generar un nuevo ID para el reporte
    SELECT NVL(MAX(id_reporte), 0) + 1
    INTO v_id_reporte
    FROM reportes_financieros;

    -- Insertar el reporte financiero en la tabla
    INSERT INTO reportes_financieros (id_reporte, fecha_reporte, total_ventas)
    VALUES (v_id_reporte, SYSTIMESTAMP, v_total_ventas);

    -- Confirmar la transacción
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Reporte generado exitosamente con ID: ' || v_id_reporte);
EXCEPTION
    WHEN OTHERS THEN
        -- En caso de error, deshacer la transacción y mostrar un mensaje
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
END GENERAR_REPORTE_FINANCIERO;
/

-- Ejecución de ejemplo del procedimiento
BEGIN
    GENERAR_REPORTE_FINANCIERO(11, 2024); -- Generar reporte de noviembre de 2024
END;
/

-- Consultar los reportes generados
SELECT * FROM reportes_financieros;

-- **Función: Calcular Total de Ventas por Producto**
-- Esta función devuelve el total de ventas para un producto específico.
CREATE OR REPLACE FUNCTION calcular_total_ventas_por_producto (
    p_id_producto IN NUMBER  -- ID del producto para el cual calcular el total de ventas
) RETURN NUMBER AS
    v_total_ventas NUMBER(10, 2);  -- Variable para almacenar el total de ventas
BEGIN
    -- Calcular el total de ventas para el producto proporcionado
    SELECT SUM(f.total)
    INTO v_total_ventas
    FROM usuario_vendedor.factura f
    WHERE f.id_producto = p_id_producto;  -- Filtrar por el ID del producto

    -- Retornar el total de ventas o 0 si no existen ventas
    RETURN NVL(v_total_ventas, 0);
END calcular_total_ventas_por_producto;
/

-- Ejecución de ejemplo de la función
SELECT calcular_total_ventas_por_producto(101) FROM DUAL;
