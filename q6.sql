SELECT indirizzo, citta, count(*) AS numVeicoli
FROM parcheggio AS P
LEFT JOIN autoveicolo AS A
ON P.indirizzo = A.indirizzo_parcheggio AND P.citta = A.citta_parcheggio
GROUP BY indirizzo,citta
HAVING count(*) > 0
ORDER BY numVeicoli DESC