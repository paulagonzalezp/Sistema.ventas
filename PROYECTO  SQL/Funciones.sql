-----------------------*FUNCIONES*----------------------------------- 

-----------------------*USUARIO CONTADOR*----------------------------------- 
-- **FUNCION: Calcular Total de Ventas por Producto**
-- Esta función devuelve el total de ventas para un producto específico.
CREATE OR REPLACE FUNCTION calcular_total_ventas_por_producto (
    p_id_producto IN NUMBER  
) RETURN NUMBER AS
    v_total_ventas NUMBER(10, 2);  
BEGIN
 
    SELECT SUM(f.total)
    INTO v_total_ventas
    FROM usuario_vendedor.factura f
    WHERE f.id_producto = p_id_producto; 

   
    RETURN NVL(v_total_ventas, 0);
END calcular_total_ventas_por_producto;
/