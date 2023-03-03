DROP DATABASE GRANJA;
CREATE DATABASE GRANJA;
USE GRANJA;

CREATE TABLE GANADERO(
dni VARCHAR(9) PRIMARY KEY,
nombre VARCHAR(25) NOT NULL,
direccion VARCHAR(25),
telefono INT
);

CREATE TABLE GRANJA(
id_granja INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(25) NOT NULL,
direccion VARCHAR(25),
propietario VARCHAR(9) NOT NULL,
FOREIGN KEY (propietario) REFERENCES GANADERO (dni)
                          ON UPDATE CASCADE
);

CREATE TABLE SINTOMAS(
id_sintoma INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
descripcion VARCHAR(50) UNIQUE NOT NULL,
gravedad ENUM("ligero", "normal", "grave", "cronico")
);

CREATE TABLE ENFERMEDAD(
id_enfermedad INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
descripcion VARCHAR(50) UNIQUE NOT NULL,
sinonimo VARCHAR(25),
tratamiento VARCHAR(255)
);

CREATE TABLE ENFERMEDAD_SINTOMAS(
id_enfermedad INT UNSIGNED,
id_sintoma INT UNSIGNED,
PRIMARY KEY (id_enfermedad, id_sintoma),
FOREIGN KEY (id_enfermedad) REFERENCES ENFERMEDAD (id_enfermedad),
FOREIGN KEY (id_sintoma) REFERENCES SINTOMAS (id_sintoma)
);

CREATE TABLE RES(
num_control INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
especie ENUM("ovino", "bovino", "caprino", "porcino"),
raza VARCHAR(25),
sexo ENUM("H", "M"),
peso INT UNSIGNED,
f_nacimiento DATE,
res_madre INT UNSIGNED,
res_padre INT UNSIGNED,
granja_nacimiento INT UNSIGNED,
granja_actual INT UNSIGNED,
FOREIGN KEY (res_madre) REFERENCES RES(num_control),
FOREIGN KEY (res_padre) REFERENCES RES(num_control),
FOREIGN KEY (granja_nacimiento) REFERENCES GRANJA(id_granja),
FOREIGN KEY (granja_actual) REFERENCES GRANJA(id_granja)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE
);

CREATE TABLE RES_SINTOMA(
num_control INT UNSIGNED,
id_sintoma INT UNSIGNED,
PRIMARY KEY (num_control, id_sintoma),
FOREIGN KEY (num_control) REFERENCES RES(num_control)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
FOREIGN KEY (id_sintoma) REFERENCES SINTOMAS(id_sintoma)
);

CREATE TABLE RES_ENFERMEDAD(
num_control INT UNSIGNED,
id_enfermedad INT UNSIGNED NOT NULL,
fecha DATE NOT NULL,
PRIMARY KEY (num_control, fecha),
FOREIGN KEY (num_control) REFERENCES RES(num_control)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
FOREIGN KEY (id_enfermedad) REFERENCES ENFERMEDAD(id_enfermedad)
);

INSERT INTO GANADERO
(dni, nombre, direccion, telefono)
VALUES
("12345678A","Pepe","Calle falsa 123", 612123123),
("45678123B","Juan","Los Rosales, 3", 654654654),
("67812345C","Maria","El pinar, 9", 611222333),
("13579111D","Sofia","Los olvidos", 696797979),
("24681012E","Antonio","Calle wakanda", 666778899)
;


INSERT INTO GRANJA
(id_granja, nombre, direccion, propietario)
VALUES
(null, "Animalitos para todos", "Calle vaquera n 2", "12345678A"),
(null, "Animalitos para todos2", "Calle huelva esquina", "12345678A"),
(null, "Refugio dentado", "Urbanizacion buenavista", "45678123B"),
(null, "El matadero", "Calle ventura, 23", "67812345C"),
(null, "Vacas Locas", "Calle ventura, 22", "13579111D"),
(null, "Ovejas Locas", "Calle ventura, 24", "13579111D"),
(null, "Paraiso", "Calle Santa Fobia, 1", "24681012E")
;

INSERT INTO SINTOMAS
(id_sintoma, descripcion, gravedad)
VALUES
(null, "Lengua morada", "ligero"),
(null, "Herida con algo de sangre", "normal"),
(null, "Herida con sangre abundante", "grave"),
(null, "Boca muy seca", "ligero"),
(null, "Le falta una o varias extremidades", "cronico"),
(null, "Cuerno roto", "normal"),
(null, "Pata inchada", "normal"),
(null, "Hace ruidos de quejido constantes", "grave"),
(null, "Pupilas dilatadas, reacciona a la luz", "normal"),
(null, "Pupilas dilatadas, pero no reacciona a la luz", "cronico"),
(null, "Cojea", "ligero"),
(null, "No puede caminar", "grave"),
(null, "No puede levantarse del suelo", "cronico")
;

INSERT INTO ENFERMEDAD
(id_enfermedad, descripcion, sinonimo, tratamiento)
VALUES
(null, "Cojera", null, "Reposo y frio"),
(null, "Ceguera", null, "Evitar espacios cerrados y pequeños."),
(null, "Gripe A", "Vacas Locas", "Medicamentos recomendados por el veterinario"),
(null, "Contusion", "Golpes", "Reposo"),
(null, "Mutilacion", "Tres Patas", "Usar aparato con ruedas para que pueda caminar"),
(null, "Constipado", "Sequedad", "Comida aguada, poca cantidad")
;

INSERT INTO ENFERMEDAD_SINTOMAS
(id_enfermedad, id_sintoma)
VALUES
(1,3),
(1,5),
(2,8),
(2,9),
(2,10),
(3,1),
(3,4),
(3,9),
(4,2),
(4,6),
(4,7),
(4,11),
(4,12),
(5,2),
(5,3),
(5,12),
(5,13),
(6,1),
(6,4),
(6,8)
;

