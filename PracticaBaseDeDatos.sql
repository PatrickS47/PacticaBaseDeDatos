-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS ventas;
USE ventas;

-- Crear tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2)
);

-- Crear tabla de clientes
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

-- Crear tabla de cabecera de factura
CREATE TABLE IF NOT EXISTS cabecera_factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Crear tabla de detalle de factura
CREATE TABLE IF NOT EXISTS detalle_factura (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_factura INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_factura) REFERENCES cabecera_factura(id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Insertar datos en la tabla de productos
INSERT INTO productos (nombre, precio) VALUES 
('Producto A', 10.00),
('Producto B', 20.00),
('Producto C', 30.00);

-- Insertar datos en la tabla de clientes
INSERT INTO clientes (nombre, direccion) VALUES 
('Cliente 1', 'Dirección 1'),
('Cliente 2', 'Dirección 2');

-- Insertar datos en la tabla de cabecera de factura
INSERT INTO cabecera_factura (id_cliente, fecha) VALUES 
(1, '2024-06-01'),
(2, '2024-06-02');

-- Insertar datos en la tabla de detalle de factura
INSERT INTO detalle_factura (id_factura, id_producto, cantidad) VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 2, 3),
(2, 3, 1);

-- Consulta 1: Recuperar una factura y todos los productos que posee
SELECT cf.id_factura, cf.fecha, p.nombre AS producto, p.precio, df.cantidad
FROM cabecera_factura cf
JOIN detalle_factura df ON cf.id_factura = df.id_factura
JOIN productos p ON df.id_producto = p.id_producto
WHERE cf.id_factura = 1; -- Cambiar el valor de id_factura según sea necesario

-- Consulta 2: Recuperar todas las facturas y el nombre de los clientes
SELECT cf.id_factura, cf.fecha, c.nombre AS cliente
FROM cabecera_factura cf
JOIN clientes c ON cf.id_cliente = c.id_cliente;
