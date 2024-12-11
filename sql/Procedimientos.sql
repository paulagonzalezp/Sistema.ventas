-----------------------*PROCEDIMIENTOS*----------------------------------- 


PROCEDIMIENTO: Actualizar Inventario después de una Venta (Usuario: usuario_vendedor)
/*Este procedimiento actualiza el inventario cuando se realiza una venta. 
Realiza lo siguiente:
1. Verifica si el producto tiene suficiente cantidad en stock para cubrir la venta.
2. Si hay suficiente inventario, reduce la cantidad en stock del producto 
registrado en la tabla productos.
3. Si no hay suficiente inventario, muestra un mensaje de error indicando 
que no es posible procesar la venta debido a falta de stock.*/





PROCEDIMIENTO: Registrar Nueva Sucursal (Usuario: usuario_administrador) (Paula)
/*Este procedimiento registra una nueva sucursal en la tabla sucursales. 
Realiza lo siguiente:
1. Verifica que la provincia y el teléfono cumplan con los formatos requeridos.
2. Inserta los datos proporcionados (provincia, dirección, y teléfono) en la tabla sucursales.
3. Devuelve un mensaje de confirmación si la inserción fue exitosa o un mensaje de 
error en caso contrario.*/



PROCEDIMIENTO: Generar Reporte Financiero (Usuario: usuario_contador)
/*Este procedimiento calcula las ventas totales para una fecha específica y genera 
un reporte financiero. 
Realiza lo siguiente:
1. Consulta la tabla factura para sumar el total de las ventas realizadas en la 
fecha proporcionada.
2. Inserta un nuevo registro en la tabla reportes_financieros con la fecha 
del reporte, total de ventas 
y otros detalles relevantes.
3. Devuelve un mensaje confirmando la generación exitosa del reporte.*/




PROCEDIMIENTO: Registrar Devolución (Usuario: usuario_vendedor)
/*Este procedimiento registra una devolución en la tabla devoluciones. 
Realiza lo siguiente:
1. Inserta un registro con los detalles de la devolución, como el motivo y 
la fecha, en la tabla devoluciones.
2. Incrementa la cantidad en stock del producto devuelto en la tabla productos, si aplica.
3. Devuelve un mensaje confirmando la devolución o indicando errores en el proceso.*/




PROCEDIMIENTO: Asignar Empleados a una Sucursal (Usuario: usuario_administrador)
/*Este procedimiento asigna un empleado a una sucursal específica. 
Realiza lo siguiente:
1. Recibe el id_empleado y el id_sucursal como parámetros.
2. Actualiza la tabla empleados para asociar el empleado a la sucursal indicada.
3. Devuelve un mensaje de confirmación o un error si la asignación no es válida (por ejemplo, si la sucursal no existe).*/



PROCEDIMIENTO: Actualizar Precios de Productos por Categoría (Usuario: usuario_administrador) (Paula)
/*Este procedimiento ajusta los precios de los productos pertenecientes a una categoría específica. Realiza lo siguiente:
1. Recibe como parámetros el id_categoria y un porcentaje de ajuste.
2. Actualiza el precio de todos los productos en esa categoría según el porcentaje indicado.
3.Devuelve un mensaje confirmando los cambios realizados o indicando errores (por ejemplo, si la categoría no existe).*/