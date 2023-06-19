SELECT A.targa, A.marca, A.modello, A.tipo_veicolo
FROM autoveicolo AS A
JOIN Polizza as P
ON P.targa = A.targa
WHERE P.massimale >= 10000000;