-- PROCEDIMIENTOS

-----------------------*USUARIO VENDEDOR*----------------------------------- 
-- Prodecimiento de registrar Nueva Venta 
/*
Procedimiento que, al realizar una venta, inserte un nuevo registro
 en la tabla factura con el detalle de la compra y actualice la cantidad de 
 producto en stock en la tabla productos.
*/
CREATE OR REPLACE PROCEDURE registrarNuevaVenta (
    p_id_producto IN NUMBER,
    p_cantidad IN NUMBER,
    p_id_cliente IN NUMBER,
    p_id_metodo_pago IN NUMBER,
    p_id_sucursal IN NUMBER
) AS
    -- Variables locales
    v_precio_unitario productos.precio%TYPE;
    v_total NUMBER;
    v_id_factura NUMBER;
BEGIN
    -- Obtener el precio del producto
    SELECT precio
    INTO v_precio_unitario
    FROM productos
    WHERE id_producto = p_id_producto;
    
    -- Calcular el total de la venta
    v_total := v_precio_unitario * p_cantidad;

    -- Insertar el registro de la factura
    INSERT INTO factura (id_cliente, fecha, total, id_metodo_pago, id_sucursal)
    VALUES (p_id_cliente, SYSDATE, v_total, p_id_metodo_pago, p_id_sucursal)
    RETURNING id_factura INTO v_id_factura;

    -- Insertar el detalle de la factura
    INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario)
    VALUES (v_id_factura, p_id_producto, p_cantidad, v_precio_unitario);

    -- Actualizar la cantidad en stock del producto
    UPDATE productos
    SET cantidad_en_stock = cantidad_en_stock - p_cantidad
    WHERE id_producto = p_id_producto;

    -- Confirmar transacción
    COMMIT;

EXCEPTION
    -- Manejo de errores
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Producto no encontrado.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END registrarNuevaVenta;
/
