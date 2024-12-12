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



FUNCIÓN: Calcular el Monto Promedio de Devoluciones (Usuario: usuario_contador)
/*Esta función calcula el monto promedio de las devoluciones. 
Realiza lo siguiente:
1.Consulta la tabla devoluciones y las facturas asociadas en la tabla factura para calcular los totales devueltos.
2. Calcula el promedio dividiendo el monto total de devoluciones entre el número de devoluciones registradas.
3. Retorna el promedio como un valor numérico.*/



FUNCIÓN: Evaluar Rentabilidad por Producto (Usuario: usuario_administrador)
/*Esta función calcula la ganancia total generada por un producto específico. 
Realiza lo siguiente:
1. Recibe como parámetro el id_producto.
2. Consulta las tablas factura y productos para calcular la diferencia entre el precio de venta y los costos asociados.
3. Retorna el monto total de ganancia generado por el producto.*/



FUNCIÓN: Obtener la Sucursal con Más Ventas (Usuario: usuario_administrador)
/*Esta función determina cuál sucursal tiene el mayor número de ventas en un rango de fechas. 
Realiza lo siguiente:
1. Recibe como parámetros una fecha inicial y una fecha final.
2. Consulta la tabla factura y agrupa las ventas por id_sucursal, calculando el total por cada sucursal.
3. Retorna el id_sucursal con el mayor número de ventas en el rango especificado.*/