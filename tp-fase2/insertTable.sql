-- Inserindo dados na tabela UTILIZADOR
INSERT INTO UTILIZADOR (email, nome, tipo, perfil) VALUES
    ('usuario1@example.com', 'Usuário 1', 'externo', 'perfil1'),
    ('usuario2@example.com', 'Usuário 2', 'interno', 'perfil2'),
    ('usuario3@example.com', 'Usuário 3', 'interno', 'perfil3'),
    ('usuario4@example.com', 'Usuário 4', 'externo', 'perfil4'),
   	('inspetor1@example.com', 'Inspetor 1', 'interno', 'inspetor'),
   	('inspetor2@example.com', 'Manuel Faria', 'interno', 'inspetor'),
   	('gestor1@example.com', 'António Faria', 'interno', 'gestor'),
   	('gestor2@example.com', 'João Silva', 'interno', 'gestor');
   
-- Inserindo dados na tabela TIPO_ESTRUTURA
INSERT INTO TIPO_ESTRUTURA (tipo) VALUES
    ('muro'),
    ('parede'),
    ('aterro'),
    ('talude'),
    ('barreira'),
    ('solução mista'),
    ('aterro'),
    ('talude');

-- Inserindo dados na tabela OBRA_CONTENCAO
INSERT INTO OBRA_CONTENCAO (matricula, custo, latitude, longitude, tipo_estrutura) VALUES
    ('ABC123', 10000.50, 40.7128, -74.0060, 1),
    ('DEF456', 15000.75, 51.5074, -0.1278, 2),
    ('GHI789', 20000.25, 37.7749, -122.4194, 3),
    ('JKL012', 18000.50, 48.8566, 2.3522, 4),
   	('ABC323', 10000.00, 40.1234, -8.5678, 1),
   	('ZXW789', 17000.00, 21.5678, -19.1234, 6),
   	('XYZ789', 15000.00, 41.5678, -9.1234, 2);
   
-- Inserindo dados na tabela TRABALHO
INSERT INTO TRABALHO (data_planeada, data_execucao, estado, id_obra, inspetor, gestor, atrdisc) VALUES
    ('2022-05-01', '2022-05-05', 'executado', 1, 'usuario1@example.com', 'usuario2@example.com', 'IP'),
    ('2022-06-01', '2022-06-05', 'planeado', 2, 'usuario2@example.com', 'usuario1@example.com', 'IR'),
    ('2022-07-01', '2023-07-05', 'executado', 3, 'usuario1@example.com', 'usuario3@example.com', 'CM'),
    ('2023-08-01', '2023-08-05', 'validado', 4, 'usuario2@example.com', 'usuario4@example.com', 'IP'),
   	('2023-05-01', '2023-05-10', 'executado', 1, 'inspetor1@example.com', 'gestor1@example.com', 'IP'),
   	('2023-06-01', '2023-06-10', 'planeado', 2, 'inspetor2@example.com', 'gestor1@example.com', 'IR'),
   	('2023-07-01', '2023-07-10', 'validado', 1, 'inspetor2@example.com', 'gestor1@example.com', 'CM'),
   	('2023-07-01', '2023-07-10', 'validado', 1, 'inspetor1@example.com', 'gestor1@example.com', 'IR'),
	('2023-07-01', '2023-07-10', 'validado', 1, 'inspetor2@example.com', 'gestor2@example.com', 'CM'),
	('2023-07-01', '2023-07-10', 'validado', 1, 'inspetor2@example.com', 'gestor1@example.com', 'IP'),
	('2023-07-01', '2023-07-10', 'validado', 1, 'inspetor1@example.com', 'gestor2@example.com', 'IR');
   
-- Inserindo dados na tabela CAMPANHA_MONITORIZACAO
INSERT INTO CAMPANHA_MONITORIZACAO (id_trabalho, indice_monitorizacao) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4);


-- Inserindo dados na tabela DOCUMENTO
INSERT INTO DOCUMENTO (id_obra, numero, titulo, bytes) VALUES
    (1, 1, 'Documento 1', 'bytes_do_documento_1'),
    (1, 2, 'Documento 2', 'bytes_do_documento_2'),
    (2, 1, 'Documento 3', 'bytes_do_documento_3'),
    (3, 2, 'Documento 4', 'bytes_do_documento_4'),
    (4, 1, 'Documento 5', 'bytes_do_documento_5');

-- Inserindo dados na tabela EQUIPAMENTO
INSERT INTO EQUIPAMENTO (tipo, id_obra) VALUES
    ('fissusómetro', 1),
    ('inclinómetro', 1),
    ('extensómetro', 2),
    ('fissusómetro', 3),
    ('inclinómetro', 3),
    ('extensómetro', 4);

-- Inserindo dados na tabela EQ_CMONITORIZACAO
INSERT INTO EQ_CMONITORIZACAO (id_equipamento, id_campanha, valor) VALUES
    (1, 1, 10.5),
    (2, 1, 20.75),
    (3, 2, 15.25),
    (1, 3, 8.75),
    (2, 3, 12.5),
    (3, 4, 18.0);

-- Inserindo dados na tabela INSPECAO_EXPEDITA
INSERT INTO INSPECAO_EXPEDITA (id_obra, data, classificacao) VALUES
    (1, '2023-05-10', 3),
    (2, '2023-06-10', 4),
    (3, '2023-07-10', 2),
    (4, '2023-08-10', 3);

-- Inserindo dados na tabela INSPECAO_PRINCIPAL
INSERT INTO INSPECAO_PRINCIPAL (id_trabalho, indice_condicao, estado_conservacao) VALUES
    (1, 1, 2),
    (2, 2, 3),
    (3, 3, 4),
    (4, 4, 5);

-- Inserindo dados na tabela SOLUCAO_ESTRUTURAL
INSERT INTO SOLUCAO_ESTRUTURAL (id_obra, sol_estrutural) VALUES
    (1, 'solução1'),
    (2, 'solução2'),
    (3, 'solução3'),
    (4, 'solução4');
    