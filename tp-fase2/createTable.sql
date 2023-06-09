CREATE TABLE UTILIZADOR (
    email varchar(60) PRIMARY KEY,
    nome varchar(60),
    tipo varchar(20),
    perfil varchar(20),
    CONSTRAINT u_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT u_tipo CHECK (tipo IN ('externo', 'interno'))
);

CREATE TABLE TIPO_ESTRUTURA (
    id serial PRIMARY KEY, /*check valor sequencial*/
    tipo varchar(15),
    CONSTRAINT te_tipo CHECK (tipo IN ('muro', 'parede', 'aterro', 'talude', 'barreira', 'solução mista')),
    CONSTRAINT te_id UNIQUE (id)
);

CREATE TABLE OBRA_CONTENCAO (
    id serial PRIMARY KEY,
    matricula varchar(20) UNIQUE,
    custo real,
    latitude real,
    longitude real,
    tipo_estrutura integer,
    FOREIGN KEY (tipo_estrutura) REFERENCES TIPO_ESTRUTURA (id)
);

CREATE TABLE TRABALHO (
    id serial PRIMARY KEY,
    data_planeada date,
    data_execucao date,
    estado varchar(20),
    id_obra integer,
    inspetor varchar(60),
    gestor varchar(60),
    atrdisc char(2),
    CONSTRAINT t_estado CHECK (estado IN ('planeado', 'executado', 'validado')),
    CONSTRAINT t_atrdisc CHECK (atrdisc IN ('IP', 'IR', 'CM')),
    FOREIGN KEY (id_obra) REFERENCES OBRA_CONTENCAO (id),
    FOREIGN KEY (inspetor) REFERENCES UTILIZADOR (email),
    FOREIGN KEY (gestor) REFERENCES UTILIZADOR (email)
);

CREATE TABLE CAMPANHA_MONITORIZACAO (
    id_trabalho integer PRIMARY KEY,
    indice_monitorizacao integer,
    FOREIGN KEY (id_trabalho) REFERENCES TRABALHO (id)
);

CREATE TABLE DOCUMENTO (
    id_obra integer,
    numero integer,
    titulo varchar(150),
    bytes bytea,
    PRIMARY KEY (id_obra, numero),
    FOREIGN KEY (id_obra) REFERENCES OBRA_CONTENCAO (id)
);

CREATE TABLE EQUIPAMENTO (
    id serial PRIMARY KEY,
    tipo varchar(20),
    id_obra integer,
    FOREIGN KEY (id_obra) REFERENCES OBRA_CONTENCAO (id),
    CONSTRAINT e_tipo CHECK (tipo IN ('fissusómetro', 'inclinómetro', 'extensómetro'))
);

CREATE TABLE EQ_CMONITORIZACAO (
    id_equipamento integer,
    id_campanha integer,
    valor real,
    FOREIGN KEY (id_equipamento) REFERENCES EQUIPAMENTO (id),
    FOREIGN KEY (id_campanha) REFERENCES TRABALHO (id)
);

CREATE TABLE INSPECAO_EXPEDITA (
    id_obra integer PRIMARY KEY,
    data date,
    classificacao integer,
    FOREIGN KEY (id_obra) REFERENCES OBRA_CONTENCAO (id)
);

CREATE TABLE INSPECAO_PRINCIPAL (
    id_trabalho integer PRIMARY KEY,
    indice_condicao integer,
    estado_conservacao integer,
    FOREIGN KEY (id_trabalho) REFERENCES TRABALHO (id)
);

CREATE TABLE SOLUCAO_ESTRUTURAL (
    id_obra integer,
    sol_estrutural varchar(20),
    FOREIGN KEY (id_obra) REFERENCES OBRA_CONTENCAO (id),
    PRIMARY KEY (id_obra,sol_estrutural)
);
