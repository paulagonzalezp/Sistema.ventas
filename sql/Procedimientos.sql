-----------------------*PROCEDIMIENTOS*----------------------------------- 

PROCEDIMIENTO: Registrar Nueva Sucursal (Usuario: usuario_administrador) (Paula)
/*Este procedimiento registra una nueva sucursal en la tabla sucursales. 
Realiza lo siguiente:
1. Verifica que la provincia y el teléfono cumplan con los formatos requeridos.
2. Inserta los datos proporcionados (provincia, dirección, y teléfono) en la tabla sucursales.
3. Devuelve un mensaje de confirmación si la inserción fue exitosa o un mensaje de 
error en caso contrario.*/

-- Asegurarse de estar en la sesión del usuario_administrador
ALTER SESSION SET CURRENT_SCHEMA = usuario_administrador;

-- Crear el procedimiento para registrar una nueva sucursal
CREATE OR REPLACE PROCEDURE registrar_nueva_sucursal (
    p_provincia IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_telefono IN VARCHAR2
) AS
    -- Variable para validar el formato del teléfono
    v_formato_telefono BOOLEAN;
BEGIN
    -- Validar que el teléfono tenga un formato válido (solo dígitos y longitud adecuada)
    v_formato_telefono := REGEXP_LIKE(p_telefono, '^\d{8,15}$');
    IF NOT v_formato_telefono THEN
        RAISE_APPLICATION_ERROR(-20001, 'El teléfono debe contener entre 8 y 15 dígitos.');
    END IF;

    -- Insertar los datos en la tabla sucursales
    INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono)
    VALUES (
        SEQ_SUCURSALES.NEXTVAL, -- Asumiendo que existe una secuencia para ID
        p_provincia,
        p_direccion,
        p_telefono
    );

    -- Confirmar el registro exitoso
    DBMS_OUTPUT.PUT_LINE('Sucursal registrada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores: devolver un mensaje en caso de fallo
        RAISE_APPLICATION_ERROR(-20002, 'Error al registrar la sucursal: ' || SQLERRM);
END registrar_nueva_sucursal;
/

--Prueba de procedimiento BEGIN
    registrar_nueva_sucursal(
        p_provincia => 'Guayas',
        p_direccion => 'Av. Principal 123',
        p_telefono  => '0987654321'
    );
END;
/



PROCEDIMIENTO: Generar Reporte Financiero (Usuario: usuario_contador)
/*Este procedimiento calcula las ventas totales para una fecha específica y genera 
un reporte financiero. 
Realiza lo siguiente:
1. Consulta la tabla factura para sumar el total de las ventas realizadas en la 
fecha proporcionada.
2. Inserta un nuevo registro en la tabla reportes_financieros con la fecha 
del reporte, total de ventas 
y otros detalles relevantes.
3. Devuelve un mensaje confirmando la generación exitosa del reporte.*/




PROCEDIMIENTO: Registrar Devolución (Usuario: usuario_vendedor)(Maricruz)
/*Este procedimiento registra una devolución en la tabla devoluciones. 
Realiza lo siguiente:
1. Inserta un registro con los detalles de la devolución, como el motivo y 
la fecha, en la tabla devoluciones.
2. Incrementa la cantidad en stock del producto devuelto en la tabla productos, si aplica.
3. Devuelve un mensaje confirmando la devolución o indicando errores en el proceso.*/

--Dar este permiso desde system
GRANT CREATE SEQUENCE TO usuario_vendedor;

-- Asegurarse de estar en la sesión del usuario_vendedor
ALTER SESSION SET CURRENT_SCHEMA = usuario_vendedor;

--crear esta secuencia primero para poder utilizar bien el PA
CREATE SEQUENCE devoluciones_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

--PA: 
CREATE OR REPLACE PROCEDURE RegistrarDevolucion (
    p_id_factura IN NUMBER,
    p_motivo IN VARCHAR2
)
IS
    v_id_producto NUMBER;
    v_cantidad NUMBER;
    v_total_devolucion NUMBER;
    v_stock_actual NUMBER;
BEGIN
    SELECT f.id_producto, f.cantidad, f.total
    INTO v_id_producto, v_cantidad, v_total_devolucion
    FROM factura f
    WHERE f.id_factura = p_id_factura;
    
    INSERT INTO devoluciones (
        id_devolucion,
        motivo,
        fecha_devolucion,
        id_factura
    )
    VALUES (
        devoluciones_seq.NEXTVAL, 
        p_motivo,
        SYSTIMESTAMP,
        p_id_factura
    );
    
    SELECT p.cantidad_en_stock
    INTO v_stock_actual
    FROM usuario_administrador.productos p
    WHERE p.id_producto = v_id_producto;
    
    UPDATE usuario_administrador.productos
    SET cantidad_en_stock = v_stock_actual + v_cantidad
    WHERE id_producto = v_id_producto;
    
    DBMS_OUTPUT.PUT_LINE('Devolución registrada correctamente para la factura ' || p_id_factura || '. Producto: ' || v_id_producto || '. Cantidad devuelta: ' || v_cantidad);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró la factura con ID ' || p_id_factura);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar la devolución: ' || SQLERRM);
