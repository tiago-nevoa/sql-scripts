create table CAMPANHA_MONITORIZACAO(
	id_trabalho integer,
	indice_monitorizacao integer
);

create table DOCUMENTO(
	id_obra integer,
	numero integer,
	titulo varchar(150),
	bytes bytea
);

create table EQUIPAMENTO(
	id serial,
	tipo varchar(20),
	id_obra integer
);

