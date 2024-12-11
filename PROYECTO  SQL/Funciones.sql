-----------------------*FUNCIONES*----------------------------------- 


FUNCIÓN: Calcular el Total de Ventas Diarias (Usuario: usuario_contador)
/*Esta función calcula el total de ventas realizadas en una fecha específica. 
Realiza lo siguiente:
1. Recibe como parámetro una fecha.
2. Consulta la tabla factura y suma los valores del campo total para las ventas registradas en esa fecha.
3. Retorna el total de ventas calculado.*/



FUNCIÓN: Verificar Disponibilidad de Inventario (Usuario: usuario_vendedor)
/*Esta función verifica si hay suficiente inventario para realizar una venta. 
Realiza lo siguiente:
1.Recibe como parámetros el id_producto y la cantidad requerida.
2. Consulta la tabla productos para obtener la cantidad en stock del producto.
3. Retorna un valor booleano (TRUE si hay suficiente stock, FALSE si no lo hay).*/



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