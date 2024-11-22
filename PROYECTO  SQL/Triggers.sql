-----------------------*TRIGGER*----------------------------------- 

-----------------------*USUARIO VENDEDOR*----------------------------------- 
-- **TRIGGER: Controlar Stock Mínimo**
-- Este trigger se activa después de que se actualiza la cantidad en stock de un producto.
-- Inserta una alerta si el inventario cae por debajo de un umbral mínimo.
CREATE OR REPLACE TRIGGER trg_controlar_stock_minimo
AFTER UPDATE OF cantidad_en_stock ON productos
FOR EACH ROW
DECLARE
    v_umbral_minimo NUMBER := 10; 
BEGIN
   
    IF :NEW.cantidad_en_stock < v_umbral_minimo THEN
       
        INSERT INTO alertas_inventario (id_producto, mensaje, fecha)
        VALUES (:NEW.id_producto, 'Stock bajo, cantidad en inventario: ' || :NEW.cantidad_en_stock, SYSDATE);
    END IF;
END;
/