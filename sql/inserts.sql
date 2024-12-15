--usuario_administrador
INSERT INTO proveedores VALUES (1, 'Tech Supplies', 'tech@supplies.com', '123456789');
INSERT INTO proveedores VALUES (2, 'Office Essentials', 'contact@office.com', '987654321');
INSERT INTO proveedores VALUES (3, 'Gadget World', 'info@gadgetworld.com', '456123789');
INSERT INTO proveedores VALUES (4, 'Eco Paper Co.', 'sales@ecopaper.com', '321654987');
INSERT INTO proveedores VALUES (5, 'Digital Gear', 'support@digitalgear.com', '654789321');
INSERT INTO proveedores VALUES (6, 'Tech Trends', 'admin@techtrends.com', '789456123');
INSERT INTO proveedores VALUES (7, 'Paper Plus', 'info@paperplus.com', '123789456');
INSERT INTO proveedores VALUES (8, 'Gear Up', 'help@gearup.com', '987123654');
INSERT INTO proveedores VALUES (9, 'Supreme Office', 'service@supremeoffice.com', '321987654');
INSERT INTO proveedores VALUES (10, 'Fast Tech', 'orders@fasttech.com', '654321987');

INSERT INTO categorias VALUES (1, 'Ropa de Hombre', 'Prendas de vestir para hombres');
INSERT INTO categorias VALUES (2, 'Ropa de Mujer', 'Prendas de vestir para mujeres');
INSERT INTO categorias VALUES (3, 'Accesorios', 'Bolsos, carteras, cinturones y otros complementos');
INSERT INTO categorias VALUES (4, 'Calzado', 'Zapatos, botas, sandalias y deportivos');
INSERT INTO categorias VALUES (5, 'Ropa Infantil', 'Ropa para niños y niñas');
INSERT INTO categorias VALUES (6, 'Lencería', 'Ropa íntima y pijamas');
INSERT INTO categorias VALUES (7, 'Deportiva', 'Ropa deportiva para ejercicio y actividades al aire libre');
INSERT INTO categorias VALUES (8, 'Bolsos y Carteras', 'Bolsos, mochilas y carteras de diferentes estilos');
INSERT INTO categorias VALUES (9, 'Vestidos', 'Vestidos de diferentes estilos y ocasiones');
INSERT INTO categorias VALUES (10, 'Trajes de Baño', 'Trajes de baño para hombres, mujeres y niños');

INSERT INTO productos VALUES (1, 'Camisa Polo', 'Camisa de algodón con cuello tipo polo', 25.00, 50, DEFAULT, 1250, 1);
INSERT INTO productos VALUES (2, 'Jeans Slim Fit', 'Jeans de corte ajustado, cómodo y moderno', 40.00, 40, DEFAULT, 1600, 2);
INSERT INTO productos VALUES (3, 'Chaqueta de Cuero', 'Chaqueta de cuero genuino para clima frío', 120.00, 20, DEFAULT, 2400, 3);
INSERT INTO productos VALUES (4, 'Zapatos de Cuero', 'Zapatos formales de cuero para ocasiones especiales', 80.00, 30, DEFAULT, 2400, 4);
INSERT INTO productos VALUES (5, 'Billetera de Piel', 'Billetera de piel genuina, tamaño compacto', 25.00, 100, DEFAULT, 2500, 5);
INSERT INTO productos VALUES (6, 'Gorra Deportiva', 'Gorra con ajuste trasero, ideal para deportes', 15.00, 50, DEFAULT, 750, 6);
INSERT INTO productos VALUES (7, 'Bufanda de Lana', 'Bufanda cálida y suave para invierno', 20.00, 60, DEFAULT, 1200, 7);
INSERT INTO productos VALUES (8, 'T-shirt Básica', 'Camiseta de algodón básica de varios colores', 10.00, 200, DEFAULT, 2000, 8);
INSERT INTO productos VALUES (9, 'Pantalones Cortos', 'Pantalones cortos ideales para verano', 18.00, 80, DEFAULT, 1440, 9);
INSERT INTO productos VALUES (10, 'Reloj de Pulsera', 'Reloj clásico con correa de metal', 50.00, 25, DEFAULT, 1250, 10);

