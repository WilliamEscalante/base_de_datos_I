create database defensa_hito4
use defensa_hito4

create table campeonato(
id_campeonato varchar(12) primary key not null,
nombre_campeonato varchar(30) not null,
sede varchar(20) not null
);

create table equipo(
id_equipo varchar(20) primary key not null,
nombre_equipo varchar(30) not null,
categoria varchar(20) not null,
id_campeonato varchar(12) not null,
foreign key (id_campeonato) references campeonato(id_campeonato)
);


create table jugadores(
id_jugador varchar(20) primary key not null,
nombres varchar(20) not null,
apellidos varchar(20) not null,
ci varchar(20) not null,
edad integer not null,
id_equipo varchar(20) not null,
foreign key (id_equipo) references equipo(id_equipo));



insert into campeonato(id_campeonato, nombre_campeonato,sede) values('camp-111', 'Campeonato Unifranz','El Alto'),('camp-222', 'Campeonato Unifranz','Cochabamba')


insert into equipo(id_equipo, nombre_equipo, categoria, id_campeonato) values('equ-111', 'Google', 'VARONES', 'camp-111'),('equ-222', '484 Not found', 'VARONES', 'camp-111'),('equ-333', 'girls unifranz', 'MUJERES', 'camp-111');


insert into jugadores(id_jugador, nombres, apellidos, ci, edad, id_equipo) values('jug-111', 'Carlos', 'Villa', '8997811LP', 19, 'equ-222'),('jug-222', 'Pedro', 'Salas', '8997822LP', 20, 'equ-222'),('jug-333', 'Saul', 'Araj', '8997833LP', 21, 'equ-222'),('jug-444', 'Sandra', 'Solis', '8997844LP', 20, 'equ-333'),('jug-555', 'Ana', 'Mica', '8997855LP', 23, 'equ-333')



--CATEGORIA MUJERES
select jug.nombres, jug.apellidos, eq.categoria, cam.nombre_campeonato, cam.sede
from jugadores as jug
inner join equipo as eq on eq.id_equipo = JUG.id_equipo
INNER JOIN campeonato as cam on eq.id_campeonato = cam.id_campeonato
where EQ.categoria = 'mujeres' and  cam.nombre_campeonato = 'Campeonato Unifranz' and cam.sede = 'El Alto'

--EQUIPO GOOGLE
select count(jug.id_jugador) as 'Equipo Google'
from jugadores as jug
inner join equipo as eq on eq.id_equipo = jug.id_equipo
where eq.nombre_equipo = 'Google' and eq.categoria = 'Varones' and jug.apellidos like 'M%'



--PLATINIUM, GOLD, SILVER
create function type_client(@cantidad integer)
returns varchar(30) as
begin
	declare @resultado varchar(30)
	if(@cantidad > 50000)
	set @resultado = 'PLATINIUM'

	if(@cantidad >= 10000 and @cantidad <= 50000 )
	set @resultado = 'GOLD'

	if(@cantidad < 10000)
	set @resultado = 'SILVER'

	RETURN @resultado
end


select dbo.type_client(50001) as 'El cliente es:'

select dbo.type_client(50000) as 'El cliente es:'

select dbo.type_client(1000) as 'El cliente es:'

select dbo.type_client(0) as 'El cliente es:'





create function PRUEBA(@cantidad integer)
returns varchar(30) as
begin
	declare @resultado varchar(30)
	@resultado = (CASE SELECT 
	when @cantidad > 50000 then 'PLATINIUM'
	WHEN @cantidad >= 10000 and @cantidad <= 50000 then 'GOLD'
	WHEN @cantidad < 10000 then 'silver')

	RETURN @resultado
end


--sede
--ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
create function Jugadores1(@sede varchar(10))
returns integer as
begin
	declare @resultado integer = 0

	
	select @resultado = count(jug.id_jugador)
	from jugadores as jug
	inner join equipo as eq on eq.id_equipo = jug.id_equipo
	inner join campeonato as cam on eq.id_campeonato = cam.id_campeonato
	where jug.nombres like 'S%' and jug.apellidos like 'M%' and cam.sede = @sede

	return @resultado
end

select dbo.Jugadores1('El alto') as 'Resultado'



--Equipo y categoria
--ºººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
create function jugadores2(@equipo varchar(20), @categoria varchar(20))
returns integer as
begin
	declare @resultado integer = 0

	
	select  @resultado = count(jug.id_jugador)
	from jugadores as jug
	inner join equipo as eq on eq.id_equipo = jug.id_equipo
	where eq.nombre_equipo = @equipo and eq.categoria = @categoria


	return @resultado
end

select dbo.jugadores2('Google', 'Varones') as 'Resultado:'




select *
from campeonato

select*
from jugadores

select*
from equipo