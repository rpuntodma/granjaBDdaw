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
(1, "porcino", "porcino albino", "M", 45, "2007-11-13", null, null, null, 6),
(2, "porcino", "porcino albino", "H", 24, "2007-05-13", null, null, null, 1),
(3, "porcino", "porcino shiny", "H", 113, "2012-07-16", null, null, null, 7),
(4, "ovino", "ovino sinpelo", "H", 93, "2006-12-04", null, null, null, 2),
(5, "bovino", "bovino shiny", "M", 65, "2008-04-28", null, null, null, 4),
(6, "bovino", "bovino sinpelo", "M", 59, "2010-10-11", null, null, null, 6),
(7, "caprino", "caprino shiny", "H", 21, "2006-04-20", null, null, null, 4),
(8, "caprino", "caprino comun", "M", 45, "2012-08-05", null, null, null, 6),
(9, "porcino", "porcino shiny", "M", 61, "2014-07-06", null, null, null, 5),
(10, "ovino", "ovino albino", "H", 24, "2014-05-26", null, null, null, 4),
(11, "caprino", "caprino shiny", "M", 36, "2006-08-14", null, null, null, 5),
(12, "porcino", "porcino mini", "H", 101, "2011-11-16", null, null, null, 7),
(13, "bovino", "bovino comun", "M", 117, "2009-07-11", null, null, null, 5),
(14, "bovino", "bovino mini", "M", 33, "2013-10-22", null, null, null, 5),
(15, "ovino", "ovino sinpelo", "M", 21, "2010-01-01", null, null, null, 1),
(16, "porcino", "porcino enorme", "H", 68, "2006-02-05", null, null, null, 6),
(17, "ovino", "ovino sinpelo", "H", 61, "2014-03-11", null, null, null, 4),
(18, "ovino", "ovino comun", "H", 29, "2014-08-14", null, null, null, 2),
(19, "ovino", "ovino mini", "H", 78, "2010-02-17", null, null, null, 2),
(20, "porcino", "porcino enorme", "H", 103, "2007-05-18", null, null, null, 3),
(21, "ovino", "ovino comun", "H", 100, "2014-11-28", null, null, null, 5),
(22, "caprino", "caprino sinpelo", "H", 83, "2014-07-01", null, null, null, 6),
(23, "porcino", "porcino enorme", "M", 85, "2012-02-16", null, null, null, 5),
(24, "bovino", "bovino shiny", "M", 116, "2009-07-23", null, null, null, 1),
(25, "ovino", "ovino sinpelo", "M", 81, "2010-05-25", null, null, null, 6),
(26, "caprino", "caprino sinpelo", "H", 101, "2012-02-24", null, null, null, 3),
(27, "caprino", "caprino albino", "M", 77, "2007-11-28", null, null, null, 7),
(28, "caprino", "caprino mini", "H", 96, "2014-10-04", null, null, null, 4),
(29, "ovino", "ovino mini", "H", 74, "2006-12-21", null, null, null, 4),
(30, "ovino", "ovino comun", "H", 71, "2008-05-24", null, null, null, 3),
(31, "caprino", "caprino enorme", "H", 37, "2012-03-06", null, null, null, 4),
(32, "caprino", "caprino albino", "H", 69, "2012-06-18", null, null, null, 6),
(33, "caprino", "caprino shiny", "H", 80, "2007-11-16", null, null, null, 4),
(34, "ovino", "ovino comun", "H", 24, "2010-12-24", null, null, null, 2),
(35, "ovino", "ovino shiny", "H", 21, "2011-05-01", null, null, null, 4),
(36, "porcino", "porcino enorme", "H", 73, "2012-05-18", null, null, null, 6),
(37, "caprino", "caprino shiny", "H", 71, "2008-09-05", null, null, null, 6),
(38, "caprino", "caprino shiny", "H", 30, "2014-10-09", null, null, null, 3),
(39, "bovino", "bovino mini", "M", 102, "2006-08-15", null, null, null, 5),
(40, "porcino", "porcino shiny", "M", 60, "2008-09-12", null, null, null, 7),
(41, "bovino", "bovino sinpelo", "H", 42, "2007-07-05", null, null, null, 2),
(42, "bovino", "bovino mini", "H", 108, "2010-04-04", null, null, null, 3),
(43, "caprino", "caprino comun", "M", 47, "2014-05-02", null, null, null, 5),
(44, "caprino", "caprino shiny", "M", 29, "2010-09-08", null, null, null, 6),
(45, "porcino", "porcino albino", "H", 103, "2012-10-28", null, null, null, 2),
(46, "bovino", "bovino sinpelo", "M", 72, "2007-02-22", null, null, null, 1),
(47, "caprino", "caprino sinpelo", "H", 108, "2007-06-12", null, null, null, 2),
(48, "bovino", "bovino enorme", "M", 73, "2008-07-22", null, null, null, 6),
(49, "bovino", "bovino albino", "M", 80, "2006-08-04", null, null, null, 6),
(50, "bovino", "bovino shiny", "H", 93, "2005-01-25", null, null, null, 3),
(51, "caprino", "caprino shiny", "M", 47, "2007-07-09", null, null, null, 3),
(52, "porcino", "porcino comun", "H", 64, "2010-04-11", null, null, null, 7),
(53, "ovino", "ovino enorme", "H", 59, "2010-10-26", null, null, null, 4),
(54, "caprino", "caprino albino", "M", 90, "2010-12-17", null, null, null, 1),
(55, "bovino", "bovino enorme", "H", 86, "2008-10-03", null, null, null, 2),
(56, "porcino", "porcino comun", "M", 50, "2010-05-01", null, null, null, 6),
(57, "porcino", "porcino sinpelo", "M", 38, "2005-03-06", null, null, null, 6),
(58, "bovino", "bovino albino", "H", 49, "2014-10-21", null, null, null, 7),
(59, "ovino", "ovino mini", "H", 72, "2012-12-19", null, null, null, 4),
(60, "porcino", "porcino mini", "M", 86, "2009-11-12", null, null, null, 7),
(61, "bovino", "bovino shiny", "M", 115, "2005-04-14", null, null, null, 4),
(62, "porcino", "porcino mini", "M", 60, "2005-09-24", null, null, null, 7),
(63, "porcino", "porcino albino", "H", 79, "2005-07-21", null, null, null, 1),
(64, "porcino", "porcino albino", "M", 89, "2007-07-28", null, null, null, 4),
(65, "ovino", "ovino mini", "M", 95, "2007-02-10", null, null, null, 3),
(66, "porcino", "porcino comun", "M", 83, "2011-01-15", null, null, null, 1),
(67, "porcino", "porcino albino", "H", 30, "2014-06-09", null, null, null, 7),
(68, "ovino", "ovino enorme", "M", 113, "2014-08-21", null, null, null, 5),
(69, "porcino", "porcino shiny", "H", 29, "2014-02-25", null, null, null, 2),
(70, "porcino", "porcino enorme", "H", 43, "2005-12-05", null, null, null, 2),
(71, "caprino", "caprino albino", "H", 41, "2011-05-09", null, null, null, 6),
(72, "ovino", "ovino sinpelo", "H", 55, "2014-05-20", null, null, null, 6),
(73, "ovino", "ovino albino", "H", 68, "2010-01-17", null, null, null, 1),
(74, "bovino", "bovino comun", "M", 39, "2005-03-26", null, null, null, 7),
(75, "porcino", "porcino sinpelo", "M", 95, "2007-04-18", null, null, null, 1),
(76, "ovino", "ovino enorme", "H", 79, "2010-07-08", null, null, null, 4),
(77, "bovino", "bovino shiny", "H", 51, "2014-11-16", null, null, null, 3),
(78, "bovino", "bovino comun", "H", 91, "2011-05-18", null, null, null, 3),
(79, "porcino", "porcino comun", "H", 41, "2005-03-10", null, null, null, 1),
(80, "porcino", "porcino comun", "H", 74, "2005-02-07", null, null, null, 4),
(81, "caprino", "caprino sinpelo", "M", 114, "2014-05-18", null, null, null, 3),
(82, "caprino", "caprino sinpelo", "H", 103, "2005-05-12", null, null, null, 1),
(83, "ovino", "ovino enorme", "H", 109, "2005-11-01", null, null, null, 6),
(84, "porcino", "porcino enorme", "M", 32, "2011-05-13", null, null, null, 6),
(85, "bovino", "bovino sinpelo", "H", 23, "2013-07-05", null, null, null, 3),
(86, "bovino", "bovino comun", "H", 51, "2012-12-08", null, null, null, 3),
(87, "ovino", "ovino enorme", "M", 66, "2010-07-19", null, null, null, 2),
(88, "ovino", "ovino mini", "M", 46, "2005-03-15", null, null, null, 2),
(89, "porcino", "porcino mini", "M", 36, "2010-07-21", null, null, null, 7),
(90, "caprino", "caprino comun", "H", 105, "2008-11-28", null, null, null, 7),
(91, "porcino", "porcino sinpelo", "H", 81, "2012-11-14", null, null, null, 5),
(92, "caprino", "caprino mini", "H", 43, "2013-09-25", null, null, null, 2),
(93, "porcino", "porcino comun", "M", 83, "2010-11-08", null, null, null, 2),
(94, "ovino", "ovino albino", "M", 64, "2013-09-06", null, null, null, 1),
(95, "bovino", "bovino sinpelo", "H", 25, "2012-03-08", null, null, null, 1),
(96, "caprino", "caprino sinpelo", "H", 37, "2012-12-01", null, null, null, 4),
(97, "bovino", "bovino enorme", "H", 82, "2012-08-13", null, null, null, 7),
(98, "caprino", "caprino enorme", "M", 23, "2008-09-26", null, null, null, 7),
(99, "ovino", "ovino shiny", "H", 94, "2012-02-20", null, null, null, 2),
(100, "ovino", "ovino albino", "M", 105, "2006-11-04", null, null, null, 7),
(101, "ovino", "ovino shiny", "M", 67, "2012-03-05", null, null, null, 6),
(102, "porcino", "porcino mini", "H", 68, "2010-12-03", null, null, null, 3),
(103, "porcino", "porcino enorme", "M", 52, "2013-12-03", null, null, null, 4),
(104, "caprino", "caprino mini", "H", 92, "2009-12-18", null, null, null, 3),
(105, "caprino", "caprino comun", "M", 52, "2005-11-14", null, null, null, 2),
(106, "ovino", "ovino sinpelo", "M", 86, "2013-01-15", null, null, null, 1),
(107, "caprino", "caprino sinpelo", "H", 108, "2005-12-14", null, null, null, 3),
(108, "caprino", "caprino enorme", "H", 38, "2009-04-15", null, null, null, 4),
(109, "bovino", "bovino comun", "H", 114, "2005-07-18", null, null, null, 5),
(110, "porcino", "porcino albino", "H", 108, "2011-03-03", null, null, null, 5),
(111, "ovino", "ovino sinpelo", "H", 108, "2007-08-19", null, null, null, 7),
(112, "bovino", "bovino comun", "M", 33, "2009-09-11", null, null, null, 2),
(113, "porcino", "porcino shiny", "M", 100, "2012-04-11", null, null, null, 3),
(114, "ovino", "ovino shiny", "M", 76, "2014-10-01", null, null, null, 4),
(115, "ovino", "ovino shiny", "H", 62, "2010-11-23", null, null, null, 1),
(116, "porcino", "porcino sinpelo", "H", 92, "2009-11-01", null, null, null, 4),
(117, "ovino", "ovino comun", "H", 66, "2006-07-19", null, null, null, 6),
(118, "ovino", "ovino albino", "M", 32, "2012-04-18", null, null, null, 4),
(119, "ovino", "ovino mini", "H", 85, "2009-01-03", null, null, null, 5),
(120, "caprino", "caprino comun", "M", 62, "2006-04-07", null, null, null, 6),
(121, "porcino", "porcino shiny", "M", 33, "2011-11-11", null, null, null, 7),
(122, "bovino", "bovino shiny", "H", 33, "2010-05-06", null, null, null, 3),
(123, "ovino", "ovino comun", "H", 76, "2005-10-16", null, null, null, 7),
(124, "caprino", "caprino albino", "M", 49, "2007-01-24", null, null, null, 2),
(125, "caprino", "caprino shiny", "H", 75, "2009-11-13", null, null, null, 5),
(126, "caprino", "caprino mini", "M", 95, "2007-04-05", null, null, null, 3),
(127, "porcino", "porcino comun", "H", 109, "2010-04-17", null, null, null, 4),
(128, "bovino", "bovino shiny", "H", 68, "2010-07-26", null, null, null, 2),
(129, "caprino", "caprino albino", "M", 23, "2014-10-05", null, null, null, 1),
(130, "porcino", "porcino sinpelo", "H", 56, "2012-11-10", null, null, null, 1),
(131, "bovino", "bovino shiny", "H", 58, "2012-12-05", null, null, null, 2),
(132, "porcino", "porcino mini", "H", 27, "2012-08-10", null, null, null, 4),
(133, "caprino", "caprino shiny", "H", 104, "2013-09-24", null, null, null, 7),
(134, "caprino", "caprino mini", "H", 67, "2012-09-26", null, null, null, 5),
(135, "bovino", "bovino sinpelo", "H", 42, "2009-08-16", null, null, null, 5),
(136, "caprino", "caprino albino", "H", 25, "2008-09-17", null, null, null, 3),
(137, "caprino", "caprino sinpelo", "M", 100, "2006-02-17", null, null, null, 7),
(138, "porcino", "porcino albino", "M", 108, "2011-10-26", null, null, null, 7),
(139, "bovino", "bovino enorme", "H", 101, "2011-03-14", null, null, null, 5),
(140, "bovino", "bovino comun", "H", 83, "2010-09-21", null, null, null, 4),
(141, "porcino", "porcino sinpelo", "H", 31, "2008-03-12", null, null, null, 5),
(142, "porcino", "porcino comun", "H", 30, "2005-06-21", null, null, null, 5),
(143, "ovino", "ovino comun", "H", 88, "2008-06-04", null, null, null, 4),
(144, "ovino", "ovino enorme", "M", 98, "2005-05-22", null, null, null, 3),
(145, "bovino", "bovino enorme", "M", 64, "2008-12-17", null, null, null, 3),
(146, "porcino", "porcino shiny", "M", 119, "2006-05-09", null, null, null, 5),
(147, "caprino", "caprino sinpelo", "H", 94, "2008-08-18", null, null, null, 1),
(148, "porcino", "porcino sinpelo", "H", 118, "2008-06-28", null, null, null, 7),
(149, "ovino", "ovino shiny", "H", 49, "2009-02-05", null, null, null, 1),
(150, "ovino", "ovino mini", "M", 86, "2006-09-24", null, null, null, 7),
(151, "porcino", "porcino mini", "H", 94, "2009-04-28", null, null, null, 1),
(152, "bovino", "bovino albino", "M", 47, "2011-03-27", null, null, null, 1),
(153, "caprino", "caprino comun", "M", 80, "2011-09-24", null, null, null, 5),
(154, "ovino", "ovino albino", "H", 86, "2013-07-21", null, null, null, 2),
(155, "caprino", "caprino sinpelo", "H", 118, "2013-01-20", null, null, null, 5),
(156, "caprino", "caprino shiny", "M", 75, "2008-11-12", null, null, null, 7),
(157, "ovino", "ovino albino", "H", 75, "2005-06-04", null, null, null, 2),
(158, "ovino", "ovino enorme", "M", 56, "2010-03-18", null, null, null, 5),
(159, "ovino", "ovino comun", "H", 52, "2014-01-08", null, null, null, 5),
(160, "porcino", "porcino shiny", "H", 28, "2012-05-17", null, null, null, 4),
(161, "porcino", "porcino mini", "M", 89, "2011-10-17", null, null, null, 1),
(162, "caprino", "caprino enorme", "M", 82, "2011-12-25", null, null, null, 4),
(163, "bovino", "bovino comun", "H", 53, "2013-06-14", null, null, null, 5),
(164, "porcino", "porcino comun", "H", 48, "2010-04-20", null, null, null, 4),
(165, "porcino", "porcino mini", "M", 47, "2013-10-14", null, null, null, 3),
(166, "caprino", "caprino albino", "M", 88, "2009-03-09", null, null, null, 6),
(167, "bovino", "bovino shiny", "M", 104, "2013-12-07", null, null, null, 1),
(168, "caprino", "caprino comun", "M", 96, "2012-05-20", null, null, null, 6),
(169, "ovino", "ovino mini", "H", 105, "2014-09-14", null, null, null, 7),
(170, "ovino", "ovino shiny", "H", 53, "2014-10-24", null, null, null, 7),
(171, "caprino", "caprino comun", "M", 80, "2006-11-11", null, null, null, 1),
(172, "ovino", "ovino albino", "H", 81, "2012-01-11", null, null, null, 7),
(173, "bovino", "bovino albino", "H", 32, "2005-10-28", null, null, null, 3),
(174, "porcino", "porcino sinpelo", "M", 53, "2008-03-27", null, null, null, 4),
(175, "ovino", "ovino mini", "M", 47, "2010-06-03", null, null, null, 6),
(176, "ovino", "ovino shiny", "H", 111, "2006-01-19", null, null, null, 2),
(177, "porcino", "porcino enorme", "M", 22, "2008-05-07", null, null, null, 5),
(178, "caprino", "caprino albino", "M", 25, "2011-06-22", null, null, null, 3),
(179, "ovino", "ovino enorme", "H", 84, "2007-05-04", null, null, null, 6),
(180, "ovino", "ovino comun", "H", 73, "2008-07-28", null, null, null, 4),
(181, "caprino", "caprino sinpelo", "H", 26, "2005-12-01", null, null, null, 4),
(182, "caprino", "caprino mini", "H", 57, "2013-06-01", null, null, null, 1),
(183, "ovino", "ovino enorme", "H", 30, "2011-04-21", null, null, null, 2),
(184, "ovino", "ovino enorme", "H", 37, "2014-07-05", null, null, null, 2),
(185, "caprino", "caprino shiny", "H", 114, "2011-10-15", null, null, null, 3),
(186, "bovino", "bovino shiny", "M", 107, "2011-07-20", null, null, null, 4),
(187, "caprino", "caprino comun", "H", 57, "2012-02-15", null, null, null, 2),
(188, "porcino", "porcino albino", "M", 82, "2005-06-13", null, null, null, 6),
(189, "caprino", "caprino albino", "H", 57, "2014-01-08", null, null, null, 6),
(190, "bovino", "bovino mini", "H", 38, "2009-10-10", null, null, null, 2),
(191, "caprino", "caprino comun", "H", 64, "2014-11-17", null, null, null, 3),
(192, "porcino", "porcino shiny", "H", 50, "2012-08-22", null, null, null, 4),
(193, "bovino", "bovino enorme", "H", 40, "2014-02-18", null, null, null, 7),
(194, "bovino", "bovino enorme", "H", 90, "2009-02-10", null, null, null, 5),
(195, "ovino", "ovino shiny", "H", 103, "2012-06-07", null, null, null, 2),
(196, "caprino", "caprino sinpelo", "M", 25, "2010-09-06", null, null, null, 3),
(197, "bovino", "bovino enorme", "M", 93, "2005-06-12", null, null, null, 3),
(198, "ovino", "ovino comun", "M", 68, "2005-07-20", null, null, null, 3),
(199, "caprino", "caprino sinpelo", "M", 21, "2013-07-11", null, null, null, 5),
(200, "bovino", "bovino mini", "M", 36, "2007-08-23", null, null, null, 5)
;

