-----------------------*TRIGGER*----------------------------------- 

TRIGGER: Actualizar Fecha de Última Modificación en Productos (Usuario: usuario_administrador)
/*Este trigger actualiza un campo ultima_modificacion en la tabla productos cada vez que se realiza un cambio en los datos del producto. 
Realiza lo siguiente:
1. Se activa en una operación de UPDATE sobre la tabla productos.
2. Actualiza el campo ultima_modificacion con la fecha y hora actual.*/



TRIGGER: Auditoría de Empleados (Usuario: usuario_administrador)
/*Este trigger registra los cambios realizados en la tabla empleados en una tabla de auditoría.
Realiza lo siguiente:
1. Se activa en operaciones de UPDATE o DELETE sobre la tabla empleados.
2. Inserta un registro en una tabla de auditoría con los detalles del cambio, incluyendo el tipo de operación, usuario que realizó el cambio, y fecha.*/



TRIGGER: Actualizar Inventario Después de una Devolución (Usuario: usuario_vendedor)
/*Este trigger incrementa la cantidad en stock de un producto cuando se registra una devolución.
Realiza lo siguiente:
1. Se activa en operaciones de INSERT sobre la tabla devoluciones.
2. Incrementa la cantidad en stock correspondiente en la tabla productos.*/


TRIGGER: Evitar Ventas sin Suficiente Inventario (Usuario: usuario_vendedor)
/*Este trigger valida que haya suficiente inventario antes de permitir la inserción de un registro en la tabla factura.
Realiza lo siguiente:
1. Se activa en operaciones de INSERT sobre la tabla factura.
2. Verifica la cantidad en stock del producto en la tabla productos.
3. Cancela la operación si no hay suficiente inventario, devolviendo un mensaje de error.*/




TRIGGER: Registrar Historial de Cambios en Precios (Usuario: usuario_administrador)
/*Este trigger guarda un registro en una tabla de historial cada vez que se modifica el precio de un producto. 
Realiza lo siguiente:
1. Se activa en operaciones de UPDATE sobre la columna precio de la tabla productos.
2. Inserta un registro en la tabla de historial con los detalles del cambio (producto afectado, precio anterior, precio nuevo, y fecha).*/




TRIGGER: Notificar Cambios en Datos de Clientes (Usuario: usuario_contador)
/*Este trigger genera un mensaje de registro o notificación cuando se actualiza o elimina un cliente. 
Realiza lo siguiente:
1. Se activa en operaciones de UPDATE o DELETE sobre la tabla clientes.
2. Registra los detalles del cambio en una tabla de auditoría o genera una notificación para los administradores.*/
