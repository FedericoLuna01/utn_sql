# Ejercicio 6:
# Calcular el numero total de libros  que hay en la BBDD y la cantidad de autores distintos.
SELECT 
	COUNT(id) AS total_libros, 
	COUNT(DISTINCT libros.autor_id) AS total_autores 
    FROM libros;

# Ejercicio 7:
# Actualizar el estado de los usuarios a SUSPENDIDO en el caso de de que tengan mas de 5 prestamos.
UPDATE usuario
SET estado_cliente = 'SUSPENDIDO'
WHERE (
    SELECT COUNT(*)
    FROM prestamos
    WHERE id_usuario = usuario_id
) > 5;

# Ejercicio 8:
# Obtener la cantidad de alumnos por curso
# Usar un JOIN entre Inscripciones y Cursos 
# para contar cuántos alumnos hay en cada curso.
SELECT cursos.nombre, COUNT(inscripciones.alumno_id) AS cant_alumnos
FROM cursos
INNER JOIN inscripciones ON cursos.id = inscripciones.curso_id
GROUP BY cursos.nombre;

# Ejercicio 9:
# Listar cursos que se dictan en aulas con capacidad mayor a 30 alumnos
# y que hayan empezado después de 2023
# Usar un JOIN entre Cursos, Horarios y Aulas y agregar una
# cláusula WHERE para la capacidad y la fecha.
SELECT DISTINCT cursos.nombre FROM cursos
INNER JOIN horarios ON cursos.id = horarios.curso_id
INNER JOIN aulas ON aulas.id = horarios.aula_id
INNER JOIN inscripciones ON cursos.id = inscripciones.curso_id
WHERE aulas.capacidad > 30
AND YEAR(inscripciones.fecha_inscripcion) > 2023;

# Ejercicio 10:
# Obtener el promedio de calificaciones por curso
# Usar funciones de agregación para calcular el promedio
# de calificaciones de cada curso.
SELECT cursos.nombre, AVG(calificaciones.nota) AS promedio FROM cursos
INNER JOIN evaluaciones ON evaluaciones.curso_id = cursos.id
INNER JOIN calificaciones ON calificaciones.id = evaluaciones.id
GROUP BY cursos.nombre;

# Ejercicio 11:
# Listar los alumnos con calificaciones por encima del promedio en su curso
# Usar una subconsulta para calcular el promedio de calificaciones 
# en cada curso y luego filtrar a los estudiantes con calificaciones mayores a ese promedio.
SELECT nombre, AVG(calificaciones.nota) AS promedio FROM alumnos
INNER JOIN calificaciones ON alumnos.id = calificaciones.alumno_id
WHERE (SELECT ) > 3
GROUP BY calificaciones.alumno_id;


SELECT * FROM alumnos
INNER JOIN calificaciones ON alumnos.id = calificaciones.alumno_id; 

# Ejercicio 12:
# Obtener el número de alumnos inscritos por departamento de profesor
# Usar JOINs entre Cursos, Inscripciones, y Profesores 
# para obtener la cantidad de alumnos por departamento del profesor.
SELECT profesores.nombre, COUNT(profesores.id) AS cant_alumnos FROM cursos
INNER JOIN inscripciones ON inscripciones.curso_id = cursos.id 
INNER JOIN profesores ON profesores.id = cursos.profesor_id
GROUP BY profesores.id;

# Ejercicio 13:
# Listar los cursos que se dictan en un día específico y un rango de horas
# Usar un JOIN entre Cursos y Horarios, y filtrar por día de la semana y hora.
SELECT * FROM horarios
JOIN cursos ON horarios.curso_id = cursos.id
WHERE horarios.dia_semana = "Lunes"
AND horarios.hora_inicio > "10:00:00"
AND horarios.hora_fin < "20:00:00";

# Ejercicio 14:
# Listar alumnos que no se han inscrito en ningún curso
# Usar una subconsulta con NOT IN para listar los alumnos
# que no tienen registros en la tabla Inscripciones.
SELECT * FROM alumnos
WHERE alumnos.id NOT IN (
	SELECT alumno_id FROM inscripciones
);

# Ejercicio 15:
# Obtener el curso más largo en duración (fecha_fin - fecha_inicio)
# Usar una función para calcular la duración del curso y 
# ordenar para obtener el de mayor duración.


# Ejercicio 16:
# Obtener la lista de profesores que no tienen cursos asignados
# Usar un LEFT JOIN para encontrar los profesores que no están relacionados con ningún curso
SELECT * FROM profesores
LEFT JOIN cursos ON cursos.profesor_id = profesores.id
WHERE cursos.id IS NULL;

# Ejercicio 17:
# Listar los cursos con el mayor número de inscripciones y
# la calificación promedio más alta
# Combinar funciones de agregación (COUNT y AVG)
# y agrupar para obtener cursos ordenados por cantidad de inscripciones
# y calificación promedio.





