CREATE TABLE medicos (
    id SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    especialidad VARCHAR(80) NOT NULL,
    licencia_profesional VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(20),
    documento_identidad VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE citas (
    id SERIAL PRIMARY KEY,
    medico_id INT NOT NULL,
    paciente_id INT NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    motivo_consulta TEXT NOT NULL,
    estado VARCHAR(20) NOT NULL
        CHECK (estado IN ('pendiente','completada','cancelada')),

    FOREIGN KEY (medico_id)
        REFERENCES medicos(id),

    FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id)
);

-- Insertar médicos
INSERT INTO medicos (nombre_completo, especialidad, licencia_profesional) values
('Dra. Camila Ríos',    'Cardiología',  'LIC-001'),
  ('Dr. Andrés Mora',     'Pediatría',    'LIC-002'),
  ('Dra. Sofía Vargas',   'Dermatología', 'LIC-003');

-- Insertar pacientes
INSERT INTO pacientes (nombre, fecha_nacimiento, telefono, documento_identidad) VALUES
  ('Juan Pérez',    '1985-03-12', '3001234567', 'CC-111'),
  ('Laura Gómez',   '1992-07-25', '3109876543', 'CC-222'),
  ('Carlos Díaz',   '1978-11-03', '3205551234', 'CC-333'),
  ('María Soto',    '2001-01-18', '3006667788', 'CC-444');

-- Insertar citas
INSERT INTO citas (medico_id, paciente_id, fecha_hora, motivo_consulta, estado) VALUES
  (1, 1, '2025-08-01 09:00', 'Control tensión',   'pendiente'),
  (1, 2, '2025-08-01 10:00', 'Revisión anual',    'completada'),
  (2, 3, '2025-08-02 08:30', 'Fiebre recurrente', 'pendiente'),
  (2, 4, '2025-08-02 09:30', 'Vacunación',        'completada'),
  (3, 1, '2025-08-03 11:00', 'Dermatitis',        'cancelada'),
  (3, 3, '2025-08-04 14:00', 'Seguimiento',       'pendiente');

--Mostrar todos los pacientes y sus citas
SELECT pacientes.nombre, citas.fecha_hora, citas.estado
FROM pacientes
LEFT JOIN citas
ON pacientes.id = citas.paciente_id;

--Mostrar todas las citas y el médico asociado
select medicos.nombre_completo, citas.fecha_hora, citas.estado
FROM medicos
RIGHT JOIN citas
ON medicos.id = citas.medico_id;

--Cantidad de citas por médico
SELECT medicos.nombre_completo,
COUNT(citas.id) 
AS total_citas
FROM medicos
LEFT JOIN citas
ON medicos.id = citas.medico_id
GROUP BY medicos.nombre_completo;

--Cantidad de citas por estado
SELECT estado,
COUNT(*) AS cantidad
FROM citas
GROUP BY estado;

--Mostrar solo 2 pacientes.
SELECT *
FROM pacientes
LIMIT 2;

--Mostrar solo 3 citas
SELECT *
FROM citas
LIMIT 3;

--Saltar 2 pacientes y mostrar el resto
SELECT *
FROM pacientes
OFFSET 2;

--Mostrar 2 citas empezando desde la tercera
SELECT *
FROM citas
LIMIT 2
OFFSET 2;