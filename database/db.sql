
CREATE DATABASE riobeta;
CREATE DATABASE inventario;
SHOW DATABASES;


create table envio(
    id_envio INT AUTO_INCREMENT PRIMARY KEY,
    direccion_envio VARCHAR(50),
    fecha_envio DATE,
    estado_envio VARCHAR(50)
);

create table empleado(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    cargo VARCHAR(50),
    salario DECIMAL(12,2),
    fecha_contratacion DATE,
    estado_envio VARCHAR(50)
);

create table proveedor(
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(50),
    contacto VARCHAR(50),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(50),
    UNIQUE(correo_electronico)

);

create table cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    correo_electronico VARCHAR(50),
    telefono VARCHAR(20)
);

create table pedido(
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE,
    estado_pedido VARCHAR(50)
);

ALTER TABLE pedido
 ADD id_cliente INT,
 ADD id_empleado INT,
 ADD id_pago INT,
 ADD id_envio INT;


ALTER TABLE pedido
	ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	ADD CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
	ADD CONSTRAINT fk_pago FOREIGN KEY (id_pago) REFERENCES pago(id_pago),
	ADD CONSTRAINT fk_envio FOREIGN KEY (id_envio) REFERENCES envio(id_envio);


ALTER TABLE envio
DROP COLUMN idenvio; 
ALTER TABLE pedido DROP FOREIGN KEY fk_envio;
ALTER TABLE envio;
create TABLE producto(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(50),
    descripcion_producto VARCHAR(100),
    precio_producto DECIMAL(12,2),
    stock_producto INT,
	FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_materia_prima) REFERENCES materia_prima(id_materia_prima),
	FOREIGN KEY (id_categoria_producto) REFERENCES id_categoria_producto(id_categoria_producto)
);

ALTER TABLE producto
	ADD  id_proveedor INT,
    ADD  id_materia_prima INT,
    ADD  id_categoria_producto INT;

ALTER TABLE producto
    ADD CONSTRAINT fk_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    ADD CONSTRAINT fk_materia_prima FOREIGN KEY (id_materia_prima) REFERENCES materia_prima(id_materia_prima),
    ADD CONSTRAINT fk_categoria_producto FOREIGN KEY (id_categoria_producto) REFERENCES categoria_producto(id_categoria_producto);


ALTER TABLE producto
ADD id_unidad_medida INT,
ADD id_promocion INT,
ADD id_historial_precio INT;








create table pago(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    metodo_pago VARCHAR(50),
    monto_pago DECIMAL(12,2),
    fecha_pago DATE
);

create table detalle_pedido(
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    cantidad_detalle_pedido DECIMAL(12,2),
    precio_unitario_detalle_pedido INT,
	FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

ALTER TABLE detalle_pedido
ADD id_pedido INT,
ADD id_producto INT;

ALTER TABLE detalle_pedido
ADD CONSTRAINT  fk_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
ADD CONSTRAINT  fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto);







create table categoria_producto(
    id_categoria_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria_producto VARCHAR(50),
    descripcion_categoria_producto VARCHAR(50)

);


create table materia_prima(
    id_materia_prima INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_materia_prima VARCHAR(50),
    unidad_medida_materia_prima VARCHAR(50),
    precio_unidad_materia_prima VARCHAR(50)
);


ALTER TABLE materia_prima
ADD id_registro_calidad INT;



CREATE SCHEMA inventario;

USE inventario;
USE riobeta;

CREATE TABLE tipo_material(
id_tipo_material INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50));
 
 


CREATE TABLE inventario(
id_inventario INT AUTO_INCREMENT PRIMARY KEY,
id_existencias INT,
id_tipo_material INT,
id_categoria INT);


ALTER TABLE inventario
ADD CONSTRAINT fk_existencias FOREIGN KEY (id_existencias) REFERENCES existencias(id_existencias),
ADD CONSTRAINT fk_tipo_material FOREIGN KEY (id_tipo_material) REFERENCES tipo_material(id_tipo_material),
ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

use inventario;

ALTER TABLE inventario
ADD id_categoria_producto INT;

