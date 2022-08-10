--PA para TEscuela
use BDUniversidad
go

if OBJECT_ID('spSchoolList') is not null
	drop proc spSchoolList
go

create proc spSchoolList
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

if OBJECT_ID('spSchoolAdd') is not null
	drop proc spSchoolAdd
go

create proc spSchoolAdd
	@codEscuela char(3),
	@Escuela varchar(50),
	@Facultad varchar(50)
as
begin
	if not exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
	if not exists(select Escuela from TEscuela where Escuela=@Escuela)
	begin
		insert into TEscuela values(@codEscuela, @Escuela, @Facultad)
		select CodError=0, Mensaje='Se inserto correctamente escuela'
	end
		else select CodError=1, Mensaje='Error: Duplicidad en Escuela'
	else select CodError=1, Mensaje='Error: Duplicidad en CodEscuela'
end
go

if OBJECT_ID('spSchoolDelete') is not NULL
	drop PROCEDURE spSchoolDelete
GO

CREATE PROC spSchoolDelete
	@codEscuela CHAR(3)
AS
BEGIN
	if exists(select CodEscuela
	from TEscuela
	where CodEscuela=@codEscuela)
	BEGIN
		DELETE from TEscuela WHERE CodEscuela=@codEscuela
		SELECT CodError=0, Mensaje='Escuela Eliminada'
	END
	else SELECT CodError=1, Mensaje='Error: Escuela inexistente'
END
GO

if OBJECT_ID('spSchoolUpdate') is not null
	drop proc spSchoolUpdate
go

create proc spSchoolUpdate
	@codEscuela char(3),
	@escuela varchar(50),
	@facultad varchar(50)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
	begin
		update TEscuela Set Escuela=@escuela, Facultad=@facultad where CodEscuela=@codEscuela
		select CodError=0, Mensaje='Escuela Actualizada'
	end
	else select CodError=1, Mensaje='Error: Escuela no Ubicada'
end
go

if OBJECT_ID('spSchoolSearch') is not null
	drop proc spSchoolSearch
go

create proc spSchoolSearch
    @codEscuela char(3)
as
begin
    if exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
	begin
        select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela=@codEscuela
        select CodError=0, Mensaje='Escuela ubicada'
    end
	else select CodError=1, Mensaje='Error: Escuela inexistente'
end
go

--PA para TAlumno
use BDUniversidad
go

if OBJECT_ID('spStudentList') is not null
	drop proc spStudentList
go

create proc spStudentList
as
begin
    select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno
end
go

if OBJECT_ID('spStudentAdd') is not null
	drop proc spStudentAdd
go

create proc spStudentAdd
    @codAlumno char(5),
    @apellido varchar(50),
    @nombre varchar(50),
    @lNacimiento varchar(50),
    @fNacimiento datetime,
    @codEscuela char(3)
as
begin
    if not exists(select CodAlumno from TAlumno where CodAlumno=@codAlumno)
	if not exists(select Apellidos from TAlumno where Apellidos=@apellido)
	begin
        insert into TAlumno values(@codAlumno, @apellido, @nombre, @lNacimiento, @fNacimiento, @codEscuela)
        select CodError=0, Mensaje='Insercion correcta'
    end
		else select CodError=1, Mensaje='Error: Duplicidad en Apellido'
	else select CodError=1, Mensaje='Error: Duplicidad en CodAlumno'
end
go

if OBJECT_ID('spStudentDelete') is not null
	drop proc spStudentDelete
go

create proc spStudentDelete
    @codAlumno char(5)
as
begin
    if exists(select CodAlumno from TAlumno where CodAlumno=@codAlumno)
	begin
        delete from TAlumno where CodAlumno=@codAlumno
        select CodError=0, Mensaje='Se elimino alumno'
    end
	else select CodError=1, Mensaje='Error: Alumno inexistente'
end
go

if OBJECT_ID('spStudentUpdate') is not null
	drop proc spStudentUpdate
go

create proc spStudentUpdate
    @codAlumno char(5),
    @apellido varchar(50),
    @nombre varchar(50),
    @lNacimiento varchar(50),
    @fNacimiento datetime,
    @codEscuela char(3)
as
begin
    if exists(select CodAlumno from TAlumno where CodAlumno=@codAlumno)
	begin
        update TAlumno Set Apellidos=@apellido, Nombres=@nombre, LugarNac=@lNacimiento, FechaNac=@fNacimiento, CodEscuela=@codEscuela where CodAlumno=@codAlumno
        select CodError=0, Mensaje='Se actualizo alumno'
    end
		else select CodError=1, Mensaje='Error: Alumno inexistente'
end
go

if OBJECT_ID('spStudentSearch') is not null
	drop proc spStudentSearch
go

create proc spStudentSearch
    @codAlumno char(5)
as
begin
    if exists(select CodEscuela from TAlumno where CodAlumno=@codAlumno)
	begin
        select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno where CodAlumno=@codAlumno
        select CodError=0, Mensaje='Alumno ubicado'
    end
	else select CodError=1, Mensaje='Error: Alumno inexistente'
end
go

-- Consultas Escuela

exec spSchoolList
go

exec spSchoolAdd 'E06','Tecnologia Medica','Letras'
exec spSchoolAdd 'E07','Derecho','Letras'
exec spSchoolList
go

exec spSchoolDelete 'E07'
exec spSchoolList
go

exec spSchoolUpdate 'E06','Tecnologia Medica','Medicina Humana'
exec spSchoolList
go

exec spSchoolSearch 'E06'
go

--Consultas Alumno

exec spStudentList
go

exec spStudentAdd 'A002','Perez Mamani','Jorge','Arequipa','1996-06-06','E06'
exec spStudentList
go

exec spStudentDelete 'A002'
exec spStudentList
go

exec spStudentUpdate 'A001','Huamani Perez','Alberto','Lima','1995-05-05','E01'
exec spStudentList
go

exec spStudentSearch 'A001'
go