INSERT INTO inventario VALUES (1, 1, 50, SYSTIMESTAMP, 1, 1);
INSERT INTO inventario VALUES (2, 2, 30, SYSTIMESTAMP, 2, 2);
INSERT INTO inventario VALUES (3, 3, 20, SYSTIMESTAMP, 3, 3);
INSERT INTO inventario VALUES (4, 4, 15, SYSTIMESTAMP, 4, 4);
INSERT INTO inventario VALUES (5, 5, 40, SYSTIMESTAMP, 5, 5);
INSERT INTO inventario VALUES (6, 6, 10, SYSTIMESTAMP, 6, 6);
INSERT INTO inventario VALUES (7, 7, 25, SYSTIMESTAMP, 7, 7);
INSERT INTO inventario VALUES (8, 8, 18, SYSTIMESTAMP, 8, 8);
INSERT INTO inventario VALUES (9, 9, 12, SYSTIMESTAMP, 9, 9);
INSERT INTO inventario VALUES (10, 10, 5, SYSTIMESTAMP, 10, 10);

--usuario_contador
INSERT INTO clientes VALUES (1, 'Carlos Rivera', '88884444', 'San José, Costa Rica', 'carlos@mail.com', DEFAULT);
INSERT INTO clientes VALUES (2, 'María Pérez', '88776655', 'Alajuela, Costa Rica', 'maria@mail.com', DEFAULT);
INSERT INTO clientes VALUES (3, 'Juan García', '88992233', 'Heredia, Costa Rica', 'juan@mail.com', DEFAULT);
INSERT INTO clientes VALUES (4, 'Ana Rodríguez', '88447788', 'Cartago, Costa Rica', 'ana@mail.com', DEFAULT);
INSERT INTO clientes VALUES (5, 'Pedro Jiménez', '88336622', 'Puntarenas, Costa Rica', 'pedro@mail.com', DEFAULT);
INSERT INTO clientes VALUES (6, 'Lucía Vargas', '88224411', 'Guanacaste, Costa Rica', 'lucia@mail.com', DEFAULT);
INSERT INTO clientes VALUES (7, 'Diego Hernández', '88775544', 'Limón, Costa Rica', 'diego@mail.com', DEFAULT);
INSERT INTO clientes VALUES (8, 'Rosa Salazar', '88997755', 'San José, Costa Rica', 'rosa@mail.com', DEFAULT);
INSERT INTO clientes VALUES (9, 'Mario Fernández', '88889966', 'Cartago, Costa Rica', 'mario@mail.com', DEFAULT);
INSERT INTO clientes VALUES (10, 'Sara López', '88229933', 'Heredia, Costa Rica', 'sara@mail.com', DEFAULT);

INSERT INTO contador VALUES (1, 15, DEFAULT, 1, NULL, 1);
INSERT INTO contador VALUES (2, 8, DEFAULT, 2, NULL, 2);
INSERT INTO contador VALUES (3, 20, DEFAULT, 3, NULL, 3);
INSERT INTO contador VALUES (4, 12, DEFAULT, 4, NULL, 4);
INSERT INTO contador VALUES (5, 5, DEFAULT, 5, NULL, 5);
INSERT INTO contador VALUES (6, 25, DEFAULT, 6, NULL, 6);
INSERT INTO contador VALUES (7, 10, DEFAULT, 7, NULL, 7);
INSERT INTO contador VALUES (8, 18, DEFAULT, 8, NULL, 8);
INSERT INTO contador VALUES (9, 22, DEFAULT, 9, NULL, 9);
INSERT INTO contador VALUES (10, 30, DEFAULT, 10, NULL, 10);

