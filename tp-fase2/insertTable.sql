insert into utilizador values ('teste@gmail.com' ,'Teste Um', 'interno' ,'inspect');

insert into utilizador values ('teste2@gmail.com' ,'Teste DOis', 'interno' ,'gestor');

insert into tipo_estrutura(tipo) values ('barreira');

insert into obra_contencao (matricula, custo, latitude, longitude, tipo_estrutura ) values ('XXXXX', 100, 88, 88, 1);

insert into trabalho  (data_planeada, data_execucao, estado, id_obra, tipo_estrutura ) values ('XXXXX', 100, 88, 88, 1);

delete from utilizador  where email  = 'teste@gmail.com';

