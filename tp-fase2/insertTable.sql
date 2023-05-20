insert into utilizador values ('teste@gmail.com' ,'Teste Um', 'interno' ,'inspect');

insert into utilizador values ('teste2@gmail.com' ,'Teste DOis', 'interno' ,'gestor');

insert into tipo_estrutura(tipo) values ('barreira');

insert into obra_contencao (matricula, custo, latitude, longitude, tipo_estrutura ) values ('XXXXX', 100, 88, 88, 3);

insert into trabalho (data_planeada, data_execucao, estado, id_obra, inspetor, gestor, atrdisc )
	values ('2023-05-21', '2023-05-21', 'planeado',5, 'teste@gmail.com', 'teste2@gmail.com', 'IR');

insert into campanha_monitorizacao  values (5 ,1);

insert into documento  values (5 ,1, 'DOC1', 'FFFF');

insert into equipamento(tipo, id_obra) values ('extensómetro', 5);

insert into eq_cmonitorizacao  values (2 ,5, 20);

insert into inspecao_expedita  values (5 ,'2023-05-21', 10);

insert into inspecao_principal values (5,10, 10);

insert into solucao_estrutural  values (5 , 'solucao abc');



	
	

delete from utilizador  where email  = 'teste@gmail.com';