INSERT INTO reportes_financieros VALUES (1, 101, DEFAULT, 1500.50, NULL);
INSERT INTO reportes_financieros VALUES (2, 102, DEFAULT, 2500.75, NULL);
INSERT INTO reportes_financieros VALUES (3, 103, DEFAULT, 1800.25, NULL);
INSERT INTO reportes_financieros VALUES (4, 104, DEFAULT, 3200.00, NULL);
INSERT INTO reportes_financieros VALUES (5, 105, DEFAULT, 2750.90, NULL);
INSERT INTO reportes_financieros VALUES (6, 106, DEFAULT, 3050.60, NULL);
INSERT INTO reportes_financieros VALUES (7, 107, DEFAULT, 1900.80, NULL);
INSERT INTO reportes_financieros VALUES (8, 108, DEFAULT, 2200.40, NULL);
INSERT INTO reportes_financieros VALUES (9, 109, DEFAULT, 3400.70, NULL);
INSERT INTO reportes_financieros VALUES (10, 110, DEFAULT, 2900.55, NULL);

--usuario_vendedor
INSERT INTO metodos_pago VALUES (1, 'Tarjeta de Crédito', 'Pago con tarjetas Visa, Mastercard, etc.');
INSERT INTO metodos_pago VALUES (2, 'Transferencia Bancaria', 'Pago mediante transferencia desde bancos locales.');
INSERT INTO metodos_pago VALUES (3, 'Efectivo', 'Pago directo en la sucursal.');
INSERT INTO metodos_pago VALUES (4, 'PayPal', 'Pago digital mediante PayPal.');
INSERT INTO metodos_pago VALUES (5, 'Cheque', 'Pago mediante cheques bancarios.');
INSERT INTO metodos_pago VALUES (6, 'Crédito en Línea', 'Financiamiento de compras online.');
INSERT INTO metodos_pago VALUES (7, 'Puntos de Fidelidad', 'Canje de puntos acumulados por productos o servicios.');
INSERT INTO metodos_pago VALUES (8, 'Apple Pay', 'Pago digital con dispositivos Apple.');
INSERT INTO metodos_pago VALUES (9, 'Google Pay', 'Pago digital mediante Google Wallet.');
INSERT INTO metodos_pago VALUES (10, 'Criptomonedas', 'Pago con monedas digitales como Bitcoin.');

INSERT INTO sucursales VALUES (1, 'San José', 'Avenida Central, San José', '22223333');
INSERT INTO sucursales VALUES (2, 'Alajuela', 'Boulevard Los Ángeles, Alajuela', '24334455');
INSERT INTO sucursales VALUES (3, 'Heredia', 'Calle Principal, Heredia Centro', '22667788');
INSERT INTO sucursales VALUES (4, 'Cartago', 'Plaza del Sol, Cartago', '25556677');
INSERT INTO sucursales VALUES (5, 'Puntarenas', 'Frente al Parque Marino, Puntarenas', '26664433');
INSERT INTO sucursales VALUES (6, 'Limón', 'Avenida 3, Limón Centro', '27558899');
INSERT INTO sucursales VALUES (7, 'Guanacaste', 'Calle Real, Liberia', '26665544');
INSERT INTO sucursales VALUES (8, 'Escazú', 'Multiplaza Escazú', '22882233');
INSERT INTO sucursales VALUES (9, 'Curridabat', 'Plaza Momentum, Curridabat', '22779966');
INSERT INTO sucursales VALUES (10, 'San Pedro', 'Frente a la UCR, San Pedro', '22224455');

