SELECT C.nome, C.cognome, C.cf, C.sesso, C.email, C.telefono
FROM Cliente AS C
JOIN Noleggio AS N on N.CF = C.CF
JOIN Autoveicolo AS A ON N.targa = A.targa
JOIN Lavoratore AS L ON L.ID = N.ID_lavoratore
WHERE A.lusso=true AND N.ID_lavoratore = '2'