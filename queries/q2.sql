SELECT A.marca as fornitore, F.citta, F.indirizzo, COUNT(*) AS numElementiForniti
FROM autoveicolo AS A
JOIN fornitore AS F
ON A.marca = F.nome
GROUP BY A.marca, F.citta, F.indirizzo
ORDER BY numElementiForniti DESC