INSERT INTO RES
(num_control, especie, raza, sexo, peso, f_nacimiento, res_madre, res_padre, granja_nacimiento, granja_actual)
VALUES
(1, "caprino", "caprino enorme", "M", 82, "2012-04-16", null, null, null, 2),
(2, "caprino", "caprino shiny", "M", 113, "2007-04-24", null, null, null, 6),
(3, "caprino", "caprino sinpelo", "H", 103, "2011-08-21", null, null, null, 6),
(4, "caprino", "caprino sinpelo", "H", 31, "2009-11-12", null, null, null, 4),
(5, "ovino", "ovino albino", "H", 32, "2011-09-13", null, null, null, 2),
(6, "porcino", "porcino albino", "M", 114, "2012-09-27", null, null, null, 6),
(7, "bovino", "bovino sinpelo", "H", 118, "2007-02-17", null, null, null, 7),
(8, "caprino", "caprino shiny", "H", 75, "2012-11-05", null, null, null, 2),
(9, "bovino", "bovino shiny", "H", 88, "2008-03-10", null, null, null, 7),
(10, "bovino", "bovino albino", "M", 29, "2014-01-17", null, null, null, 1),
(11, "caprino", "caprino mini", "H", 45, "2005-02-21", null, null, null, 7),
(12, "porcino", "porcino enorme", "H", 95, "2007-09-24", null, null, null, 5),
(13, "caprino", "caprino sinpelo", "M", 83, "2005-04-22", null, null, null, 1),
(14, "bovino", "bovino shiny", "M", 40, "2009-07-22", null, null, null, 6),
(15, "ovino", "ovino shiny", "M", 78, "2014-02-19", null, null, null, 2),
(16, "bovino", "bovino shiny", "M", 24, "2008-07-14", null, null, null, 3),
(17, "porcino", "porcino sinpelo", "M", 97, "2005-10-02", null, null, null, 6),
(18, "caprino", "caprino enorme", "H", 94, "2007-03-10", null, null, null, 3),
(19, "ovino", "ovino mini", "H", 87, "2013-12-17", null, null, null, 7),
(20, "bovino", "bovino shiny", "M", 69, "2012-08-04", null, null, null, 3),
(21, "porcino", "porcino mini", "M", 76, "2013-09-23", null, null, null, 6),
(22, "ovino", "ovino shiny", "M", 82, "2012-07-17", null, null, null, 4),
(23, "caprino", "caprino albino", "M", 55, "2011-02-25", null, null, null, 5),
(24, "ovino", "ovino albino", "M", 106, "2010-06-19", null, null, null, 7),
(25, "caprino", "caprino shiny", "H", 76, "2005-08-26", null, null, null, 7),
(26, "porcino", "porcino sinpelo", "M", 41, "2005-04-28", null, null, null, 3),
(27, "porcino", "porcino mini", "H", 30, "2005-06-04", null, null, null, 5),
(28, "caprino", "caprino sinpelo", "H", 90, "2013-10-24", null, null, null, 6),
(29, "porcino", "porcino comun", "H", 36, "2007-10-13", null, null, null, 4),
(30, "ovino", "ovino enorme", "M", 81, "2007-01-17", null, null, null, 1),
(31, "bovino", "bovino albino", "M", 114, "2010-11-08", null, null, null, 4),
(32, "porcino", "porcino enorme", "M", 95, "2005-04-14", null, null, null, 6),
(33, "ovino", "ovino comun", "M", 72, "2008-10-04", null, null, null, 6),
(34, "porcino", "porcino comun", "M", 33, "2008-10-04", null, null, null, 6),
(35, "ovino", "ovino shiny", "H", 68, "2010-09-02", null, null, null, 3),
(36, "porcino", "porcino shiny", "H", 81, "2006-08-02", null, null, null, 1),
(37, "porcino", "porcino sinpelo", "M", 96, "2010-10-21", null, null, null, 4),
(38, "porcino", "porcino sinpelo", "H", 30, "2009-03-27", null, null, null, 6),
(39, "ovino", "ovino shiny", "H", 43, "2010-09-25", null, null, null, 5),
(40, "caprino", "caprino albino", "H", 81, "2007-02-09", null, null, null, 7),
(41, "caprino", "caprino comun", "H", 65, "2011-03-03", null, null, null, 4),
(42, "bovino", "bovino enorme", "H", 107, "2009-06-17", null, null, null, 7),
(43, "caprino", "caprino albino", "M", 42, "2006-11-14", null, null, null, 4),
(44, "bovino", "bovino shiny", "H", 112, "2012-05-14", null, null, null, 3),
(45, "porcino", "porcino enorme", "H", 49, "2010-02-28", null, null, null, 4),
(46, "caprino", "caprino albino", "M", 28, "2005-10-04", null, null, null, 3),
(47, "bovino", "bovino shiny", "H", 101, "2011-05-09", null, null, null, 4),
(48, "ovino", "ovino mini", "H", 22, "2006-10-09", null, null, null, 7),
(49, "caprino", "caprino albino", "M", 26, "2009-07-18", null, null, null, 7),
(50, "caprino", "caprino shiny", "M", 37, "2008-07-14", null, null, null, 5),
(51, "caprino", "caprino shiny", "M", 97, "2014-04-27", null, null, null, 4),
(52, "bovino", "bovino sinpelo", "H", 45, "2008-04-23", null, null, null, 1),
(53, "porcino", "porcino albino", "M", 103, "2010-06-04", null, null, null, 2),
(54, "ovino", "ovino sinpelo", "M", 34, "2011-06-02", null, null, null, 7),
(55, "bovino", "bovino albino", "M", 79, "2011-04-21", null, null, null, 4),
(56, "caprino", "caprino comun", "M", 98, "2012-05-21", null, null, null, 2),
(57, "bovino", "bovino mini", "H", 63, "2009-04-11", null, null, null, 3),
(58, "caprino", "caprino comun", "M", 78, "2013-04-19", null, null, null, 2),
(59, "caprino", "caprino mini", "M", 29, "2007-03-25", null, null, null, 4),
(60, "bovino", "bovino shiny", "M", 91, "2010-12-27", null, null, null, 2),
(61, "porcino", "porcino shiny", "M", 34, "2005-10-03", null, null, null, 2),
(62, "bovino", "bovino sinpelo", "H", 115, "2005-08-16", null, null, null, 1),
(63, "ovino", "ovino enorme", "H", 45, "2012-06-12", null, null, null, 5),
(64, "bovino", "bovino albino", "H", 66, "2007-10-08", null, null, null, 1),
(65, "ovino", "ovino albino", "M", 83, "2007-10-02", null, null, null, 6),
(66, "bovino", "bovino comun", "M", 25, "2006-07-27", null, null, null, 2),
(67, "caprino", "caprino shiny", "H", 44, "2011-11-24", null, null, null, 2),
(68, "porcino", "porcino albino", "H", 62, "2013-08-10", null, null, null, 3),
(69, "porcino", "porcino albino", "M", 38, "2010-07-25", null, null, null, 7),
(70, "caprino", "caprino shiny", "M", 105, "2013-08-14", null, null, null, 6),
(71, "porcino", "porcino comun", "M", 102, "2008-06-22", null, null, null, 5),
(72, "bovino", "bovino shiny", "H", 107, "2011-06-06", null, null, null, 3),
(73, "bovino", "bovino mini", "H", 35, "2011-03-18", null, null, null, 4),
(74, "porcino", "porcino mini", "H", 65, "2013-06-10", null, null, null, 3),
(75, "caprino", "caprino albino", "H", 106, "2008-01-22", null, null, null, 4),
(76, "bovino", "bovino albino", "H", 27, "2010-02-09", null, null, null, 5),
(77, "ovino", "ovino shiny", "M", 85, "2009-06-01", null, null, null, 6),
(78, "bovino", "bovino comun", "M", 56, "2008-08-04", null, null, null, 5),
(79, "bovino", "bovino shiny", "M", 41, "2006-05-22", null, null, null, 2),
(80, "bovino", "bovino albino", "M", 87, "2007-06-23", null, null, null, 1),
(81, "porcino", "porcino enorme", "M", 71, "2005-08-20", null, null, null, 2),
(82, "ovino", "ovino enorme", "M", 26, "2006-07-11", null, null, null, 4),
(83, "porcino", "porcino enorme", "M", 95, "2007-02-08", null, null, null, 3),
(84, "ovino", "ovino albino", "M", 58, "2008-03-04", null, null, null, 6),
(85, "bovino", "bovino comun", "H", 71, "2009-10-23", null, null, null, 2),
(86, "porcino", "porcino albino", "H", 91, "2005-10-09", null, null, null, 5),
(87, "caprino", "caprino sinpelo", "H", 92, "2010-03-07", null, null, null, 5),
(88, "bovino", "bovino sinpelo", "M", 103, "2014-07-17", null, null, null, 2),
(89, "caprino", "caprino albino", "M", 97, "2005-02-22", null, null, null, 5),
(90, "porcino", "porcino mini", "M", 38, "2010-09-13", null, null, null, 7),
(91, "porcino", "porcino comun", "H", 55, "2013-03-27", null, null, null, 6),
(92, "ovino", "ovino sinpelo", "M", 92, "2005-10-15", null, null, null, 5),
(93, "porcino", "porcino comun", "H", 73, "2013-01-14", null, null, null, 3),
(94, "porcino", "porcino shiny", "H", 55, "2005-02-28", null, null, null, 3),
(95, "porcino", "porcino albino", "M", 80, "2007-07-04", null, null, null, 3),
(96, "porcino", "porcino enorme", "H", 42, "2013-03-15", null, null, null, 4),
(97, "ovino", "ovino mini", "M", 24, "2014-09-15", null, null, null, 5),
(98, "bovino", "bovino mini", "M", 78, "2013-07-28", null, null, null, 3),
(99, "bovino", "bovino albino", "H", 51, "2009-04-16", null, null, null, 1),
(100, "ovino", "ovino enorme", "H", 78, "2012-03-25", null, null, null, 7),
(101, "porcino", "porcino enorme", "H", 100, "2013-06-21", null, null, null, 4),
(102, "ovino", "ovino mini", "M", 72, "2013-11-05", null, null, null, 7),
(103, "caprino", "caprino mini", "M", 72, "2014-09-19", null, null, null, 4),
(104, "porcino", "porcino sinpelo", "M", 29, "2011-09-13", null, null, null, 5),
(105, "bovino", "bovino mini", "M", 22, "2009-05-02", null, null, null, 6),
(106, "caprino", "caprino albino", "H", 29, "2006-10-20", null, null, null, 3),
(107, "caprino", "caprino albino", "H", 22, "2009-08-14", null, null, null, 4),
(108, "bovino", "bovino enorme", "M", 34, "2006-10-15", null, null, null, 7),
(109, "bovino", "bovino enorme", "H", 49, "2011-08-20", null, null, null, 3),
(110, "porcino", "porcino sinpelo", "H", 97, "2007-11-12", null, null, null, 3),
(111, "ovino", "ovino mini", "H", 40, "2008-09-24", null, null, null, 3),
(112, "caprino", "caprino shiny", "M", 85, "2005-12-06", null, null, null, 2),
(113, "porcino", "porcino enorme", "M", 76, "2011-01-08", null, null, null, 4),
(114, "caprino", "caprino shiny", "H", 31, "2014-01-03", null, null, null, 5),
(115, "caprino", "caprino enorme", "H", 32, "2007-01-25", null, null, null, 5),
(116, "caprino", "caprino sinpelo", "H", 94, "2011-06-26", null, null, null, 2),
(117, "porcino", "porcino mini", "H", 54, "2008-09-13", null, null, null, 2),
(118, "porcino", "porcino shiny", "H", 67, "2006-05-04", null, null, null, 5),
(119, "porcino", "porcino mini", "H", 105, "2010-08-17", null, null, null, 7),
(120, "bovino", "bovino sinpelo", "M", 76, "2006-09-01", null, null, null, 3),
(121, "bovino", "bovino albino", "M", 35, "2014-11-27", null, null, null, 7),
(122, "caprino", "caprino enorme", "M", 31, "2008-04-14", null, null, null, 4),
(123, "caprino", "caprino shiny", "H", 23, "2008-04-26", null, null, null, 4),
(124, "ovino", "ovino enorme", "M", 70, "2013-03-02", null, null, null, 3),
(125, "bovino", "bovino enorme", "H", 43, "2005-06-08", null, null, null, 5),
(126, "ovino", "ovino mini", "H", 56, "2006-08-21", null, null, null, 3),
(127, "caprino", "caprino shiny", "H", 94, "2007-01-27", null, null, null, 2),
(128, "ovino", "ovino albino", "H", 70, "2007-09-22", null, null, null, 5),
(129, "ovino", "ovino shiny", "H", 68, "2014-01-09", null, null, null, 2),
(130, "caprino", "caprino albino", "H", 42, "2010-03-13", null, null, null, 4),
(131, "porcino", "porcino mini", "H", 72, "2013-09-07", null, null, null, 5),
(132, "caprino", "caprino comun", "M", 97, "2013-06-22", null, null, null, 4),
(133, "bovino", "bovino mini", "M", 88, "2009-03-22", null, null, null, 4),
(134, "ovino", "ovino shiny", "H", 28, "2010-10-27", null, null, null, 2),
(135, "bovino", "bovino albino", "H", 95, "2007-09-17", null, null, null, 5),
(136, "caprino", "caprino shiny", "H", 84, "2011-06-06", null, null, null, 1),
(137, "porcino", "porcino enorme", "H", 115, "2010-10-02", null, null, null, 2),
(138, "ovino", "ovino mini", "H", 94, "2013-01-01", null, null, null, 1),
(139, "ovino", "ovino mini", "M", 39, "2013-12-01", null, null, null, 1),
(140, "caprino", "caprino comun", "M", 92, "2007-01-24", null, null, null, 7),
(141, "caprino", "caprino shiny", "H", 63, "2008-12-10", null, null, null, 4),
(142, "caprino", "caprino enorme", "H", 89, "2014-06-06", null, null, null, 5),
(143, "porcino", "porcino comun", "H", 105, "2007-12-27", null, null, null, 2),
(144, "caprino", "caprino sinpelo", "H", 46, "2010-04-09", null, null, null, 6),
(145, "ovino", "ovino enorme", "M", 44, "2012-08-23", null, null, null, 2),
(146, "porcino", "porcino mini", "H", 84, "2005-08-02", null, null, null, 3),
(147, "ovino", "ovino shiny", "H", 24, "2007-03-14", null, null, null, 7),
(148, "porcino", "porcino shiny", "H", 103, "2011-04-15", null, null, null, 6),
(149, "ovino", "ovino enorme", "M", 90, "2014-04-10", null, null, null, 7),
(150, "bovino", "bovino enorme", "H", 43, "2005-03-23", null, null, null, 1),
(151, "bovino", "bovino comun", "M", 89, "2005-04-13", null, null, null, 3),
(152, "caprino", "caprino shiny", "H", 39, "2012-06-15", null, null, null, 7),
(153, "ovino", "ovino albino", "M", 97, "2014-02-08", null, null, null, 6),
(154, "porcino", "porcino enorme", "H", 31, "2014-07-11", null, null, null, 7),
(155, "bovino", "bovino sinpelo", "H", 117, "2011-11-28", null, null, null, 4),
(156, "caprino", "caprino sinpelo", "M", 64, "2014-09-15", null, null, null, 2),
(157, "bovino", "bovino sinpelo", "M", 97, "2008-09-13", null, null, null, 2),
(158, "ovino", "ovino sinpelo", "H", 39, "2012-10-07", null, null, null, 6),
(159, "bovino", "bovino shiny", "H", 28, "2010-01-28", null, null, null, 2),
(160, "caprino", "caprino comun", "H", 61, "2009-06-02", null, null, null, 7),
(161, "caprino", "caprino albino", "M", 51, "2006-02-18", null, null, null, 1),
(162, "bovino", "bovino comun", "M", 34, "2005-03-05", null, null, null, 3),
(163, "porcino", "porcino enorme", "H", 54, "2005-12-11", null, null, null, 1),
(164, "porcino", "porcino shiny", "H", 50, "2011-07-16", null, null, null, 6),
(165, "porcino", "porcino shiny", "H", 72, "2006-02-26", null, null, null, 6),
(166, "bovino", "bovino albino", "M", 34, "2008-04-14", null, null, null, 4),
(167, "porcino", "porcino sinpelo", "H", 75, "2006-08-28", null, null, null, 5),
(168, "bovino", "bovino comun", "M", 75, "2005-05-04", null, null, null, 4),
(169, "caprino", "caprino enorme", "H", 68, "2011-09-20", null, null, null, 7),
(170, "porcino", "porcino mini", "H", 115, "2011-08-07", null, null, null, 3),
(171, "bovino", "bovino sinpelo", "H", 70, "2012-01-09", null, null, null, 6),
(172, "caprino", "caprino comun", "M", 24, "2013-06-15", null, null, null, 5),
(173, "bovino", "bovino comun", "M", 112, "2011-06-21", null, null, null, 6),
(174, "porcino", "porcino albino", "M", 35, "2013-02-06", null, null, null, 3),
(175, "bovino", "bovino shiny", "M", 108, "2009-05-24", null, null, null, 2),
(176, "porcino", "porcino sinpelo", "M", 62, "2011-07-11", null, null, null, 3),
(177, "caprino", "caprino enorme", "M", 43, "2011-03-10", null, null, null, 5),
(178, "caprino", "caprino mini", "M", 83, "2009-09-09", null, null, null, 3),
(179, "caprino", "caprino mini", "H", 49, "2005-01-13", null, null, null, 4),
(180, "ovino", "ovino albino", "M", 99, "2014-08-22", null, null, null, 6),
(181, "bovino", "bovino mini", "H", 80, "2010-05-04", null, null, null, 2),
(182, "ovino", "ovino enorme", "M", 60, "2008-11-06", null, null, null, 1),
(183, "porcino", "porcino albino", "H", 82, "2012-10-04", null, null, null, 1),
(184, "ovino", "ovino mini", "M", 75, "2008-05-27", null, null, null, 6),
(185, "bovino", "bovino sinpelo", "M", 68, "2009-04-19", null, null, null, 7),
(186, "caprino", "caprino enorme", "H", 78, "2005-12-07", null, null, null, 4),
(187, "ovino", "ovino mini", "H", 79, "2012-07-24", null, null, null, 4),
(188, "ovino", "ovino comun", "M", 81, "2009-11-10", null, null, null, 1),
(189, "ovino", "ovino comun", "H", 54, "2013-04-19", null, null, null, 7),
(190, "porcino", "porcino comun", "H", 88, "2008-05-15", null, null, null, 2),
(191, "caprino", "caprino comun", "M", 83, "2006-04-24", null, null, null, 1),
(192, "bovino", "bovino shiny", "M", 92, "2012-04-25", null, null, null, 2),
(193, "porcino", "porcino shiny", "M", 76, "2012-01-08", null, null, null, 3),
(194, "porcino", "porcino enorme", "H", 31, "2007-12-10", null, null, null, 6),
(195, "porcino", "porcino sinpelo", "M", 108, "2009-11-03", null, null, null, 3),
(196, "porcino", "porcino albino", "H", 33, "2013-06-11", null, null, null, 6),
(197, "bovino", "bovino sinpelo", "M", 85, "2010-07-18", null, null, null, 7),
(198, "bovino", "bovino comun", "H", 114, "2013-01-23", null, null, null, 3),
(199, "bovino", "bovino enorme", "M", 81, "2006-07-25", null, null, null, 2),
(200, "caprino", "caprino albino", "H", 69, "2010-11-13", null, null, null, 4)
;

