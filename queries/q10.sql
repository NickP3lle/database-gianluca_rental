SELECT P.numero_polizza, A.targa, P.massimale, P.franchigia
FROM polizza AS P
JOIN autoveicolo AS A
ON P.targa = A.targa
JOIN noleggio AS N
ON A.targa = N.targa
WHERE codice = '1'