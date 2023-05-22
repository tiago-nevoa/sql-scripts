CREATE TABLE UTILIZADOR (
    u_email varchar(60) PRIMARY KEY,
    u_nome varchar(60),
    u_tipo varchar(20),
    u_perfil varchar(20),
    CONSTRAINT check_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'), /*check if the constraint is correct*/
    CONSTRAINT check_tipo CHECK (tipo IN ('externo', 'interno'))
);

CREATE TABLE TIPO_ESTRUTURA (
    te_id serial PRIMARY KEY, /*check valor sequencial*/
    te_tipo varchar(15),
    CONSTRAINT check_tipo CHECK (tipo IN ('muro', 'parede', 'aterro', 'talude', 'barreira', 'solução mista')),
    CONSTRAINT te_unique_seq_value UNIQUE (te_id) /*confirm this constraint*/
);

CREATE TABLE OBRA_CONTENCAO (
    oc_id serial PRIMARY KEY,
    oc_matricula varchar(20) UNIQUE,
    oc_custo real,/*restição em falta*/
    oc_latitude real,
    oc_longitude real,
    oc_tipo_estrutura integer,
    FOREIGN KEY (oc_tipo_estrutura) REFERENCES TIPO_ESTRUTURA (te_id)
);

CREATE TABLE TRABALHO (
    t_id serial PRIMARY KEY,
    t_data_planeada date, /*restrição em falta*/
    t_data_execucao date, /*restrição em falta*/
    t_estado varchar(20),
    t_id_obra integer,
    t_inspetor varchar(60),
    t_gestor varchar(60),
    t_atrdisc char(2),
    CONSTRAINT t_estado CHECK (tipo IN ('planeado', 'executado', 'validado')),
    CONSTRAINT t_atrdisc CHECK (tipo IN ('IP', 'IR', 'CM')),
    FOREIGN KEY (t_id_obra) REFERENCES OBRA_CONTENCAO (oc_id),
    FOREIGN KEY (t_inspetor) REFERENCES UTILIZADOR (u_email),
    FOREIGN KEY (t_gestor) REFERENCES UTILIZADOR (u_email)
);

CREATE TABLE CAMPANHA_MONITORIZACAO (
    cm_id_trabalho integer,
    cm_indice_monitorizacao integer,
    FOREIGN KEY (cm_id_trabalho) REFERENCES TRABALHO (t_id),
    PRIMARY KEY (cm_id_trabalho, cm_indice_monitorizacao) /*confirmar se esta correcto*/
);

CREATE TABLE DOCUMENTO (
    d_id_obra integer,
    d_numero integer,
    d_titulo varchar(150),
    d_bytes bytea,
    PRIMARY KEY (d_id_obra, d_numero),
    FOREIGN KEY (d_id_obra) REFERENCES OBRA_CONTENCAO (oc_id)
);

CREATE TABLE EQUIPAMENTO (
    e_id SERIAL UNIQUE,
    e_tipo varchar(20),
    id_obra integer,
    FOREIGN KEY (id_obra) REFERENCES OBRA_CONTENCAO (oc_id),
    CONSTRAINT e_tipo CHECK (tipo IN ('fissusómetro', 'inclinómetro', 'extensómetro')),
    CONSTRAINT e_unique_seq_value UNIQUE (e_id) /*confirm this constraint*/
);

CREATE TABLE EQ_CMONITORIZACAO (
    eqc_id_equipamento integer,
    eqc_id_campanha integer,
    valor real,
    FOREIGN KEY (eqc_id_equipamento) REFERENCES EQUIPAMENTO (e_id),
    FOREIGN KEY (eqc_id_campanha) REFERENCES TRABALHO (t_id)
);

CREATE TABLE INSPECAO_EXPEDITA (
    ie_id_obra integer,
    ie_data date, /*restrinção em falta*/
    ie_classificacao integer,
    FOREIGN KEY (ie_id_obra) REFERENCES OBRA_CONTENCAO (oc_id),
    PRIMARY KEY (id_obra, ie_data)
);

CREATE TABLE INSPECAO_PRINCIPAL (
    ip_id_trabalho integer,
    ip_indice_condicao integer,
    ip_estado_conservacao integer,
    FOREIGN KEY (ip_id_trabalho) REFERENCES TRABALHO (t_id),
    PRIMARY KEY (ip_id_trabalho, ip_indice_condicao)
);

CREATE TABLE SOLUCAO_ESTRUTURAL (
    se_id_obra integer,
    se_sol_estrutural varchar(20),
    FOREIGN KEY (se_id_obra) REFERENCES OBRA_CONTENCAO (oc_id),
    PRIMARY KEY (se_id_obra,se_sol_estrutural)
);
