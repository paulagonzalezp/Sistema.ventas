-- FUNCIONES

-----------------------*USUARIO ADMINISTRADRO*----------------------------------- 
-- Funcion de ventas
/*
Se solicita desarrollar una función en que permita consultar la cantidad
actual en inventario para un producto específico. Esta función deberá 
recibir el ID de un producto como parámetro y devolver la cantidad 
disponible en stock. Su objetivo es facilitar la verificación de la 
disponibilidad del producto antes de registrar una nueva venta, optimizando
así la gestión del inventario.
*/
CREATE OR REPLACE FUNCTION consultar_cantidad_en_inventario(p_id_producto NUMBER)
RETURN NUMBER IS
    v_cantidad NUMBER;
BEGIN
    SELECT cantidad_en_stock
    INTO v_cantidad
    FROM productos
    WHERE id_producto = p_id_producto;

    RETURN v_cantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Si no se encuentra el producto, retorna 0
    WHEN OTHERS THEN
        RAISE; -- Lanza la excepción para manejo externo
END consultar_cantidad_en_inventario;
/
