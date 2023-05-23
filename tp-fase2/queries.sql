/*
 * 3.b)
 * Apresente o nome de todos os utilizadores por perfil.
 * Deve apresentar a lista dos nomes por ordem alfabética (em primeiro lugar);
*/

SELECT nome
FROM UTILIZADOR
ORDER BY perfil, nome;

/*
 * 3.c)
 * Identifique todos os utilizadores que inspecionaram pelo menos um trabalho.
 * O resultado deve apresentar o nome, o email e o total de trabalhos inspecionados;
 */

SELECT U.nome, U.email, COUNT(T.id) AS total_trabalhos_inspecionados
FROM UTILIZADOR U
INNER JOIN TRABALHO T ON U.email = T.inspetor
GROUP BY U.nome, U.email
HAVING COUNT(T.id) >= 1;

/*
 * 3.d)
 * Liste todas as obras de contenção que não têm campanhas de monitorização
 * no estado “executado” ou “validado”;
 */

SELECT *
FROM OBRA_CONTENCAO
WHERE id NOT IN (
  SELECT id_trabalho
  FROM CAMPANHA_MONITORIZACAO
  INNER JOIN TRABALHO ON CAMPANHA_MONITORIZACAO.id_trabalho = TRABALHO.id
  WHERE TRABALHO.estado IN ('executado', 'validado')
);

/*
 * 3.e)
 * Apresente a lista de todos os inspetores que trabalham em todas obras cujo
 * gestor é o “António Faria”;
 */

SELECT DISTINCT TRABALHO.inspetor
FROM TRABALHO
INNER JOIN UTILIZADOR ON TRABALHO.inspetor = UTILIZADOR.email
WHERE TRABALHO.id_obra IN (
  SELECT id_obra
  FROM TRABALHO
  INNER JOIN UTILIZADOR ON TRABALHO.gestor = UTILIZADOR.email
  WHERE UTILIZADOR.nome = 'António Faria'
)
GROUP BY TRABALHO.inspetor
HAVING COUNT(DISTINCT TRABALHO.id_obra) = (
  SELECT COUNT(DISTINCT id_obra)
  FROM TRABALHO
  INNER JOIN UTILIZADOR ON TRABALHO.gestor = UTILIZADOR.email
  WHERE UTILIZADOR.nome = 'António Faria'
);

/*
 * 3.f)
 * Crie uma vista que permita obter os trabalhos realizados no ano passado
 * (deve fazer uso de uma função de datetime e não fixar o valor 2022);
 */

CREATE VIEW trabalhos_ano_passado AS
SELECT *
FROM TRABALHO
WHERE date_trunc('year', data_execucao) = date_trunc('year', current_date) - interval '1 year';

SELECT * FROM trabalhos_ano_passado;

/*
 * 3.g)
 * Crie uma vista que permita obter, para cada obra de contenção, o número de inspeções principais,
 * o número de inspeções de rotina e o número de campanhas de monitorização.
 */

CREATE VIEW informacoes_obras AS
SELECT OC.id AS id_obra,
       COUNT(DISTINCT IP.id_trabalho) AS num_inspecoes_principais,
       COUNT(DISTINCT IR.id_obra) AS num_inspecoes_rotina,
       COUNT(DISTINCT CM.id_trabalho) AS num_campanhas_monitorizacao
FROM OBRA_CONTENCAO OC
LEFT JOIN INSPECAO_PRINCIPAL IP ON OC.id = IP.id_trabalho
LEFT JOIN INSPECAO_EXPEDITA IR ON OC.id = IR.id_obra
LEFT JOIN CAMPANHA_MONITORIZACAO CM ON OC.id = CM.id_trabalho
GROUP BY OC.id;


SELECT * FROM informacoes_obras;

/*
 * 4.
 * Apresente o(s) comando(s) que permitem planear uma inspeção principal para
 * uma obra já registada na base de dados, para a data 01/07/2023.
 * Afete esse trabalho a um inspetor e a um gestor já registados na BD.
 */

SELECT id FROM OBRA_CONTENCAO WHERE id = 1;

SELECT email FROM UTILIZADOR WHERE email IN ('inspetor2@example.com', 'gestor1@example.com');

INSERT INTO TRABALHO (data_planeada, estado, id_obra, inspetor, gestor)
VALUES ('2023-07-01', 'planeado', 1, 'inspetor2@example.com', 'gestor1@example.com');