INSERT INTO RES
(num_control, especie, raza, sexo, peso, f_nacimiento, res_madre, res_padre, granja_nacimiento, granja_actual)
VALUES
(201, "porcino", "porcino enorme", "H", 37, "2017-05-19", 40, 60, 7, 7),
(202, "ovino", "ovino shiny", "M", 97, "2016-01-08", 118, 118, 4, 7),
(203, "bovino", "bovino comun", "M", 79, "2017-01-26", 39, 13, 5, 5),
(204, "ovino", "ovino albino", "M", 108, "2016-01-07", 157, 34, 2, 7),
(205, "ovino", "ovino shiny", "H", 69, "2016-06-22", 29, 10, 4, 1),
(206, "porcino", "porcino comun", "H", 44, "2017-10-03", 121, 40, 7, 5),
(207, "caprino", "caprino albino", "H", 99, "2017-12-19", 81, 178, 3, 1),
(208, "porcino", "porcino albino", "H", 25, "2017-02-20", 138, 89, 7, 4),
(209, "porcino", "porcino enorme", "M", 48, "2020-07-07", 127, 192, 4, 4),
(210, "ovino", "ovino albino", "H", 89, "2020-06-11", 123, 170, 7, 3),
(211, "porcino", "porcino albino", "M", 39, "2016-05-26", 148, 3, 7, 6),
(212, "ovino", "ovino albino", "M", 46, "2020-10-06", 183, 18, 2, 4),
(213, "bovino", "bovino albino", "M", 74, "2019-06-20", 128, 131, 2, 6),
(214, "bovino", "bovino shiny", "H", 48, "2016-07-06", 41, 128, 2, 7),
(215, "caprino", "caprino enorme", "M", 94, "2019-08-05", 28, 7, 4, 2),
(216, "ovino", "ovino enorme", "H", 76, "2016-03-19", 114, 114, 4, 7),
(217, "porcino", "porcino shiny", "H", 98, "2017-12-10", 138, 62, 7, 7),
(218, "ovino", "ovino enorme", "M", 33, "2015-02-08", 172, 172, 7, 2),
(219, "ovino", "ovino albino", "M", 27, "2019-01-02", 34, 195, 2, 3),
(220, "bovino", "bovino comun", "M", 48, "2016-09-01", 55, 41, 2, 2),
(221, "ovino", "ovino albino", "H", 58, "2020-11-02", 195, 34, 2, 3),
(222, "bovino", "bovino enorme", "M", 105, "2016-08-13", 39, 13, 5, 6),
(223, "ovino", "ovino mini", "H", 86, "2018-10-28", 172, 169, 7, 5),
(224, "bovino", "bovino albino", "M", 94, "2017-08-24", 42, 122, 3, 7),
(225, "ovino", "ovino albino", "H", 40, "2018-08-16", 4, 184, 2, 7),
(226, "caprino", "caprino albino", "M", 71, "2021-05-12", 96, 31, 4, 5),
(227, "porcino", "porcino sinpelo", "M", 45, "2016-06-10", 12, 52, 7, 2),
(228, "ovino", "ovino shiny", "M", 71, "2019-02-14", 29, 35, 4, 1),
(229, "bovino", "bovino sinpelo", "M", 20, "2015-01-24", 61, 186, 4, 1),
(230, "porcino", "porcino enorme", "H", 96, "2018-02-13", 70, 69, 2, 3),
(231, "bovino", "bovino comun", "M", 78, "2017-04-01", 145, 145, 3, 7),
(232, "ovino", "ovino albino", "H", 80, "2021-08-04", 154, 157, 2, 1),
(233, "caprino", "caprino mini", "M", 73, "2017-08-02", 196, 178, 3, 3),
(234, "caprino", "caprino albino", "H", 101, "2016-09-12", 108, 108, 4, 6),
(235, "porcino", "porcino shiny", "H", 100, "2021-10-12", 91, 142, 5, 1),
(236, "caprino", "caprino mini", "M", 99, "2015-10-09", 168, 44, 6, 1),
(237, "porcino", "porcino sinpelo", "H", 63, "2019-02-06", 192, 80, 4, 1),
(238, "ovino", "ovino albino", "M", 110, "2021-12-01", 119, 21, 5, 7),
(239, "ovino", "ovino comun", "H", 31, "2019-11-27", 157, 4, 2, 1),
(240, "ovino", "ovino mini", "H", 119, "2021-08-25", 99, 195, 2, 4),
(241, "porcino", "porcino albino", "H", 112, "2019-11-21", 1, 84, 6, 3),
(242, "caprino", "caprino sinpelo", "M", 62, "2021-04-24", 44, 166, 6, 4),
(243, "bovino", "bovino enorme", "H", 70, "2018-09-17", 42, 42, 3, 6),
(244, "bovino", "bovino mini", "H", 52, "2016-09-24", 48, 6, 6, 6),
(245, "bovino", "bovino albino", "H", 81, "2018-01-28", 13, 39, 5, 7),
(246, "ovino", "ovino shiny", "H", 102, "2017-06-13", 34, 154, 2, 1),
(247, "porcino", "porcino comun", "M", 54, "2015-08-07", 40, 121, 7, 1),
(248, "porcino", "porcino albino", "M", 27, "2019-09-18", 148, 3, 7, 1),
(249, "bovino", "bovino mini", "H", 36, "2015-09-13", 122, 122, 3, 7),
(250, "caprino", "caprino sinpelo", "H", 76, "2016-12-14", 155, 155, 5, 2),
(251, "caprino", "caprino albino", "M", 27, "2019-10-13", 178, 178, 3, 2),
(252, "caprino", "caprino sinpelo", "M", 97, "2016-07-06", 28, 181, 4, 5),
(253, "porcino", "porcino comun", "M", 90, "2019-09-21", 16, 16, 6, 7),
(254, "ovino", "ovino shiny", "M", 104, "2016-07-07", 180, 35, 4, 7),
(255, "porcino", "porcino albino", "M", 116, "2021-01-18", 63, 79, 1, 4),
(256, "caprino", "caprino comun", "H", 113, "2017-11-05", 108, 108, 4, 5),
(257, "caprino", "caprino enorme", "M", 98, "2020-06-27", 22, 189, 6, 3),
(258, "caprino", "caprino mini", "M", 110, "2016-01-12", 51, 51, 3, 3),
(259, "ovino", "ovino albino", "M", 77, "2017-07-25", 184, 4, 2, 4),
(260, "caprino", "caprino sinpelo", "H", 108, "2019-07-23", 22, 37, 6, 4),
(261, "ovino", "ovino mini", "M", 90, "2017-07-26", 83, 117, 6, 1),
(262, "bovino", "bovino sinpelo", "H", 108, "2021-09-13", 50, 85, 3, 5),
(263, "bovino", "bovino enorme", "M", 94, "2017-10-07", 173, 122, 3, 6),
(264, "bovino", "bovino enorme", "H", 29, "2015-10-15", 5, 61, 4, 3),
(265, "ovino", "ovino comun", "M", 88, "2021-10-10", 175, 101, 6, 5),
(266, "bovino", "bovino albino", "H", 105, "2018-02-25", 109, 194, 5, 4),
(267, "ovino", "ovino shiny", "H", 76, "2020-12-20", 25, 101, 6, 2),
(268, "ovino", "ovino mini", "M", 81, "2015-02-15", 73, 149, 1, 6),
(269, "porcino", "porcino shiny", "M", 116, "2021-06-05", 89, 89, 7, 7),
(270, "porcino", "porcino albino", "H", 97, "2021-02-21", 16, 36, 6, 5),
(271, "caprino", "caprino comun", "H", 88, "2015-01-21", 7, 96, 4, 1),
(272, "porcino", "porcino albino", "H", 87, "2015-11-04", 66, 161, 1, 1),
(273, "caprino", "caprino enorme", "H", 36, "2018-03-07", 134, 155, 5, 3),
(274, "porcino", "porcino shiny", "H", 37, "2018-05-21", 57, 188, 6, 6),
(275, "porcino", "porcino sinpelo", "M", 95, "2019-06-21", 146, 9, 5, 7),
(276, "porcino", "porcino albino", "M", 29, "2019-07-08", 52, 3, 7, 4),
(277, "ovino", "ovino comun", "M", 91, "2016-07-24", 76, 10, 4, 7),
(278, "bovino", "bovino albino", "M", 91, "2015-06-13", 78, 85, 3, 2),
(279, "caprino", "caprino albino", "M", 37, "2021-09-05", 22, 32, 6, 5),
(280, "porcino", "porcino sinpelo", "M", 100, "2016-07-21", 161, 161, 1, 7),
(281, "porcino", "porcino shiny", "H", 32, "2018-08-13", 132, 127, 4, 1),
(282, "ovino", "ovino albino", "M", 110, "2015-06-07", 18, 19, 2, 4),
(283, "porcino", "porcino albino", "H", 95, "2017-10-01", 103, 64, 4, 6),
(284, "bovino", "bovino albino", "M", 95, "2019-11-13", 42, 86, 3, 4),
(285, "caprino", "caprino albino", "H", 32, "2021-01-24", 7, 108, 4, 5),
(286, "ovino", "ovino mini", "H", 90, "2021-04-18", 170, 172, 7, 1),
(287, "ovino", "ovino shiny", "H", 29, "2020-01-16", 17, 29, 4, 3),
(288, "porcino", "porcino shiny", "H", 113, "2017-02-10", 93, 93, 2, 5),
(289, "bovino", "bovino enorme", "H", 104, "2018-06-14", 200, 200, 5, 6),
(290, "ovino", "ovino enorme", "H", 114, "2019-06-14", 159, 119, 5, 2),
(291, "bovino", "bovino comun", "H", 116, "2018-04-14", 97, 58, 7, 7),
(292, "porcino", "porcino sinpelo", "H", 58, "2018-11-20", 121, 40, 7, 7),
(293, "bovino", "bovino shiny", "H", 110, "2017-05-04", 24, 24, 1, 4),
(294, "caprino", "caprino mini", "H", 75, "2017-04-21", 191, 104, 3, 6),
(295, "ovino", "ovino sinpelo", "H", 57, "2020-09-01", 53, 29, 4, 6),
(296, "ovino", "ovino albino", "M", 40, "2020-03-24", 59, 180, 4, 7),
(297, "caprino", "caprino enorme", "H", 42, "2016-08-27", 81, 196, 3, 1),
(298, "bovino", "bovino albino", "H", 34, "2021-11-15", 135, 135, 5, 6),
(299, "caprino", "caprino albino", "H", 94, "2016-10-12", 181, 96, 4, 3),
(300, "ovino", "ovino comun", "M", 41, "2018-02-17", 34, 157, 2, 6),
(301, "porcino", "porcino sinpelo", "M", 33, "2015-09-28", 56, 84, 6, 2),
(302, "caprino", "caprino enorme", "M", 25, "2017-10-17", 189, 189, 6, 7),
(303, "caprino", "caprino enorme", "H", 77, "2019-06-13", 166, 166, 6, 6),
(304, "caprino", "caprino albino", "M", 80, "2016-11-11", 104, 191, 3, 6),
(305, "ovino", "ovino enorme", "H", 109, "2018-10-15", 19, 157, 2, 4),
(306, "ovino", "ovino mini", "M", 72, "2016-08-27", 154, 99, 2, 3),
(307, "porcino", "porcino enorme", "M", 99, "2018-07-13", 121, 89, 7, 2),
(308, "ovino", "ovino comun", "H", 21, "2021-08-12", 18, 176, 2, 7),
(309, "ovino", "ovino albino", "H", 20, "2018-03-22", 183, 176, 2, 4),
(310, "ovino", "ovino shiny", "M", 106, "2017-03-03", 184, 157, 2, 1),
(311, "caprino", "caprino enorme", "H", 46, "2021-03-25", 126, 126, 3, 1),
(312, "ovino", "ovino mini", "H", 118, "2021-01-28", 180, 53, 4, 7),
(313, "ovino", "ovino comun", "M", 54, "2017-04-20", 184, 195, 2, 6),
(314, "porcino", "porcino enorme", "M", 65, "2015-08-12", 192, 160, 4, 2),
(315, "ovino", "ovino mini", "M", 103, "2016-01-17", 143, 59, 4, 1),
(316, "ovino", "ovino shiny", "M", 77, "2021-01-18", 18, 184, 2, 1),
(317, "bovino", "bovino mini", "H", 23, "2019-03-17", 193, 97, 7, 3),
(318, "ovino", "ovino albino", "H", 60, "2015-07-12", 53, 59, 4, 3),
(319, "porcino", "porcino sinpelo", "H", 83, "2018-07-04", 3, 67, 7, 6),
(320, "caprino", "caprino shiny", "H", 53, "2017-02-19", 136, 107, 3, 2),
(321, "caprino", "caprino sinpelo", "M", 52, "2016-03-06", 136, 191, 3, 4),
(322, "ovino", "ovino shiny", "M", 27, "2019-07-22", 4, 154, 2, 7),
(323, "bovino", "bovino albino", "H", 56, "2019-09-22", 50, 42, 3, 6),
(324, "porcino", "porcino albino", "H", 53, "2017-03-09", 40, 138, 7, 5),
(325, "bovino", "bovino mini", "M", 119, "2021-12-14", 48, 48, 6, 5),
(326, "bovino", "bovino enorme", "M", 98, "2020-09-17", 48, 49, 6, 7),
(327, "porcino", "porcino albino", "H", 106, "2020-10-05", 1, 57, 6, 4),
(328, "bovino", "bovino comun", "M", 36, "2017-09-25", 173, 86, 3, 1),
(329, "ovino", "ovino comun", "M", 100, "2017-09-14", 183, 19, 2, 5),
(330, "ovino", "ovino sinpelo", "H", 45, "2019-06-26", 73, 149, 1, 6),
(331, "caprino", "caprino shiny", "H", 42, "2017-05-07", 81, 178, 3, 1),
(332, "ovino", "ovino shiny", "H", 79, "2016-08-27", 35, 29, 4, 7),
(333, "porcino", "porcino shiny", "M", 55, "2021-06-01", 56, 1, 6, 2),
(334, "caprino", "caprino shiny", "M", 114, "2019-03-23", 196, 178, 3, 7),
(335, "porcino", "porcino albino", "H", 25, "2017-01-19", 130, 63, 1, 5),
(336, "bovino", "bovino albino", "M", 35, "2018-02-03", 173, 42, 3, 3),
(337, "porcino", "porcino shiny", "M", 113, "2015-11-16", 121, 40, 7, 2),
(338, "caprino", "caprino mini", "H", 68, "2015-11-16", 147, 82, 1, 7),
(339, "porcino", "porcino shiny", "H", 107, "2019-06-10", 132, 192, 4, 3),
(340, "ovino", "ovino shiny", "M", 106, "2020-05-17", 101, 101, 6, 4),
(341, "bovino", "bovino shiny", "H", 117, "2019-09-01", 131, 131, 2, 1),
(342, "ovino", "ovino comun", "H", 114, "2019-01-28", 143, 53, 4, 5),
(343, "ovino", "ovino mini", "H", 30, "2015-03-08", 154, 19, 2, 1),
(344, "ovino", "ovino albino", "H", 56, "2020-03-06", 17, 17, 4, 1),
(345, "caprino", "caprino comun", "H", 46, "2015-10-27", 147, 147, 1, 5),
(346, "ovino", "ovino enorme", "M", 115, "2021-11-28", 59, 76, 4, 7),
(347, "caprino", "caprino sinpelo", "M", 103, "2020-10-04", 92, 187, 2, 6),
(348, "caprino", "caprino comun", "M", 99, "2016-05-01", 82, 182, 1, 7),
(349, "ovino", "ovino enorme", "H", 50, "2015-09-11", 83, 83, 6, 5),
(350, "caprino", "caprino mini", "M", 60, "2021-03-11", 185, 136, 3, 7),
(351, "porcino", "porcino shiny", "H", 55, "2018-08-26", 116, 116, 4, 7),
(352, "bovino", "bovino comun", "M", 26, "2021-10-07", 50, 78, 3, 6),
(353, "caprino", "caprino sinpelo", "H", 111, "2020-12-07", 125, 155, 5, 5),
(354, "caprino", "caprino comun", "H", 25, "2021-04-09", 196, 81, 3, 3),
(355, "porcino", "porcino enorme", "M", 102, "2017-10-15", 62, 121, 7, 6),
(356, "porcino", "porcino albino", "M", 40, "2016-11-21", 89, 121, 7, 3),
(357, "ovino", "ovino albino", "H", 35, "2015-11-22", 99, 157, 2, 6),
(358, "porcino", "porcino comun", "H", 91, "2016-01-13", 174, 64, 4, 6),
(359, "porcino", "porcino albino", "H", 109, "2016-05-26", 80, 127, 4, 1),
(360, "porcino", "porcino enorme", "H", 72, "2017-05-03", 84, 84, 6, 3),
(361, "porcino", "porcino sinpelo", "H", 48, "2016-09-22", 3, 52, 7, 2),
(362, "ovino", "ovino sinpelo", "M", 93, "2019-05-07", 65, 144, 3, 7),
(363, "bovino", "bovino enorme", "H", 36, "2020-03-01", 109, 139, 5, 3),
(364, "bovino", "bovino sinpelo", "M", 94, "2018-06-11", 163, 109, 5, 4),
(365, "porcino", "porcino mini", "M", 79, "2020-12-01", 66, 75, 1, 5),
(366, "caprino", "caprino shiny", "M", 70, "2019-09-12", 71, 71, 6, 4),
(367, "bovino", "bovino mini", "H", 118, "2018-12-17", 85, 86, 3, 3),
(368, "porcino", "porcino comun", "H", 25, "2016-03-01", 56, 56, 6, 5),
(369, "caprino", "caprino shiny", "M", 64, "2017-12-19", 108, 7, 4, 7),
(370, "caprino", "caprino albino", "H", 57, "2015-09-23", 11, 43, 5, 3),
(371, "caprino", "caprino shiny", "H", 108, "2019-10-21", 32, 22, 6, 2),
(372, "porcino", "porcino shiny", "M", 97, "2017-09-05", 57, 1, 6, 6),
(373, "caprino", "caprino mini", "M", 35, "2016-01-23", 33, 96, 4, 2),
(374, "ovino", "ovino albino", "H", 81, "2021-06-24", 157, 183, 2, 1),
(375, "caprino", "caprino comun", "M", 91, "2018-08-04", 134, 155, 5, 4),
(376, "bovino", "bovino comun", "H", 60, "2015-10-23", 173, 122, 3, 5),
(377, "caprino", "caprino comun", "M", 41, "2019-08-08", 199, 43, 5, 4),
(378, "bovino", "bovino albino", "M", 56, "2018-02-09", 13, 14, 5, 3),
(379, "caprino", "caprino enorme", "H", 50, "2017-05-16", 196, 178, 3, 4),
(380, "ovino", "ovino shiny", "M", 46, "2017-09-23", 4, 176, 2, 1),
(381, "porcino", "porcino mini", "H", 101, "2018-03-22", 9, 9, 5, 1),
(382, "caprino", "caprino albino", "M", 117, "2015-12-22", 189, 32, 6, 1),
(383, "caprino", "caprino mini", "M", 37, "2021-04-28", 26, 38, 3, 7),
(384, "ovino", "ovino albino", "H", 81, "2020-12-18", 157, 176, 2, 3),
(385, "porcino", "porcino sinpelo", "M", 67, "2021-09-20", 89, 138, 7, 7),
(386, "caprino", "caprino sinpelo", "H", 84, "2018-12-12", 8, 44, 6, 6),
(387, "porcino", "porcino comun", "M", 20, "2021-11-06", 1, 1, 6, 2),
(388, "ovino", "ovino mini", "M", 66, "2019-07-09", 53, 76, 4, 7),
(389, "porcino", "porcino sinpelo", "H", 108, "2016-11-06", 1, 56, 6, 7),
(390, "porcino", "porcino mini", "H", 105, "2021-10-04", 130, 2, 1, 2),
(391, "ovino", "ovino sinpelo", "M", 21, "2018-07-25", 4, 99, 2, 6),
(392, "ovino", "ovino shiny", "H", 22, "2017-03-02", 17, 59, 4, 7),
(393, "ovino", "ovino albino", "H", 55, "2021-11-09", 35, 76, 4, 5),
(394, "ovino", "ovino sinpelo", "M", 32, "2021-07-04", 176, 184, 2, 6),
(395, "ovino", "ovino mini", "M", 119, "2017-01-27", 115, 115, 1, 6),
(396, "porcino", "porcino sinpelo", "H", 42, "2018-10-10", 3, 3, 7, 7),
(397, "caprino", "caprino mini", "M", 107, "2018-08-20", 96, 7, 4, 5),
(398, "ovino", "ovino shiny", "M", 54, "2020-02-18", 183, 184, 2, 6),
(399, "porcino", "porcino albino", "M", 23, "2020-11-28", 60, 60, 7, 4),
(400, "ovino", "ovino shiny", "H", 97, "2017-06-18", 88, 88, 2, 2)
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