/*
 * 3.a)
 * 		a)
 */

SELECT id, matricula
FROM OBRA_CONTENCAO
WHERE tipo_estrutura IN(
	SELECT id
	FROM tipo_estrutura 
	WHERE tipo = 'muro'
)

/*
 * 		b)
 */
SELECT email, nome, perfil
FROM UTILIZADOR
order by perfil ;

/*
 * 		c)
 */

SELECT tipo_estrutura, SUM(custo) AS custo_total
FROM OBRA_CONTENCAO
WHERE  tipo_estrutura IN(
	SELECT id
	FROM tipo_estrutura 
	WHERE tipo = 'muro' or tipo = 'parede'
)
group by tipo_estrutura 

/*
 * 		d)
 */

SELECT OBRA_CONTENCAO.id, OBRA_CONTENCAO.matricula, COUNT(OBRA_CONTENCAO.id) AS num_trabalhos
FROM OBRA_CONTENCAO
INNER JOIN TRABALHO ON OBRA_CONTENCAO.id = TRABALHO.id_obra
group by OBRA_CONTENCAO.id, OBRA_CONTENCAO.matricula;

/*
 * 		e)
 */

SELECT DISTINCT  OBRA_CONTENCAO.matricula, OBRA_CONTENCAO.custo
FROM OBRA_CONTENCAO
INNER JOIN TRABALHO ON OBRA_CONTENCAO.id = TRABALHO.id_obra
WHERE TRABALHO.atrdisc  IN ('IP', 'IR');

/*
 * 		f)
 */

SELECT OBRA_CONTENCAO.id, OBRA_CONTENCAO.matricula, COUNT(DOCUMENTO.id_obra) AS num_documentos
FROM OBRA_CONTENCAO
right JOIN DOCUMENTO ON  OBRA_CONTENCAO.id = DOCUMENTO.id_obra
group by OBRA_CONTENCAO.id, OBRA_CONTENCAO.matricula
order by OBRA_CONTENCAO.id ASC

/*
 * 		g)
 */

SELECT TRABALHO.id
FROM TRABALHO
INNER JOIN OBRA_CONTENCAO ON TRABALHO.id_obra = OBRA_CONTENCAO.id
WHERE gestor  IN (
    SELECT email
    FROM utilizador
    WHERE NOME = 'Jo�o Silva'
)
AND NOT EXISTS (
    select *
    FROM TRABALHO
    WHERE inspetor IN (
        SELECT email
        FROM utilizador
        WHERE NOME = 'Manuel Faria'
    )
);


/*
 * 3.b)
 * Apresente o nome de todos os utilizadores por perfil.
 * Deve apresentar a lista dos nomes por ordem alfabetica (em primeiro lugar);
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
 * Liste todas as obras de contencao que nao tem campanhas de monitorizacao
 * no estado executado ou validado;
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
 * gestor e o Antonio Faria;
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



