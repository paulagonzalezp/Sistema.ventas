CREATE OR REPLACE PROCEDURE ActualizarInventario (
    vIdPeticion IN NUMBER,
    vIdProducto IN NUMBER,
    vCantidadPorComprar IN NUMBER
) AS 

    -- Cursor que trae todos los registros de productos en el inventario
    CURSOR cProductos(vIdProducto NUMBER) IS 
        SELECT id_producto, cantidad_en_stock
        FROM usuario_administrador.productos
        WHERE id_producto = vIdProducto
          AND cantidad_en_stock > 0  -- Solo productos con stock disponible
        ORDER BY id_producto;

    -- Registro para recorrer el cursor con los inventarios
    rCProductos cProductos%ROWTYPE;

    -- Controla la cantidad pendiente por entregar
    vCantidadPendiente NUMBER := vCantidadPorComprar;

    -- Controla la cantidad entregada
    vCantidadEntregada NUMBER := 0;

BEGIN
    -- Abrir el cursor con el inventario del producto solicitado
    OPEN cProductos(vIdProducto);

    LOOP
        -- Extrae un registro del cursor
        FETCH cProductos INTO rCProductos;

        -- Abandona el recorrido si el cursor está vacío
        EXIT WHEN cProductos%NOTFOUND;

        -- Si en una bodega el inventario alcanza para lo pendiente
        IF rCProductos.cantidad_en_stock >= vCantidadPendiente THEN
            
            -- Actualiza el inventario del producto en esa bodega
            UPDATE usuario_administrador.productos
            SET cantidad_en_stock = cantidad_en_stock - vCantidadPendiente
            WHERE id_producto = vIdProducto;

            -- Actualizan las variables de control
            vCantidadEntregada := vCantidadEntregada + vCantidadPendiente;
            vCantidadPendiente := 0;

        ELSE
            -- Actualiza el inventario del producto en esa bodega
            UPDATE usuario_administrador.productos
            SET cantidad_en_stock = 0
            WHERE id_producto = vIdProducto;

            -- Actualizan las variables de control
            vCantidadEntregada := vCantidadEntregada + rCProductos.cantidad_en_stock;
            vCantidadPendiente := vCantidadPendiente - rCProductos.cantidad_en_stock;
        
        END IF;

        -- Salir si ya se alcanzó la cantidad solicitada
        IF vCantidadEntregada = vCantidadPorComprar THEN
            EXIT;
        END IF;

    END LOOP;

    CLOSE cProductos;

    -- Registrar la cantidad faltante en la tabla Rechazos
    IF vCantidadEntregada < vCantidadPorComprar THEN
        INSERT INTO usuario_vendedor.Rechazos (idPeticion, idProducto, cantidadSolicitada, cantidadRechazada)
        VALUES (vIdPeticion, vIdProducto, vCantidadPorComprar, vCantidadPendiente);
    END IF;

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el producto con ID: ' || vIdProducto);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al procesar la compra: ' || SQLERRM);
        ROLLBACK;
END;
/

BEGIN
    ActualizarInventario(1, 1, 21);  -- Ejemplo de uso con ID de petición 1, producto 1001, y cantidad 20
END;
/


-- Verificar los productos
SELECT * FROM usuario_administrador.productos;

-- Verificar las compras
SELECT * FROM usuario_vendedor.Compras;

-- Verificar los rechazos
SELECT * FROM usuario_vendedor.Rechazos;
