-----------------------*PROCEDIMIENTOS*----------------------------------- 


PROCEDIMIENTO: Actualizar Inventario después de una Venta (Usuario: usuario_vendedor)
/*Este procedimiento actualiza el inventario cuando se realiza una venta. 
Realiza lo siguiente:
1. Verifica si el producto tiene suficiente cantidad en stock para cubrir la venta.
2. Si hay suficiente inventario, reduce la cantidad en stock del producto 
registrado en la tabla productos.
3. Si no hay suficiente inventario, muestra un mensaje de error indicando 
que no es posible procesar la venta debido a falta de stock.*/





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




PROCEDIMIENTO: Registrar Devolución (Usuario: usuario_vendedor)
/*Este procedimiento registra una devolución en la tabla devoluciones. 
Realiza lo siguiente:
1. Inserta un registro con los detalles de la devolución, como el motivo y 
la fecha, en la tabla devoluciones.
2. Incrementa la cantidad en stock del producto devuelto en la tabla productos, si aplica.
3. Devuelve un mensaje confirmando la devolución o indicando errores en el proceso.*/




PROCEDIMIENTO: Asignar Empleados a una Sucursal (Usuario: usuario_administrador)
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