ALTER TABLE inventario
ADD CONSTRAINT fk_categoria_producto FOREIGN KEY (id_categoria_producto) REFERENCES riobeta.categoria_producto(id_categoria_producto);


CREATE TABLE ubicacion_producto(
id_ubicacion_producto INT AUTO_INCREMENT PRIMARY KEY,
nombre_ubicacion VARCHAR(50),
descripcion VARCHAR(50));


CREATE TABLE proveedor(
id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
nombre_empresa VARCHAR(50),
contacto VARCHAR(50),
telefono VARCHAR(20),
correo_electronico VARCHAR(50)
);

ALTER TABLE proveedor
ADD id_materia_prima INT;

ALTER TABLE proveedor
ADD CONSTRAINT fk_materia_prima FOREIGN KEY (id_materia_prima) REFERENCES materia_prima(id_materia_prima);

USE inventario;

CREATE TABLE existencias(
id_existencias INT AUTO_INCREMENT PRIMARY KEY,
nombre_existencias VARCHAR(50),
cantidad_existencias DECIMAL(12,2),
fecha_actualizacion DATE,
id_producto INT,
id_inventario INT,
id_movimiento_inventario INT,
id_ubicacion INT);

CREATE TABLE categoria(
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre_categoria VARCHAR(50),
descripcion VARCHAR(50));


use inventario;

CREATE TABLE movimiento_inventario(
id_movimiento_inventario INT AUTO_INCREMENT PRIMARY KEY,
tipo_movimiento VARCHAR(50),
cantidad_inventario VARCHAR(50),
fecha_movimiento DATE,
razon_movimiento VARCHAR(50),
id_compra INT);


CREATE TABLE registro_calidad(
id_registro_calidad INT AUTO_INCREMENT PRIMARY KEY,
fecha_registro DATE,
observaciones VARCHAR(50)
);


CREATE TABLE compra(
id_compra INT AUTO_INCREMENT PRIMARY KEY,
fecha_compra DATE,
monto_total DECIMAL(12,2)
);

CREATE TABLE unidad_medida(
id_unidad_medida INT AUTO_INCREMENT PRIMARY KEY,
nombre_unidad VARCHAR(50),
abreviatura VARCHAR(15)
);

CREATE TABLE historial_precio(
id_historial_precio INT AUTO_INCREMENT PRIMARY KEY,
precio_anterior DECIMAL(12,2),
fecha_cambio DATE
);

CREATE TABLE promocion(
id_promocion INT AUTO_INCREMENT PRIMARY KEY,
descripcion VARCHAR(50),
descuento DECIMAL(12,2),
fecha_inicio DATE,
fecha_fin DATE

);


ALTER TABLE existencias
ADD id_ubicacion_producto INT;

ALTER TABLE existencias
ADD CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

use riobeta;
use inventario;


ALTER TABLE existencias
ADD CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES riobeta.producto(id_producto),
ADD CONSTRAINT fk_inventario FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
ADD CONSTRAINT fk_movimiento_inventario FOREIGN KEY (id_movimiento_inventario) REFERENCES movimiento_inventario(id_movimiento_inventario),
ADD CONSTRAINT fk_ubicacion_producto FOREIGN KEY (id_ubicacion_producto) REFERENCES ubicacion_producto(id_ubicacion_producto);

ALTER TABLE materia_prima
ADD CONSTRAINT fk_registro_calidad FOREIGN KEY (id_registro_calidad) REFERENCES inventario.registro_calidad(id_registro_calidad);



ALTER TABLE movimiento_inventario
ADD CONSTRAINT fk_compra FOREIGN KEY (id_compra) REFERENCES compra(id_compra);


ALTER TABLE producto
ADD CONSTRAINT fk_unidad_medida FOREIGN KEY (id_unidad_medida) REFERENCES inventario.unidad_medida(id_unidad_medida),
ADD CONSTRAINT fk_promocion FOREIGN KEY (id_promocion) REFERENCES inventario.promocion(id_promocion),
ADD CONSTRAINT fk_historial_precio FOREIGN KEY (id_historial_precio) REFERENCES inventario.historial_precio(id_historial_precio);

use inventario;

DROP TABLE categoria;