END RegistrarDevolucion;

--inserts en la tabla factura para poder visualizar el PA
INSERT INTO factura (id_factura, detalle, cantidad, total, fecha, id_producto, id_cliente, id_metodo_pago, id_sucursal)
VALUES (1, 'Factura de prueba', 2, 100.00, CURRENT_TIMESTAMP, 1, 1, 1, 1);

INSERT INTO factura (id_factura, detalle, cantidad, total, fecha, id_producto, id_cliente, id_metodo_pago, id_sucursal)
VALUES (2, 'Factura de prueba 2', 3, 150.00, CURRENT_TIMESTAMP, 2, 2, 2, 2);

INSERT INTO factura (id_factura, detalle, cantidad, total, fecha, id_producto, id_cliente, id_metodo_pago, id_sucursal)
VALUES (3, 'Factura de prueba 3', 1, 50.00, CURRENT_TIMESTAMP, 3, 3, 3, 3);


--ejecutar el PA
BEGIN
    REGISTRARDEVOLUCION(
        p_motivo => 'Producto defectuoso', 
        p_id_factura => 1
    );
END;
/

--Select en devoluciones
select * from devoluciones
--se deberia de ver el nuevo dato de "producto defectuoso"


PROCEDIMIENTO: Asignar Empleados a una Sucursal (Usuario: usuario_administrador)(Maricruz)
/*Este procedimiento asigna un empleado a una sucursal específica. 
Realiza lo siguiente:
1. Recibe el id_empleado y el id_sucursal como parámetros.
2. Actualiza la tabla empleados para asociar el empleado a la sucursal indicada.
3. Devuelve un mensaje de confirmación o un error si la asignación no es válida (por ejemplo, si la sucursal no existe).*/



PROCEDIMIENTO: Actualizar Precios de Productos por Categoría (Usuario: usuario_administrador) (Paula)
/*Este procedimiento ajusta los precios de los productos pertenecientes a una categoría específica. Realiza lo siguiente:
1. Recibe como parámetros el id_categoria y un porcentaje de ajuste.
2. Actualiza el precio de todos los productos en esa categoría según el porcentaje indicado.
3.Devuelve un mensaje confirmando los cambios realizados o indicando errores (por ejemplo, si la categoría no existe).*/

-- Asegurarse de estar en la sesión del usuario_administrador
ALTER SESSION SET CURRENT_SCHEMA = usuario_administrador;

-- Crear el procedimiento para registrar una nueva sucursal
CREATE OR REPLACE PROCEDURE registrar_nueva_sucursal (
    p_provincia IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_telefono IN VARCHAR2
) AS
    -- Variable para validar el formato del teléfono
    v_formato_telefono BOOLEAN;
BEGIN
    -- Validar que el teléfono tenga un formato válido (solo dígitos y longitud adecuada)
    v_formato_telefono := REGEXP_LIKE(p_telefono, '^\d{8,15}$');
    IF NOT v_formato_telefono THEN
        RAISE_APPLICATION_ERROR(-20001, 'El teléfono debe contener entre 8 y 15 dígitos.');
    END IF;

    -- Insertar los datos en la tabla sucursales
    INSERT INTO sucursales (id_sucursal, provincia, direccion, telefono)
    VALUES (
        SEQ_SUCURSALES.NEXTVAL, -- Asumiendo que existe una secuencia para ID
        p_provincia,
        p_direccion,
        p_telefono
    );

    -- Confirmar el registro exitoso
    DBMS_OUTPUT.PUT_LINE('Sucursal registrada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores: devolver un mensaje en caso de fallo
        RAISE_APPLICATION_ERROR(-20002, 'Error al registrar la sucursal: ' || SQLERRM);
END registrar_nueva_sucursal;
/


BEGIN
    registrar_nueva_sucursal(
        p_provincia => 'Alajuela',
        p_direccion => 'San Antonio',
        p_telefono  => '12345'
    );
END;
/
