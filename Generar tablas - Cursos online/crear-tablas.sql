# CREATE DATABASE cursos_online;

USE cursos_online;

CREATE TABLE IF NOT EXISTS usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contrasenia VARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL,
    rol VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS curso (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATE NOT NULL,
    id_instructor INT NOT NULL,
    FOREIGN KEY (id_instructor) REFERENCES usuario(id)
);

CREATE TABLE IF NOT EXISTS leccion (
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    contenido TEXT,
    orden INT NOT NULL,
    curso_id INT NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

CREATE TABLE IF NOT EXISTS inscripcion (
	id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_inscripcion DATE NOT NULL,
    estado VARCHAR(50),
    usuario_id INT NOT NULL,
    curso_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

CREATE TABLE IF NOT EXISTS evaluacion (
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    preguntas TEXT,
    fecha_creacion DATE NOT NULL,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

CREATE TABLE IF NOT EXISTS resultado_evaluacion (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nota FLOAT NOT NULL,
    fecha_realizacion DATE NOT NULL,
    evaluacion_id INT NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (evaluacion_id) REFERENCES evaluacion(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);












