-- Crear la base de datos
CREATE DATABASE MantenimientoEquipos1;
GO

-- Usar la base de datos
USE MantenimientoEquipos1;
GO

-- Crear la tabla de usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    CorreoElectronico VARCHAR(100),
    Telefono VARCHAR(15)
);
-- Insertar usuarios
INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) 
VALUES 
    ('zulliany', 'zulliany0203@gmail.com', '67458912'),
    ('Alejandra', 'alejandra15@gmail.com', '85471234'),
    ('Melissa', 'MelissaJ@gmail.com', '26501080'),
    ('Stefany', 'Stefany47@gmail.com', '69842135'),
    ('Victoria', 'Vic89@gmail.com', '81022347');

-- Consultar usuarios
SELECT * FROM Usuarios;

-- Crear la tabla de técnicos
CREATE TABLE Tecnicos (
    TecnicoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Especialidad VARCHAR(100)
);

-- Insertar técnicos
INSERT INTO Tecnicos (Nombre, Especialidad) 
VALUES 
    ('Karla Naranjo', 'Electrónica'),
    ('Juan Luis', 'Sistemas'),
    ('Ricardo', 'Mantenimiento');

-- Consultar técnicos
SELECT * FROM Tecnicos;

-- Crear la tabla de equipos
CREATE TABLE Equipos (
    EquipoID INT PRIMARY KEY IDENTITY(1,1),
    TipoEquipo VARCHAR(100),
    Modelo VARCHAR(100),
    UsuarioID INT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Insertar equipos
INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) 
VALUES
    ('Laptop', 'HP14-em0017la', 1),
    ('Tablet', 'iPad tercera generacion', 1),
    ('Celular', 'Samsung S24 ultra', 1),
    ('Celular', 'Huawei y9 prime', 1),
    ('Tablet', 'Lenovo M9', 1);

-- Consultar equipos
SELECT * FROM Equipos;

-- Crear la tabla de reparaciones
CREATE TABLE Reparaciones (
    ReparacionID INT PRIMARY KEY IDENTITY(1,1),
    EquipoID INT,
    FechaSolicitud DATE,
    Estado VARCHAR(50),
    FOREIGN KEY (EquipoID) REFERENCES Equipos(EquipoID)
);

-- Insertar reparaciones
INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado) 
VALUES 
    (1, '2024-11-25', 'Pendiente'),
    (2, '2024-11-26', 'Pendiente'),
    (3, '2024-11-30', 'Pendiente'),
    (4, '2024-12-03', 'Pendiente'),
    (5, '2024-12-14', 'Pendiente');

-- Consultar reparaciones
SELECT * FROM Reparaciones;

-- Crear la tabla de asignaciones
CREATE TABLE Asignaciones (
    AsignacionID INT PRIMARY KEY IDENTITY(1,1),
    ReparacionID INT FOREIGN KEY REFERENCES Reparaciones(ReparacionID),
    TecnicoID INT FOREIGN KEY REFERENCES Tecnicos(TecnicoID),
    FechaAsignacion DATE
);

-- Insertar asignaciones
INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion) 
VALUES 
    (1, 3, '2024-11-25'),
    (2, 1, '2024-11-26'),
    (3, 2, '2024-11-30'),
    (4, 3, '2024-12-03'),
    (5, 3, '2024-12-14');

-- Consultar asignaciones
SELECT * FROM Asignaciones;

--- Crear la tabla de detalles de reparación
CREATE TABLE DetallesReparacion (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),  
    ReparacionID INT,  
    Descripcion VARCHAR(MAX),  
    FechaInicial DATE,  
    FechaFinal DATE,  
    FOREIGN KEY (ReparacionID) REFERENCES Reparaciones(ReparacionID) 
);

-- Insertar detalles de reparación
INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicial, FechaFinal) 
VALUES 
    (1, 'Reemplazo de pantalla', '2024-11-25', '2024-11-30'),
    (2, 'Arreglo interno de cableado', '2024-11-26', '2024-12-03'),
    (3, 'Antivirus', '2024-11-30', '2024-12-01'),
    (4, 'Arreglo de cámara quebrada', '2024-12-03', '2024-12-05'),
    (5, 'Cambio de batería', '2024-12-14', '2024-12-17');

-- Consultar detalles de reparación
SELECT * FROM DetallesReparacion;


-- Crear procedimientos almacenados

-- Ingresar Usuario
CREATE PROCEDURE IngresarUsuario
    @nombre VARCHAR(100),
    @correoElectronico VARCHAR(100),
    @telefono VARCHAR(15)
AS
BEGIN
    INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono)
    VALUES (@nombre, @correoElectronico, @telefono)
END

-- Borrar Usuario
CREATE PROCEDURE BorrarUsuario
    @id INT
AS
BEGIN
    DELETE FROM Usuarios
    WHERE UsuarioID = @id
END

-- Modificar Usuario
CREATE PROCEDURE ModificarUsuario
    @id INT,
    @nombre VARCHAR(100),
    @correoElectronico VARCHAR(100),
    @telefono VARCHAR(15)
AS
BEGIN
    UPDATE Usuarios
    SET Nombre = @nombre,
        CorreoElectronico = @correoElectronico,
        Telefono = @telefono
    WHERE UsuarioID = @id
