SELECT id_lavoratore, nome, cognome, count(*) as numVendite
FROM acquisto
JOIN lavoratore
ON acquisto.id_lavoratore = lavoratore.id
GROUP BY id_lavoratore, nome, cognome
ORDER BY numVendite DESC
LIMIT 1