INSERT INTO RES
(num_control, especie, raza, sexo, peso, f_nacimiento, res_madre, res_padre, granja_nacimiento, granja_actual)
VALUES
(201, "porcino", "porcino comun", "M", 96, "2015-11-03", 117, 61, 2, 6),
(202, "bovino", "bovino albino", "H", 46, "2016-11-12", 109, 16, 3, 2),
(203, "porcino", "porcino comun", "H", 93, "2019-07-02", 74, 95, 3, 2),
(204, "ovino", "ovino comun", "M", 41, "2015-10-25", 158, 84, 6, 1),
(205, "bovino", "bovino shiny", "M", 29, "2018-02-07", 181, 157, 2, 2),
(206, "porcino", "porcino comun", "M", 96, "2021-03-26", 38, 21, 6, 3),
(207, "ovino", "ovino shiny", "H", 105, "2020-09-28", 147, 102, 7, 1),
(208, "porcino", "porcino albino", "H", 104, "2020-02-15", 12, 71, 5, 2),
(209, "ovino", "ovino shiny", "M", 92, "2021-02-27", 111, 124, 3, 2),
(210, "caprino", "caprino sinpelo", "H", 59, "2016-11-06", 186, 59, 4, 6),
(211, "bovino", "bovino albino", "M", 104, "2019-08-04", 155, 133, 4, 6),
(212, "porcino", "porcino albino", "M", 97, "2016-05-21", 101, 113, 4, 5),
(213, "bovino", "bovino albino", "M", 113, "2017-12-22", 85, 60, 2, 3),
(214, "ovino", "ovino mini", "H", 101, "2021-12-08", 189, 54, 7, 5),
(215, "caprino", "caprino enorme", "H", 99, "2018-12-15", 4, 43, 4, 4),
(216, "bovino", "bovino shiny", "M", 24, "2017-12-13", 64, 10, 1, 1),
(217, "caprino", "caprino mini", "M", 67, "2019-06-13", 18, 178, 3, 2),
(218, "caprino", "caprino mini", "H", 107, "2016-08-13", 127, 156, 2, 7),
(219, "bovino", "bovino albino", "M", 51, "2018-11-01", 7, 121, 7, 1),
(220, "ovino", "ovino mini", "H", 93, "2021-02-09", 48, 149, 7, 3),
(221, "ovino", "ovino sinpelo", "M", 40, "2021-01-22", 5, 145, 2, 3),
(222, "caprino", "caprino sinpelo", "H", 30, "2018-12-04", 123, 43, 4, 5),
(223, "caprino", "caprino sinpelo", "M", 77, "2018-06-23", 160, 49, 7, 6),
(224, "caprino", "caprino mini", "M", 58, "2021-03-14", 41, 51, 4, 5),
(225, "porcino", "porcino shiny", "H", 77, "2015-10-02", 119, 69, 7, 6),
(226, "bovino", "bovino albino", "H", 53, "2017-04-21", 155, 133, 4, 6),
(227, "caprino", "caprino shiny", "M", 39, "2016-10-19", 186, 132, 4, 1),
(228, "porcino", "porcino mini", "H", 63, "2018-04-18", 12, 104, 5, 2),
(229, "ovino", "ovino albino", "H", 42, "2019-12-11", 189, 24, 7, 6),
(230, "porcino", "porcino shiny", "H", 54, "2018-02-13", 170, 83, 3, 4),
(231, "bovino", "bovino comun", "H", 57, "2015-07-24", 155, 31, 4, 2),
(232, "porcino", "porcino enorme", "H", 72, "2020-10-11", 94, 193, 3, 4),
(233, "porcino", "porcino mini", "M", 88, "2016-11-24", 148, 6, 6, 4),
(234, "ovino", "ovino comun", "H", 54, "2018-08-24", 189, 54, 7, 1),
(235, "bovino", "bovino shiny", "H", 60, "2016-06-19", 62, 10, 1, 1),
(236, "porcino", "porcino shiny", "H", 71, "2017-02-25", 170, 193, 3, 6),
(237, "porcino", "porcino enorme", "H", 113, "2020-09-05", 68, 83, 3, 2),
(238, "caprino", "caprino enorme", "H", 83, "2021-06-10", 4, 43, 4, 2),
(239, "ovino", "ovino mini", "M", 89, "2019-04-01", 138, 182, 1, 7),
(240, "porcino", "porcino comun", "H", 33, "2019-09-02", 196, 34, 6, 1),
(241, "caprino", "caprino mini", "M", 73, "2019-04-27", 18, 178, 3, 5),
(242, "bovino", "bovino comun", "M", 39, "2021-01-18", 64, 80, 1, 2),
(243, "porcino", "porcino sinpelo", "M", 102, "2017-01-15", 148, 21, 6, 2),
(244, "porcino", "porcino comun", "H", 42, "2017-09-19", 86, 104, 5, 7),
(245, "caprino", "caprino enorme", "H", 116, "2018-05-04", 107, 51, 4, 5),
(246, "ovino", "ovino shiny", "M", 74, "2015-04-25", 5, 15, 2, 4),
(247, "porcino", "porcino sinpelo", "H", 113, "2021-05-17", 94, 195, 3, 6),
(248, "bovino", "bovino sinpelo", "H", 84, "2015-05-04", 76, 78, 5, 5),
(249, "ovino", "ovino shiny", "H", 72, "2017-07-08", 189, 24, 7, 4),
(250, "porcino", "porcino mini", "M", 38, "2017-08-14", 119, 69, 7, 3),
(251, "ovino", "ovino albino", "M", 22, "2017-02-11", 48, 54, 7, 6),
(252, "bovino", "bovino albino", "M", 41, "2015-12-04", 52, 10, 1, 6),
(253, "caprino", "caprino shiny", "M", 89, "2016-11-10", 116, 56, 2, 6),
(254, "ovino", "ovino enorme", "H", 22, "2021-02-14", 126, 124, 3, 7),
(255, "caprino", "caprino enorme", "H", 38, "2015-11-13", 107, 43, 4, 1),
(256, "bovino", "bovino sinpelo", "H", 88, "2015-04-08", 85, 88, 2, 5),
(257, "ovino", "ovino mini", "M", 107, "2019-07-24", 129, 15, 2, 3),
(258, "caprino", "caprino comun", "M", 55, "2016-03-26", 4, 51, 4, 5),
(259, "porcino", "porcino shiny", "H", 105, "2017-11-10", 148, 32, 6, 1),
(260, "porcino", "porcino sinpelo", "M", 36, "2017-03-28", 148, 34, 6, 2),
(261, "caprino", "caprino enorme", "M", 71, "2017-05-07", 123, 51, 4, 2),
(262, "bovino", "bovino shiny", "M", 118, "2020-06-07", 7, 197, 7, 6),
(263, "caprino", "caprino mini", "H", 118, "2016-02-08", 142, 50, 5, 1),
(264, "bovino", "bovino mini", "H", 63, "2016-07-25", 181, 175, 2, 5),
(265, "caprino", "caprino mini", "M", 101, "2017-05-05", 87, 89, 5, 4),
(266, "porcino", "porcino sinpelo", "H", 29, "2021-08-09", 194, 6, 6, 1),
(267, "bovino", "bovino comun", "H", 39, "2018-10-07", 7, 197, 7, 3),
(268, "caprino", "caprino comun", "H", 92, "2020-05-07", 123, 43, 4, 5),
(269, "bovino", "bovino mini", "H", 77, "2016-07-02", 181, 192, 2, 7),
(270, "ovino", "ovino enorme", "H", 96, "2015-01-16", 147, 149, 7, 2),
(271, "bovino", "bovino comun", "H", 115, "2017-10-13", 198, 16, 3, 6),
(272, "porcino", "porcino comun", "H", 118, "2015-07-19", 91, 32, 6, 6),
(273, "caprino", "caprino mini", "H", 38, "2016-06-27", 144, 70, 6, 1),
(274, "porcino", "porcino enorme", "H", 50, "2017-03-22", 137, 61, 2, 7),
(275, "porcino", "porcino sinpelo", "H", 37, "2017-02-16", 38, 32, 6, 6),
(276, "porcino", "porcino comun", "M", 44, "2021-10-21", 146, 95, 3, 3),
(277, "porcino", "porcino shiny", "H", 64, "2015-07-07", 146, 195, 3, 3),
(278, "bovino", "bovino mini", "H", 56, "2015-06-09", 85, 192, 2, 6),
(279, "porcino", "porcino sinpelo", "M", 102, "2018-01-27", 93, 176, 3, 1),
(280, "porcino", "porcino sinpelo", "H", 65, "2021-05-11", 94, 95, 3, 6),
(281, "caprino", "caprino mini", "M", 59, "2018-10-09", 25, 49, 7, 5),
(282, "caprino", "caprino sinpelo", "H", 67, "2020-02-26", 141, 59, 4, 6),
(283, "bovino", "bovino enorme", "H", 37, "2018-12-17", 42, 185, 7, 5),
(284, "bovino", "bovino mini", "H", 48, "2015-06-26", 125, 78, 5, 1),
(285, "ovino", "ovino enorme", "M", 109, "2018-04-06", 19, 24, 7, 3),
(286, "porcino", "porcino shiny", "M", 62, "2015-09-12", 164, 32, 6, 3),
(287, "porcino", "porcino shiny", "H", 44, "2019-11-28", 38, 17, 6, 6),
(288, "porcino", "porcino enorme", "M", 108, "2015-02-08", 93, 193, 3, 4),
(289, "caprino", "caprino sinpelo", "M", 44, "2019-07-03", 41, 51, 4, 6),
(290, "porcino", "porcino enorme", "M", 59, "2021-07-09", 196, 17, 6, 6),
(291, "bovino", "bovino enorme", "M", 60, "2021-09-04", 181, 88, 2, 1),
(292, "porcino", "porcino sinpelo", "M", 20, "2015-10-20", 38, 32, 6, 1),
(293, "caprino", "caprino comun", "H", 27, "2021-02-02", 107, 59, 4, 7),
(294, "porcino", "porcino sinpelo", "M", 104, "2019-03-01", 164, 32, 6, 3),
(295, "bovino", "bovino comun", "H", 26, "2015-03-13", 52, 80, 1, 1),
(296, "bovino", "bovino enorme", "M", 92, "2018-12-11", 85, 66, 2, 7),
(297, "porcino", "porcino comun", "H", 72, "2016-06-25", 146, 83, 3, 2),
(298, "caprino", "caprino mini", "H", 87, "2017-07-09", 130, 51, 4, 3),
(299, "caprino", "caprino mini", "H", 30, "2017-05-13", 41, 59, 4, 6),
(300, "caprino", "caprino mini", "H", 39, "2021-12-25", 41, 132, 4, 4),
(301, "bovino", "bovino albino", "M", 84, "2016-03-27", 155, 55, 4, 3),
(302, "caprino", "caprino comun", "H", 68, "2015-04-04", 114, 89, 5, 3),
(303, "bovino", "bovino comun", "M", 43, "2019-10-06", 73, 55, 4, 2),
(304, "caprino", "caprino albino", "M", 67, "2016-04-23", 41, 51, 4, 4),
(305, "bovino", "bovino shiny", "M", 104, "2016-07-18", 52, 10, 1, 4),
(306, "porcino", "porcino enorme", "M", 96, "2016-09-05", 86, 104, 5, 2),
(307, "caprino", "caprino sinpelo", "M", 27, "2020-06-27", 186, 43, 4, 4),
(308, "caprino", "caprino enorme", "M", 101, "2019-06-14", 107, 122, 4, 7),
(309, "porcino", "porcino mini", "H", 63, "2021-02-27", 93, 174, 3, 7),
(310, "bovino", "bovino albino", "M", 30, "2020-08-17", 57, 120, 3, 6),
(311, "porcino", "porcino comun", "M", 71, "2018-04-21", 131, 71, 5, 3),
(312, "bovino", "bovino albino", "M", 37, "2016-08-01", 181, 157, 2, 6),
(313, "bovino", "bovino mini", "H", 42, "2021-02-25", 9, 108, 7, 5),
(314, "porcino", "porcino enorme", "H", 30, "2020-05-24", 94, 83, 3, 1),
(315, "caprino", "caprino albino", "H", 45, "2018-02-08", 141, 132, 4, 6),
(316, "caprino", "caprino enorme", "H", 30, "2017-03-19", 8, 56, 2, 5),
(317, "caprino", "caprino sinpelo", "M", 119, "2021-01-26", 87, 177, 5, 7),
(318, "bovino", "bovino sinpelo", "H", 74, "2018-09-06", 42, 197, 7, 4),
(319, "caprino", "caprino albino", "H", 88, "2016-03-03", 179, 59, 4, 2),
(320, "bovino", "bovino mini", "H", 53, "2016-06-06", 198, 162, 3, 3),
(321, "caprino", "caprino sinpelo", "M", 115, "2017-08-05", 107, 132, 4, 4),
(322, "caprino", "caprino enorme", "M", 41, "2019-12-14", 87, 172, 5, 4),
(323, "porcino", "porcino shiny", "M", 63, "2017-01-23", 110, 174, 3, 5),
(324, "ovino", "ovino comun", "H", 65, "2018-02-06", 158, 84, 6, 5),
(325, "bovino", "bovino enorme", "H", 93, "2021-10-15", 85, 199, 2, 5),
(326, "caprino", "caprino sinpelo", "H", 56, "2019-06-03", 87, 177, 5, 6),
(327, "caprino", "caprino albino", "M", 100, "2016-05-04", 107, 43, 4, 3),
(328, "ovino", "ovino albino", "H", 55, "2015-11-26", 187, 22, 4, 2),
(329, "caprino", "caprino enorme", "M", 76, "2021-07-14", 4, 43, 4, 6),
(330, "caprino", "caprino albino", "H", 37, "2021-03-17", 186, 103, 4, 5),
(331, "porcino", "porcino albino", "H", 76, "2019-07-13", 194, 34, 6, 2),
(332, "caprino", "caprino enorme", "H", 54, "2018-02-17", 127, 156, 2, 7),
(333, "caprino", "caprino comun", "H", 25, "2018-07-09", 127, 112, 2, 5),
(334, "bovino", "bovino shiny", "H", 107, "2019-01-20", 7, 185, 7, 3),
(335, "caprino", "caprino comun", "M", 46, "2020-12-20", 75, 43, 4, 6),
(336, "porcino", "porcino shiny", "M", 89, "2016-07-10", 68, 83, 3, 2),
(337, "ovino", "ovino enorme", "H", 89, "2020-12-23", 48, 102, 7, 2),
(338, "porcino", "porcino shiny", "H", 42, "2016-06-17", 167, 104, 5, 6),
(339, "caprino", "caprino mini", "H", 70, "2020-08-26", 75, 43, 4, 1),
(340, "porcino", "porcino albino", "H", 66, "2016-04-01", 164, 32, 6, 6),
(341, "porcino", "porcino sinpelo", "M", 37, "2019-08-23", 74, 174, 3, 7),
(342, "caprino", "caprino shiny", "M", 86, "2017-12-05", 127, 56, 2, 6),
(343, "porcino", "porcino enorme", "M", 25, "2021-11-14", 146, 95, 3, 5),
(344, "ovino", "ovino sinpelo", "M", 22, "2019-07-10", 48, 102, 7, 7),
(345, "bovino", "bovino comun", "M", 86, "2019-11-07", 155, 31, 4, 5),
(346, "caprino", "caprino comun", "H", 32, "2018-11-15", 123, 122, 4, 4),
(347, "porcino", "porcino albino", "H", 66, "2015-05-28", 68, 176, 3, 3),
(348, "porcino", "porcino albino", "H", 105, "2016-05-05", 143, 61, 2, 7),
(349, "caprino", "caprino enorme", "M", 113, "2021-06-24", 25, 49, 7, 5),
(350, "ovino", "ovino comun", "M", 96, "2015-12-23", 100, 54, 7, 4),
(351, "caprino", "caprino sinpelo", "H", 58, "2015-01-09", 75, 43, 4, 4),
(352, "porcino", "porcino sinpelo", "H", 53, "2017-01-05", 45, 37, 4, 3),
(353, "caprino", "caprino albino", "M", 64, "2015-01-26", 40, 140, 7, 1),
(354, "bovino", "bovino comun", "M", 97, "2021-04-16", 57, 151, 3, 2),
(355, "porcino", "porcino mini", "M", 82, "2020-09-02", 38, 6, 6, 3),
(356, "caprino", "caprino comun", "H", 62, "2017-02-17", 186, 43, 4, 1),
(357, "porcino", "porcino albino", "H", 99, "2015-07-24", 170, 176, 3, 7),
(358, "bovino", "bovino comun", "H", 116, "2019-05-20", 181, 192, 2, 7),
(359, "porcino", "porcino shiny", "M", 71, "2018-08-21", 110, 26, 3, 4),
(360, "bovino", "bovino albino", "H", 77, "2016-02-03", 99, 10, 1, 7),
(361, "bovino", "bovino sinpelo", "H", 114, "2020-12-22", 62, 80, 1, 5),
(362, "porcino", "porcino enorme", "H", 104, "2020-08-02", 194, 6, 6, 6),
(363, "porcino", "porcino enorme", "M", 111, "2018-09-26", 196, 6, 6, 1),
(364, "caprino", "caprino comun", "M", 47, "2017-05-04", 75, 51, 4, 5),
(365, "bovino", "bovino mini", "H", 90, "2021-01-15", 181, 157, 2, 7),
(366, "porcino", "porcino albino", "M", 58, "2019-02-23", 146, 193, 3, 1),
(367, "bovino", "bovino enorme", "M", 95, "2020-11-22", 72, 162, 3, 1),
(368, "bovino", "bovino shiny", "M", 115, "2017-01-14", 7, 185, 7, 4),
(369, "caprino", "caprino mini", "H", 63, "2015-05-14", 116, 56, 2, 3),
(370, "caprino", "caprino mini", "H", 88, "2019-08-26", 179, 132, 4, 1),
(371, "porcino", "porcino enorme", "H", 40, "2017-06-06", 170, 26, 3, 3),
(372, "porcino", "porcino albino", "M", 67, "2019-03-03", 110, 176, 3, 4),
(373, "porcino", "porcino sinpelo", "H", 72, "2018-03-25", 165, 17, 6, 7),
(374, "bovino", "bovino mini", "H", 88, "2019-01-26", 72, 16, 3, 3),
(375, "ovino", "ovino mini", "M", 87, "2016-10-27", 158, 153, 6, 2),
(376, "porcino", "porcino comun", "H", 118, "2021-08-15", 74, 95, 3, 4),
(377, "bovino", "bovino enorme", "M", 114, "2020-08-16", 109, 162, 3, 6),
(378, "caprino", "caprino sinpelo", "H", 33, "2016-02-20", 8, 156, 2, 3),
(379, "porcino", "porcino enorme", "M", 47, "2020-04-16", 91, 32, 6, 1),
(380, "bovino", "bovino shiny", "H", 56, "2017-01-18", 44, 16, 3, 1),
(381, "ovino", "ovino sinpelo", "M", 32, "2018-10-28", 19, 54, 7, 4),
(382, "caprino", "caprino shiny", "M", 52, "2021-06-08", 41, 51, 4, 1),
(383, "porcino", "porcino shiny", "H", 44, "2018-08-12", 27, 104, 5, 3),
(384, "bovino", "bovino mini", "M", 43, "2017-02-11", 44, 120, 3, 6),
(385, "caprino", "caprino enorme", "H", 33, "2020-04-04", 115, 89, 5, 3),
(386, "caprino", "caprino albino", "M", 36, "2017-12-27", 142, 89, 5, 4),
(387, "porcino", "porcino albino", "H", 89, "2019-07-20", 164, 21, 6, 4),
(388, "caprino", "caprino mini", "M", 65, "2016-08-19", 4, 132, 4, 3),
(389, "porcino", "porcino comun", "H", 78, "2020-05-05", 110, 26, 3, 7),
(390, "bovino", "bovino albino", "H", 58, "2020-09-12", 198, 98, 3, 5),
(391, "ovino", "ovino sinpelo", "M", 98, "2020-09-14", 158, 184, 6, 5),
(392, "bovino", "bovino albino", "H", 64, "2019-09-15", 181, 199, 2, 6),
(393, "ovino", "ovino comun", "M", 37, "2021-01-21", 126, 124, 3, 2),
(394, "porcino", "porcino albino", "H", 96, "2019-06-12", 170, 174, 3, 2),
(395, "porcino", "porcino shiny", "H", 112, "2019-02-01", 164, 34, 6, 7),
(396, "ovino", "ovino shiny", "H", 26, "2017-12-09", 129, 145, 2, 3),
(397, "porcino", "porcino comun", "H", 93, "2019-07-21", 190, 53, 2, 7),
(398, "ovino", "ovino shiny", "M", 35, "2016-08-06", 187, 82, 4, 7),
(399, "caprino", "caprino shiny", "M", 60, "2017-04-04", 169, 140, 7, 7),
(400, "porcino", "porcino mini", "H", 103, "2018-12-09", 146, 195, 3, 4)
;

