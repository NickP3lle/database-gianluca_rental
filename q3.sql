SELECT DISTINCT C.cognome, C.nome, C.cf, C.email, C.telefono, C.email, C.inizio_cliente 
FROM cliente AS C
JOIN patente AS P
ON P.CF = C.CF
WHERE data_scadenza < '2023-06-18'
ORDER BY C.cognome, C.nome