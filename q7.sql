SELECT DISTINCT *
FROM
	((SELECT DISTINCT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente
	FROM cliente AS C
	JOIN acquisto AS A
	ON C.cf = A.cf)

	UNION

	(SELECT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente
	FROM cliente AS C
	JOIN noleggio AS N
	ON C.cf = N.cf
	GROUP BY C.cf
	HAVING count(*) >= 2)) as fedeli

WHERE inizio_cliente <= '2010-12-31'