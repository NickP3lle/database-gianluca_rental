DROP TABLE IF EXISTS acquisto;
DROP TABLE IF EXISTS noleggio;
DROP TABLE IF EXISTS polizza;
DROP TABLE IF EXISTS autoveicolo;
DROP TABLE IF EXISTS parcheggio;
DROP TABLE IF EXISTS fornitore;
DROP TABLE IF EXISTS lavoratore;
DROP TABLE IF EXISTS patente;
DROP TABLE IF EXISTS cliente;

DROP TYPE IF EXISTS CATVEICOLO;
CREATE TYPE CATVEICOLO AS ENUM('auto', 'moto', 'furgone');

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
	FOREIGN KEY (CF) REFERENCES cliente(CF)
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
	tipo_veicolo CATVEICOLO NOT NULL,
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

INSERT INTO cliente VALUES 
('TSJPHL97P35G831I', 'Lita', 'Morgans', 'F', null, '406 576 7923', '2006-06-17'),
('HZJTVS68X33K590B', 'Dredi', 'Robey', 'F', 'drobey1@engadget.com', '843 876 2716', '2003-08-06'),
('EFXRBC33O71Y493Z', 'Pattin', 'Kermeen', 'M', 'pkermeen2@pagesperso-orange.fr', '639 413 9976', '2014-06-16'),
('BAKDFQ87U68B707M', 'Zulema', 'Stenhouse', 'F', 'zstenhouse3@loc.gov', '414 666 8595', '2011-02-11'),
('MYWXWR60R27F733H', 'Gabe', 'Blowfield', 'M', 'gblowfield4@howstuffworks.com', '208 333 1351', '2017-08-06'),
('ZBFXOZ29V61O596V', 'Isidor', 'Grant', 'M', 'igrant5@mlb.com', '450 437 4992', '2021-11-01'),
('NEXGWP48B09A248Y', 'Aloysius', 'McGurn', 'M', 'amcgurn6@arstechnica.com', '299 946 5521', '2004-09-10'),
('TNKRQM98H48R236H', 'Jess', 'McAnellye', 'F', 'jmcanellye7@phpbb.com', '837 775 1454', '2004-04-15'),
('AUCIYU39G06O833V', 'Edmund', 'Pidgeley', 'M', 'epidgeley8@unesco.org', '949 613 5643', '2010-03-19'),
('HRKUEB99Z37H176V', 'Cassy', 'McCormick', 'F', 'cmccormick9@admin.ch', '130 622 6576', '2007-08-15'),
('OMPWJW04L87M229C', 'Brook', 'Wanklin', 'F', 'bwanklina@meetup.com', '848 590 8507', '2006-02-20'),
('CFYDLL19I85M469F', 'Hanni', 'Gotter', 'F', null, '854 790 0953', '2006-01-31'),
('JJYVQV80F70J976H', 'Gordon', 'Aldington', 'M', 'galdingtonc@imdb.com', '728 296 1030', '2011-04-13'),
('ZUIWSN90B32P200V', 'Land', 'Twoohy', 'M', null, '427 603 3419', '2020-09-21'),
('YGOPRP75X80G302A', 'Jonathan', 'Mussard', 'M', 'jmussarde@aboutads.info', '682 765 3211', '2005-10-11'),
('PCEYQP56O75F568D', 'Loren', 'Farran', 'F', 'lfarranf@dropbox.com', '431 335 5976', '2008-02-15'),
('XZKXBT99E53M443W', 'Franni', 'Clint', 'F', 'fclintg@dailymail.co.uk', '776 967 9518', '2004-10-31'),
('NLRKLX70B04T482F', 'Prent', 'Elliff', 'M', null, '804 640 9962', '2023-02-02'),
('SDRYFM75G32A157H', 'Asa', 'Parmer', 'M', 'aparmeri@symantec.com', '691 679 8937', '2008-02-13'),
('BYCHDG64H24K119Y', 'Nichols', 'Blore', 'M', 'nblorej@aol.com', '761 708 7036', '2009-05-15'),
('EGSAFY87L48P287X', 'Emelda', 'Yerrington', 'F', 'eyerringtonk@seattletimes.com', '505 296 8317', '2000-01-30'),
('NKIUML24J11Q923R', 'Free', 'Gimblett', 'M', 'fgimblettl@blinklist.com', '261 380 0768', '2009-05-16'),
('JVPISK44Y40F049B', 'Kale', 'Grzes', 'M', 'kgrzesm@archive.org', '918 788 2462', '2009-08-31'),
('LHFVOO46Y05X777Z', 'Ulrike', 'Causley', 'F', 'ucausleyn@sfgate.com', '290 597 5463', '2017-05-20'),
('COGIFU01E96P143P', 'Ferrell', 'Jackman', 'M', 'fjackmano@unesco.org', '874 169 2665', '2001-11-28'),
('MKVHRN09K78T127P', 'Malina', 'Gridley', 'F', 'mgridleyp@flavors.me', '914 595 4984', '2020-08-23'),
('VRSQHT76V59T281R', 'Hortensia', 'Taylour', 'F', 'htaylourq@barnesandnoble.com', '359 766 3852', '2009-07-27'),
('NFFOLB76Y25M343V', 'Parnell', 'Mosedale', 'M', 'pmosedaler@technorati.com', '529 613 4195', '2015-04-30'),
('CFDDIU53E90P414S', 'Brigid', 'Maus', 'F', 'bmauss@feedburner.com', '829 539 2470', '2016-05-26'),
('PWKMJS23W68Q347T', 'Margalit', 'Glavis', 'F', null, '243 832 1484', '2022-09-15'),
('YULQKQ73P86X286L', 'Clayson', 'Packham', 'M', 'cpackhamu@elegantthemes.com', '888 735 0431', '2021-07-03'),
('ZYKUKW49P77O176S', 'Ronald', 'McShane', 'M', null, '442 154 2699', '2016-10-24'),
('MMULDD16G49N561X', 'Carley', 'Winston', 'F', 'cwinstonw@fema.gov', '872 794 6974', '2018-10-04'),
('GRMGCW50Z30K624F', 'Steffen', 'Dunnan', 'M', 'sdunnanx@bravesites.com', '940 959 1873', '2020-12-23'),
('QTOEHE30B14R971P', 'Marvin', 'Crier', 'M', 'mcriery@bbc.co.uk', '121 152 0276', '2013-06-08'),
('ZREIWH07F35O917Q', 'Elberta', 'Bowry', 'F', 'ebowryz@webeden.co.uk', '164 808 5674', '2015-11-05'),
('VSOUYZ76G32H046N', 'Roxanne', 'Bartley', 'F', null, '126 480 1921', '2009-08-18'),
('BSJGVG58P59M263N', 'Kerk', 'McTeer', 'M', null, '126 760 6570', '2022-04-07'),
('VWQPWZ11A62S854P', 'Melanie', 'Benito', 'F', 'mbenito12@businessweek.com', '327 782 5299', '2019-07-07'),
('QJGRHQ64U95J443W', 'Frederich', 'Hanselman', 'M', 'fhanselman13@twitter.com', '551 929 4137', '2011-05-22');