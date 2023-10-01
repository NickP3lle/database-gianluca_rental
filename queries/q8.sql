SELECT targa, marca, modello
FROM autoveicolo
WHERE tipo_veicolo = 'AUTO' AND prezzo IS null

EXCEPT

(SELECT A.targa, A.marca, A.modello
FROM autoveicolo AS A
JOIN noleggio as N
ON A.targa = N.targa
WHERE N.data_inizio < '2018-03-01' AND N.data_fine > '2018-03-01')