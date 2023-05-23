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



