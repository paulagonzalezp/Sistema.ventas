-----------------------*FUNCIONES*----------------------------------- 


FUNCIÓN: Calcular el Total de Ventas Diarias (Usuario: usuario_contador)(Paula)
/*Esta función calcula el total de ventas realizadas en una fecha específica. 
Realiza lo siguiente:
1. Recibe como parámetro una fecha.
2. Consulta la tabla factura y suma los valores del campo total para las ventas registradas en esa fecha.
3. Retorna el total de ventas calculado.*/

-- Asegurarse de estar en la sesión del usuario_contador
ALTER SESSION SET CURRENT_SCHEMA = usuario_contador;

-- Crear la función para calcular el total de ventas diarias
CREATE OR REPLACE FUNCTION calcular_total_ventas_diarias (
    p_fecha IN DATE
) RETURN NUMBER AS
    v_total_ventas NUMBER; -- Variable para almacenar el total de ventas
BEGIN
    -- Consultar la suma de las ventas en la tabla factura para la fecha proporcionada
    SELECT NVL(SUM(total), 0)
    INTO v_total_ventas
    FROM usuario_vendedor.factura
    WHERE TRUNC(fecha) = TRUNC(p_fecha);

    -- Retornar el total de ventas
    RETURN v_total_ventas;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Si no hay datos, retornar 0
        RETURN 0;
    WHEN OTHERS THEN
        -- Manejo de errores: lanzar un mensaje descriptivo
        RAISE_APPLICATION_ERROR(-20001, 'Error al calcular el total de ventas: ' || SQLERRM);
END calcular_total_ventas_diarias;
/



-- Llamar a la función desde una consulta SQL
SELECT calcular_total_ventas_diarias(TO_DATE('2024-12-10', 'YYYY-MM-DD')) AS total_ventas
FROM dual;

-- Llamar a la función desde PL/SQL
DECLARE
    v_resultado NUMBER;
