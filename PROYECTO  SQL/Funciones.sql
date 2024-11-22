-----------------------*FUNCIONES*----------------------------------- 

-----------------------*USUARIO CONTADOR*----------------------------------- 
-- **FUNCION 1: Calcular Total de Ventas por Producto**
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

-- **Funcion: 3.Obtener Inventario Disponible **
-- Esta función calcula el inventario total disponible para un producto específico. 
-- Recibe como parámetro el identificador del producto (p_id_producto) y retorna la 
-- suma de las cantidades registradas en la tabla `inventario` para ese producto.
-- Si no existen registros para el producto, retorna 0.

CREATE OR REPLACE FUNCTION FN_ObtenerInventarioDisponible (
    p_id_producto IN NUMBER
) RETURN NUMBER AS
    v_inventario_disponible NUMBER; 
BEGIN

    v_inventario_disponible := 0;

  
    SELECT NVL(SUM(cantidad), 0)
    INTO v_inventario_disponible
    FROM inventario
    WHERE id_producto = p_id_producto;

   
    RETURN v_inventario_disponible;
END FN_ObtenerInventarioDisponible;
/