INSERT INTO empleados VALUES (1, 'María Fernández', 'maria.fernandez@empresa.com', '88885555', 'Barrio Escalante, San José', DEFAULT, 1);
INSERT INTO empleados VALUES (2, 'Juan Pérez', 'juan.perez@empresa.com', '88332211', 'Centro, Alajuela', DEFAULT, 2);
INSERT INTO empleados VALUES (3, 'Ana Rodríguez', 'ana.rodriguez@empresa.com', '88229988', 'San Rafael, Heredia', DEFAULT, 3);
INSERT INTO empleados VALUES (4, 'Carlos Jiménez', 'carlos.jimenez@empresa.com', '88112233', 'Tres Ríos, Cartago', DEFAULT, 4);
INSERT INTO empleados VALUES (5, 'Luis Sánchez', 'luis.sanchez@empresa.com', '88001122', 'Barrio El Carmen, Puntarenas', DEFAULT, 5);
INSERT INTO empleados VALUES (6, 'Lucía Vargas', 'lucia.vargas@empresa.com', '88994411', 'Limón Centro', DEFAULT, 6);
INSERT INTO empleados VALUES (7, 'Diego Hernández', 'diego.hernandez@empresa.com', '88775544', 'Santa Ana, Guanacaste', DEFAULT, 7);
INSERT INTO empleados VALUES (8, 'Rosa Salazar', 'rosa.salazar@empresa.com', '88662233', 'Guachipelín, Escazú', DEFAULT, 8);
INSERT INTO empleados VALUES (9, 'Mario Fernández', 'mario.fernandez@empresa.com', '88443322', 'Curridabat Centro', DEFAULT, 9);
INSERT INTO empleados VALUES (10, 'Sara López', 'sara.lopez@empresa.com', '88227766', 'Barrio Dent, San Pedro', DEFAULT, 10);

INSERT INTO devoluciones VALUES (1, 'Producto defectuoso', DEFAULT, 1);
INSERT INTO devoluciones VALUES (2, 'Error en el pedido', DEFAULT, 2);
INSERT INTO devoluciones VALUES (3, 'Producto dañado en el envío', DEFAULT, 3);
INSERT INTO devoluciones VALUES (4, 'Cambio de modelo', DEFAULT, 4);
INSERT INTO devoluciones VALUES (5, 'Garantía válida', DEFAULT, 5);
INSERT INTO devoluciones VALUES (6, 'Producto incorrecto', DEFAULT, 6);
INSERT INTO devoluciones VALUES (7, 'Falla técnica', DEFAULT, 7);
INSERT INTO devoluciones VALUES (8, 'Accesorio faltante', DEFAULT, 8);
INSERT INTO devoluciones VALUES (9, 'No cumple con especificaciones', DEFAULT, 9);
INSERT INTO devoluciones VALUES (10, 'Cliente insatisfecho', DEFAULT, 10);

INSERT INTO factura VALUES (1, 'Compra de boxer', 1, 1500.00, DEFAULT, 1, 1, 1, 1);
INSERT INTO factura VALUES (2, 'Compra de blusa', 10, 100.00, DEFAULT, 7, 2, 2, 2);
INSERT INTO factura VALUES (3, 'Compra de vestido', 1, 400.00, DEFAULT, 6, 3, 3, 3);
INSERT INTO factura VALUES (4, 'Compra de zapatos', 2, 140.00, DEFAULT, 9, 4, 1, 4);
INSERT INTO factura VALUES (5, 'Compra de short', 1, 250.00, DEFAULT, 4, 5, 2, 5);
INSERT INTO factura VALUES (6, 'Compra de camisa polo', 3, 240.00, DEFAULT, 5, 6, 3, 6);
INSERT INTO factura VALUES (7, 'Compra de panties', 1, 120.00, DEFAULT, 3, 7, 4, 7);
INSERT INTO factura VALUES (8, 'Compra de vestido de gala', 1, 300.00, DEFAULT, 2, 8, 5, 8);
INSERT INTO factura VALUES (9, 'Compra de enterizo', 5, 25.00, DEFAULT, 10, 9, 6, 9);
INSERT INTO factura VALUES (10, 'Compra de chaqueta', 2, 300.00, DEFAULT, 8, 10, 7, 10);