BEGIN
    v_resultado := calcular_total_ventas_diarias(TO_DATE('2024-12-10', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('El total de ventas del día es: ' || v_resultado);
END;
/



FUNCIÓN: Verificar Disponibilidad de Inventario (Usuario: usuario_vendedor)(Paula)
/*Esta función verifica si hay suficiente inventario para realizar una venta. 
Realiza lo siguiente:
1.Recibe como parámetros el id_producto y la cantidad requerida.
2. Consulta la tabla productos para obtener la cantidad en stock del producto.
3. Retorna un valor booleano (TRUE si hay suficiente stock, FALSE si no lo hay).*/

-- Asegurarse de estar en la sesión del usuario_vendedor
ALTER SESSION SET CURRENT_SCHEMA = usuario_vendedor;

-- Crear la función para verificar la disponibilidad de inventario
CREATE OR REPLACE FUNCTION verificar_disponibilidad_inventario (
    p_id_producto IN NUMBER,
    p_cantidad_requerida IN NUMBER
) RETURN BOOLEAN AS
    v_cantidad_en_stock NUMBER; -- Variable para almacenar la cantidad disponible en stock
BEGIN
    -- Consultar la cantidad en stock del producto
    SELECT cantidad_en_stock
    INTO v_cantidad_en_stock
    FROM usuario_administrador.productos
    WHERE id_producto = p_id_producto;

    -- Verificar si la cantidad disponible es suficiente
    IF v_cantidad_en_stock >= p_cantidad_requerida THEN
        RETURN TRUE; -- Hay suficiente inventario
    ELSE
        RETURN FALSE; -- No hay suficiente inventario
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Si el producto no existe, retornar FALSE
        RETURN FALSE;
    WHEN OTHERS THEN
        -- Manejo de errores: lanzar un mensaje descriptivo
        RAISE_APPLICATION_ERROR(-20001, 'Error al verificar inventario: ' || SQLERRM);
END verificar_disponibilidad_inventario;
/


-- Llamar a la función desde una consulta SQL
SELECT verificar_disponibilidad_inventario(101, 5) AS disponible
FROM dual;

-- Llamar a la función desde PL/SQL
DECLARE
    v_resultado BOOLEAN;
BEGIN
    v_resultado := verificar_disponibilidad_inventario(101, 5);
    IF v_resultado THEN
        DBMS_OUTPUT.PUT_LINE('Hay suficiente inventario para el producto.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No hay suficiente inventario para el producto.');
    END IF;
END;
/


FUNCIÓN: Obtener Detalles de Facturación por Cliente (Usuario: usuario_contador)
/*Esta función obtiene los detalles de todas las facturas asociadas a un cliente específico. 
Realiza lo siguiente:
1. Recibe como parámetro el id_cliente.
2. Consulta la tabla factura para obtener los detalles de las facturas relacionadas con ese cliente.
3. Retorna una lista de registros con los detalles de facturación.*/



FUNCIÓN: actualizar_stock_producto (Usuario: usuario_administrador)
/* La función actualizar_stock_producto permite actualizar 
la cantidad en inventario de un producto específico en la tabla inventario.
 Recibe como parámetros el identificador del producto (p_id_producto) 
y la nueva cantidad (p_nueva_cantidad). 
Verifica si el producto existe antes de actualizar el stock, devolviendo un mensaje de confirmación 
en caso de éxito o un mensaje de error si el producto no se encuentra o ocurre algún problema durante 
el proceso.*/
CREATE OR REPLACE FUNCTION actualizar_stock_producto(
    p_id_producto NUMBER,
    p_nueva_cantidad NUMBER
) RETURN VARCHAR2 IS
    v_stock_actual NUMBER;
BEGIN
    -- Validar que el producto exista
    SELECT cantidad
    INTO v_stock_actual
    FROM usuario_administrador.inventario
    WHERE id_producto = p_id_producto;

    -- Actualizar el stock del producto
    UPDATE usuario_administrador.inventario
    SET cantidad = p_nueva_cantidad
    WHERE id_producto = p_id_producto;

    RETURN 'Stock actualizado correctamente';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Error: Producto no encontrado';
    WHEN OTHERS THEN
        RETURN 'Error: No se pudo actualizar el stock';
END actualizar_stock_producto;
/

SELECT actualizar_stock_producto(101, 50) FROM dual;



FUNCIÓN: Evaluar Rentabilidad por Producto (Usuario: usuario_administrador)
/*Esta función calcula la ganancia total generada por un producto específico. 
Realiza lo siguiente:
1. Recibe como parámetro el id_producto.
2. Consulta las tablas factura y productos para calcular la diferencia entre el precio de venta y los costos asociados.
3. Retorna el monto total de ganancia generado por el producto.*/
--SE LE ASIGNO ESTE PERMISO ADICIONAL AL ADMIN_ROLE
--DESDE USUARIO_VENDEDOR
GRANT SELECT ON usuario_vendedor.factura TO ADMIN_ROL;
--DESDE USUARIO_ADMINISTRADOR SE CREA LA FUNCION 
CREATE OR REPLACE FUNCTION evaluar_rentabilidad_producto(id_producto_param NUMBER)
RETURN NUMBER
IS
    ganancia_total NUMBER := 0;
BEGIN
    -- Calcular la ganancia total para el producto especificado
    SELECT SUM((p.precio - p.monto) * f.cantidad)
    INTO ganancia_total
    FROM productos p
    JOIN usuario_vendedor.factura f
    ON p.id_producto = f.id_producto
    WHERE p.id_producto = id_producto_param;

    RETURN ganancia_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Si no hay registros, retornar 0
        RETURN 0;
    WHEN OTHERS THEN
        -- Manejo de otros errores
        RAISE;
END;
/


--ASEGURAMOS DE QUE ADMIN_ROLE tenga el permiso EXECUTE sobre la función
GRANT EXECUTE ON evaluar_rentabilidad_producto TO ADMIN_ROL;
--PRUEBA
SELECT usuario_administrador.evaluar_rentabilidad_producto(101) AS ganancia_total
FROM dual;



FUNCIÓN: Obtener la Sucursal con Más Ventas (Usuario: usuario_administrador)
/*Esta función determina cuál sucursal tiene el mayor número de ventas en un rango de fechas. 
Realiza lo siguiente:
1. Recibe como parámetros una fecha inicial y una fecha final.
2. Consulta la tabla factura y agrupa las ventas por id_sucursal, calculando el total por cada sucursal.
3. Retorna el id_sucursal con el mayor número de ventas en el rango especificado.*/