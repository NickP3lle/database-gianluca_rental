DROP TABLE IF EXISTS acquisto;
DROP TABLE IF EXISTS noleggio;
DROP TABLE IF EXISTS polizza;
DROP TABLE IF EXISTS autoveicolo;
DROP TABLE IF EXISTS parcheggio;
DROP TABLE IF EXISTS fornitore;
DROP TABLE IF EXISTS lavoratore;
DROP TABLE IF EXISTS patente;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
	CF VARCHAR(255) PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	cognome VARCHAR(255) NOT NULL,
	sesso VARCHAR(1) NOT NULL,
	email VARCHAR(255),
	telefono VARCHAR(255) NOT NULL,
	inizio_cliente DATE NOT NULL
);

CREATE TABLE patente (
	numpatente VARCHAR(255) PRIMARY KEY,
	data_rilascio DATE NOT NULL,
	data_scadenza DATE NOT NULL,
	tipo VARCHAR(255) NOT NULL,
	CF VARCHAR(255) NOT NULL,
	FOREIGN KEY (CF) REFERENCES clients(CF)
);

CREATE TABLE lavoratore (
	ID VARCHAR(255) PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	cognome VARCHAR(255) NOT NULL,
	contratto VARCHAR(255) NOT NULL
);

CREATE TABLE fornitore (
	nome VARCHAR(255) PRIMARY KEY,
	indirizzo VARCHAR(255) NOT NULL,
	citta VARCHAR(255) NOT NULL
);

CREATE TABLE parcheggio (
	indirizzo VARCHAR(255),
	citta VARCHAR(255),
	posti_totali INT NOT NULL,
	PRIMARY KEY (indirizzo, citta)
);

CREATE TABLE autoveicolo (
	targa VARCHAR(255) PRIMARY KEY,
	modello VARCHAR(255) NOT NULL,
	anno INT NOT NULL,
	km INT NOT NULL,
	lusso BOOLEAN NOT NULL,
	cambio VARCHAR(255) NOT NULL,
	cilindrata INT NOT NULL,
	carburante VARCHAR(255) NOT NULL,
	indirizzo_parcheggio VARCHAR(255) NOT NULL,
	citta_parcheggio VARCHAR(255) NOT NULL,
	posto_parcheggio INT NOT NULL,
	marca VARCHAR(255) NOT NULL,
	prezzo_giornaliero INT, -- solo se possiede una polizza
	prezzo INT, -- solo se non possiede una polizza
	--tipo_veicolo VARCHAR(255) NOT NULL,
	motociclo BOOLEAN, -- se moto specifica se è motociclo o ciclomotore
	carico_massimo INT, -- se furgone specifica il carico massimo
	posti_passeggeri INT, -- se auto specifica i posti
	FOREIGN KEY (indirizzo_parcheggio, citta_parcheggio) REFERENCES parcheggio(indirizzo, citta),
	FOREIGN KEY (marca) REFERENCES fornitore(nome)
);

CREATE TABLE polizza (
	numero_polizza VARCHAR(255) PRIMARY KEY,
	tipo VARCHAR(255) NOT NULL,
	massimale INT NOT NULL,
	franchigia INT NOT NULL,
	targa VARCHAR(255) NOT NULL,
	FOREIGN KEY (targa) REFERENCES autoveicolo(targa)
);

CREATE TABLE noleggio (
	codice VARCHAR(255) PRIMARY KEY,
	data_inizio DATE NOT NULL,
	data_fine DATE NOT NULL,
	targa VARCHAR(255) NOT NULL,
	CF VARCHAR(255) NOT NULL,
	ID_lavoratore VARCHAR(255) NOT NULL,
	FOREIGN KEY (targa) REFERENCES autoveicolo(targa),
	FOREIGN KEY (CF) REFERENCES cliente(CF),
	FOREIGN KEY (ID_lavoratore) REFERENCES lavoratore(ID)
);

CREATE TABLE acquisto (
	codice VARCHAR(255) PRIMARY KEY,
	data_acquisto DATE NOT NULL,
	targa VARCHAR(255) NOT NULL,
	CF VARCHAR(255) NOT NULL,
	ID_lavoratore VARCHAR(255) NOT NULL,
	FOREIGN KEY (targa) REFERENCES autoveicolo(targa),
	FOREIGN KEY (CF) REFERENCES cliente(CF),
	FOREIGN KEY (ID_lavoratore) REFERENCES lavoratore(ID)
);