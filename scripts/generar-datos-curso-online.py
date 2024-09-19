from faker import Faker
from datetime import datetime, timedelta
import random

# Inicializar Faker
fake = Faker('es_ES')

# Función para escribir en archivos
def escribir_archivo(nombre_archivo, contenido):
    with open(nombre_archivo, 'w', encoding='utf-8') as f:
        f.write(contenido)

# Generar usuarios
def generar_usuarios(n):
    contenido = "INSERT INTO usuario (nombre, apellido, email, contrasenia, fecha_registro, rol) VALUES\n"
    for _ in range(n):
        nombre = fake.first_name()
        apellido = fake.last_name()
        email = fake.email()
        contrasenia = fake.password()
        fecha_registro = fake.date_between(start_date='-2y', end_date='today')
        rol = random.choice(['estudiante', 'instructor', 'administrador'])
        
        contenido += f"('{nombre}', '{apellido}', '{email}', '{contrasenia}', '{fecha_registro}', '{rol}'),\n"
    
    contenido = contenido.rstrip(',\n') + ';'
    escribir_archivo('insert_usuarios.sql', contenido)

# Generar cursos
def generar_cursos(n):
    contenido = "INSERT INTO curso (nombre, descripcion, fecha_creacion, id_instructor) VALUES\n"
    for _ in range(n):
        nombre = fake.catch_phrase()
        descripcion = fake.paragraph().replace("'", "''")
        fecha_creacion = fake.date_between(start_date='-1y', end_date='today')
        id_instructor = random.randint(1, 100)  # Asumiendo que hay 100 usuarios
        
        contenido += f"('{nombre}', '{descripcion}', '{fecha_creacion}', {id_instructor}),\n"
    
    contenido = contenido.rstrip(',\n') + ';'
    escribir_archivo('insert_cursos.sql', contenido)

# Generar lecciones
def generar_lecciones(n_cursos):
    contenido = "INSERT INTO leccion (titulo, contenido, orden, curso_id) VALUES\n"
    for curso_id in range(1, n_cursos + 1):
        num_lecciones = random.randint(5, 15)
        for orden in range(1, num_lecciones + 1):
            titulo = fake.sentence()
            contenido_leccion = fake.text().replace("'", "''")  # Cambiar el nombre de la variable
            
            contenido += f"('{titulo}', '{contenido_leccion}', {orden}, {curso_id}),\n"  # Usar contenido_leccion
    
    contenido = contenido.rstrip(',\n') + ';'
    escribir_archivo('insert_lecciones.sql', contenido)

# Generar inscripciones
def generar_inscripciones(n):
    contenido = "INSERT INTO inscripcion (fecha_inscripcion, estado, usuario_id, curso_id) VALUES\n"
    for _ in range(n):
        fecha_inscripcion = fake.date_between(start_date='-1y', end_date='today')
        estado = random.choice(['activo', 'completado', 'abandonado'])
        usuario_id = random.randint(1, 100)  # Asumiendo que hay 100 usuarios
        curso_id = random.randint(1, 20)  # Asumiendo que hay 20 cursos
        
        contenido += f"('{fecha_inscripcion}', '{estado}', {usuario_id}, {curso_id}),\n"
    
    contenido = contenido.rstrip(',\n') + ';'
    escribir_archivo('insert_inscripciones.sql', contenido)

# Generar evaluaciones y resultados
def generar_evaluaciones_y_resultados(n_cursos):
    contenido_eval = "INSERT INTO evaluacion (titulo, preguntas, fecha_creacion, curso_id) VALUES\n"
    contenido_res = "INSERT INTO resultado_evaluacion (nota, fecha_realizacion, evaluacion_id, usuario_id) VALUES\n"
    
    evaluacion_id = 1
    for curso_id in range(1, n_cursos + 1):
        num_evaluaciones = random.randint(1, 3)
        for _ in range(num_evaluaciones):
            titulo = fake.sentence()
            preguntas = fake.text().replace("'", "''")
            fecha_creacion = fake.date_between(start_date='-1y', end_date='today')
            
            contenido_eval += f"('{titulo}', '{preguntas}', '{fecha_creacion}', {curso_id}),\n"
            
            # Generar resultados para esta evaluación
            for _ in range(random.randint(5, 20)):  # Entre 5 y 20 resultados por evaluación
                nota = round(random.uniform(0, 10), 2)
                fecha_realizacion = fake.date_between(start_date=fecha_creacion, end_date='today')
                usuario_id = random.randint(1, 100)  # Asumiendo que hay 100 usuarios
                
                contenido_res += f"({nota}, '{fecha_realizacion}', {evaluacion_id}, {usuario_id}),\n"
            
            evaluacion_id += 1
    
    contenido_eval = contenido_eval.rstrip(',\n') + ';'
    contenido_res = contenido_res.rstrip(',\n') + ';'
    escribir_archivo('insert_evaluaciones.sql', contenido_eval)
    escribir_archivo('insert_resultados_evaluacion.sql', contenido_res)

# Ejecutar funciones para generar datos
generar_usuarios(100)
generar_cursos(20)
generar_lecciones(20)
generar_inscripciones(200)
generar_evaluaciones_y_resultados(20)

print("Archivos SQL generados exitosamente.")