END

-- Consultar Usuarios
CREATE PROCEDURE ConsultarUsuarios
AS
BEGIN
    SELECT * FROM Usuarios
END

-- Ingresar Tecnico
CREATE PROCEDURE IngresarTecnico
    @nombre VARCHAR(100),
    @especialidad VARCHAR(100)
AS
BEGIN
    INSERT INTO Tecnicos (Nombre, Especialidad)
    VALUES (@nombre, @especialidad)
END

-- Borrar Tecnico
CREATE PROCEDURE BorrarTecnico
    @id INT
AS
BEGIN
    DELETE FROM Tecnicos
    WHERE TecnicoID = @id
END

-- Modificar Tecnico
CREATE PROCEDURE ModificarTecnico
    @id INT,
    @nombre VARCHAR(100),
    @especialidad VARCHAR(100)
AS
BEGIN
    UPDATE Tecnicos
    SET Nombre = @nombre,
        Especialidad = @especialidad
    WHERE TecnicoID = @id
END

-- Consultar Tecnicos
CREATE PROCEDURE ConsultarTecnicos
AS
BEGIN
    SELECT * FROM Tecnicos
END

-- Ingresar Equipo
CREATE PROCEDURE IngresarEquipo
    @tipoEquipo VARCHAR(100),
    @modelo VARCHAR(100),
    @usuarioID INT
AS
BEGIN
    INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID)
    VALUES (@tipoEquipo, @modelo, @usuarioID)
END

-- Borrar Equipo
CREATE PROCEDURE BorrarEquipo
    @id INT
AS
BEGIN
    DELETE FROM Equipos
    WHERE EquipoID = @id
END

-- Modificar Equipo
CREATE PROCEDURE ModificarEquipo
    @id INT,
    @tipoEquipo VARCHAR(100),
    @modelo VARCHAR(100),
    @usuarioID INT
AS
BEGIN
    UPDATE Equipos
    SET TipoEquipo = @tipoEquipo,
        Modelo = @modelo,
        UsuarioID = @usuarioID
    WHERE EquipoID = @id
END

-- Consultar Equipos
CREATE PROCEDURE ConsultarEquipos
AS
BEGIN
    SELECT * FROM Equipos
END

-- Ingresar Reparacion
CREATE PROCEDURE IngresarReparacion
    @equipoID INT,
    @fechaSolicitud DATE,
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado)
    VALUES (@equipoID, @fechaSolicitud, @estado)
END

-- Borrar Reparacion
CREATE PROCEDURE BorrarReparacion
    @id INT
AS
BEGIN
    DELETE FROM Reparaciones
    WHERE ReparacionID = @id
END

-- Modificar Reparacion
CREATE PROCEDURE ModificarReparacion
    @id INT,
    @equipoID INT,
    @fechaSolicitud DATE,
    @estado VARCHAR(50)
AS
BEGIN
    UPDATE Reparaciones
    SET EquipoID = @equipoID,
        FechaSolicitud = @fechaSolicitud,
        Estado = @estado
    WHERE ReparacionID = @id
END
CREATE PROCEDURE ConsultarReparaciones
AS
BEGIN
    SELECT * FROM Reparaciones
END

CREATE PROCEDURE IngresarAsignacion
    @reparacionID INT,
    @tecnicoID INT,
    @fechaAsignacion DATE
AS
BEGIN
    INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion)
    VALUES (@reparacionID, @tecnicoID, @fechaAsignacion)
END

CREATE PROCEDURE BorrarAsignacion
    @id INT
AS
BEGIN
    DELETE FROM Asignaciones
    WHERE AsignacionID = @id
END

CREATE PROCEDURE ModificarAsignacion
    @id INT,
    @reparacionID INT,
    @tecnicoID INT,
    @fechaAsignacion DATE
AS
BEGIN
    UPDATE Asignaciones
    SET ReparacionID = @reparacionID,
        TecnicoID = @tecnicoID,
        FechaAsignacion = @fechaAsignacion
    WHERE AsignacionID = @id
END

CREATE PROCEDURE ConsultarAsignaciones
AS
BEGIN
    SELECT * FROM Asignaciones
END

CREATE PROCEDURE IngresarDetalleReparacion
    @reparacionID INT,
    @descripcion TEXT,
    @fechaInicial DATE,
    @fechaFin DATE
AS
BEGIN
    INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicial, FechaFin)
    VALUES (@reparacionID, @descripcion, @fechaInicial, @fechaFin)
END

CREATE PROCEDURE BorrarDetalleReparacion
    @id INT
AS
BEGIN
    DELETE FROM DetallesReparacion
    WHERE DetalleID = @id
END

CREATE PROCEDURE ModificarDetalleReparacion
    @id INT,
    @reparacionID INT,
    @descripcion TEXT,
    @fechaInicial DATE,
    @fechaFin DATE
AS
BEGIN
    UPDATE DetallesReparacion
    SET ReparacionID = @reparacionID,
        Descripcion = @descripcion,
        FechaInicial = @fechaInicial,
        FechaFin = @fechaFin
    WHERE DetalleID = @id
END

CREATE PROCEDURE ConsultarDetallesReparacion
AS
BEGIN
    SELECT * FROM DetallesReparacion
END





