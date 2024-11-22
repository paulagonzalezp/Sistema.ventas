-----------------------*PROCEDIMIENTOS*----------------------------------- 

-----------------------*USUARIO ADMINISTRADOR*----------------------------------- 
-- **PROCEDIMIENTO: Actualizar Inventario**
--Este procedimiento permite actualizar el inventario de un producto. Si ya existe un registro para el 
--producto y proveedor, incrementa la cantidad. De lo contrario, inserta un nuevo registro.
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


-----------------------*USUARIO CONTADOR*----------------------------------- 

-- **PROCEDIMIENTO: Generar Reporte Financiero Mensual**
--Este procedimiento calcula el total de ventas para un mes y año específicos, genera un nuevo ID para el 
--reporte e inserta los datos en la tabla reportes_financieros.

CREATE OR REPLACE PROCEDURE GENERAR_REPORTE_FINANCIERO (
    p_mes IN NUMBER,            
    p_ano IN NUMBER            
) AS
    v_total_ventas NUMBER(10, 2); 
    v_id_reporte NUMBER;      
BEGIN
    
    SELECT NVL(SUM(total), 0) 
    INTO v_total_ventas
    FROM usuario_vendedor.factura
    WHERE EXTRACT(MONTH FROM fecha) = p_mes
      AND EXTRACT(YEAR FROM fecha) = p_ano;


    SELECT NVL(MAX(id_reporte), 0) + 1
    INTO v_id_reporte
    FROM reportes_financieros;

   
    INSERT INTO reportes_financieros (id_reporte, fecha_reporte, total_ventas)
    VALUES (v_id_reporte, SYSTIMESTAMP, v_total_ventas);

    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Reporte generado exitosamente con ID: ' || v_id_reporte);
EXCEPTION
    WHEN OTHERS THEN
        
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
END GENERAR_REPORTE_FINANCIERO;
/
