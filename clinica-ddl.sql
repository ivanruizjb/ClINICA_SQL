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
