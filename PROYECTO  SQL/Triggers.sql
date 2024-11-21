-- TRIGGERS

-----------------------*USUARIO ADMINISTRADOR*----------------------------------- 
-- Prodecimiento de registrar Nueva Venta 
/*
Creacion de un trigger llamado trg_controlar_stock_minimo que se active después de una 
actualización en la columna cantidad_en_stock de la tabla productos. 
El propósito de este trigger es verificar si la cantidad de stock de un 
producto es inferior a un umbral mínimo de 10 unidades, y, en ese caso, 
insertar una alerta en una tabla llamada alertas_inventario
*/
CREATE OR REPLACE TRIGGER trg_controlar_stock_minimo
AFTER UPDATE OF cantidad_en_stock ON productos
FOR EACH ROW
DECLARE
    v_umbral_minimo NUMBER := 10;  -- Definir el umbral mínimo de stock
BEGIN
    -- Verificar si la cantidad en stock es menor que el umbral mínimo
    IF :NEW.cantidad_en_stock < v_umbral_minimo THEN
        -- Insertar un aviso en la tabla de alertas
        INSERT INTO alertas_inventario (id_producto, mensaje, fecha)
        VALUES (:NEW.id_producto, 'Stock bajo, cantidad en inventario: ' || :NEW.cantidad_en_stock, SYSDATE);
    END IF;
END;
/
