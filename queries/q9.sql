SELECT N.codice as codiceNoleggio, A.targa, A.marca, A.modello, DATE_PART('day', AGE(N.data_fine, N.data_inizio)) * A.prezzo_giornaliero AS prezzoGiornaliero
	FROM noleggio AS N
	JOIN autoveicolo AS A
	ON N.targa = A.targa
	WHERE codice = '7'