INSERT INTO RES_SINTOMA
(num_control, id_sintoma)
VALUES
(116, 8),
(116, 9),
(86, 11),
(12, 12),
(17, 7),
(109, 1),
(156, 1),
(110, 13),
(127, 2),
(164, 13),
(129, 4),
(193, 2),
(128, 4),
(65, 12),
(21, 2),
(48, 2),
(51, 1),
(50, 3),
(47, 6),
(61, 1),
(119, 5),
(22, 2),
(142, 11),
(172, 1),
(27, 8),
(17, 4),
(147, 13),
(43, 11),
(74, 1),
(65, 10),
(66, 9),
(9, 9),
(29, 8),
(28, 3),
(108, 13),
(13, 9),
(27, 11),
(47, 7),
(46, 10),
(177, 7),
(96, 12),
(76, 3),
(101, 5),
(137, 8),
(106, 5),
(35, 7),
(183, 5),
(66, 2),
(25, 4),
(177, 13)
;

INSERT INTO RES_ENFERMEDAD
(num_control, id_enfermedad, fecha)
VALUES
(116, 1, "2020-05-20"),
(86, 6, "2019-05-05"),
(12, 6, "2021-10-12"),
(17, 3, "2018-04-13"),
(109, 1, "2018-10-18"),
(156, 1, "2022-12-21"),
(127, 1, "2020-02-10"),
(128, 4, "2021-12-03"),
(193, 2, "2021-09-23"),
(65, 6, "2021-10-01"),
(21, 2, "2019-11-23"),
(48, 2, "2022-02-20"),
(51, 1, "2020-07-09"),
(50, 3, "2020-05-09"),
(50, 3, "2022-08-22"),
(47, 6, "2022-11-14"),
(61, 1, "2020-10-12"),
(119, 5, "2021-06-11"),
(22, 2, "2019-04-10"),
(142, 5, "2021-04-01"),
(172, 1, "2018-03-14"),
(27, 4, "2018-06-27"),
(43, 2, "2022-01-25"),
(74, 1, "2021-01-15"),
(65, 5, "2020-05-05"),
(9, 4, "2021-11-10"),
(29, 4, "2018-04-13"),
(28, 3, "2022-03-06"),
(13, 4, "2022-05-15"),
(27, 6, "2021-05-21"),
(47, 4, "2018-12-01"),
(46, 5, "2022-09-03"),
(177, 3, "2021-09-10"),
(96, 6, "2020-01-25"),
(76, 3, "2020-06-04"),
(101, 5, "2018-12-24"),
(137, 1, "2019-02-20"),
(106, 5, "2019-06-26"),
(35, 3, "2020-05-07"),
(183, 5, "2020-03-16"),
(66, 2, "2018-04-16"),
(25, 4, "2020-07-26")
;