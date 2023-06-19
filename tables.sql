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
CREATE TYPE CATVEICOLO AS ENUM('AUTO', 'MOTO', 'FURGONE');

CREATE TABLE cliente (
	CF VARCHAR(16) PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	cognome VARCHAR(255) NOT NULL,
	sesso VARCHAR(1) NOT NULL,
	email VARCHAR(255),
	telefono VARCHAR(12) NOT NULL,
	inizio_cliente DATE NOT NULL
);

CREATE TABLE patente (
	numpatente VARCHAR(10) PRIMARY KEY,
	data_rilascio DATE NOT NULL,
	data_scadenza DATE NOT NULL,
	tipo VARCHAR(3) NOT NULL,
	CF VARCHAR(16) NOT NULL,
	FOREIGN KEY (CF) REFERENCES cliente(CF)
);

CREATE TABLE lavoratore (
	ID VARCHAR(3) PRIMARY KEY,
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
	targa VARCHAR(7) PRIMARY KEY,
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
	numero_polizza VARCHAR(12) PRIMARY KEY,
	tipo VARCHAR(255) NOT NULL,
	massimale INT NOT NULL,
	franchigia INT NOT NULL,
	targa VARCHAR(7) NOT NULL,
	FOREIGN KEY (targa) REFERENCES autoveicolo(targa)
);

CREATE TABLE noleggio (
	codice VARCHAR(10) PRIMARY KEY,
	data_inizio DATE NOT NULL,
	data_fine DATE NOT NULL,
	targa VARCHAR(7) NOT NULL,
	CF VARCHAR(16) NOT NULL,
	ID_lavoratore VARCHAR(3) NOT NULL,
	FOREIGN KEY (targa) REFERENCES autoveicolo(targa),
	FOREIGN KEY (CF) REFERENCES cliente(CF),
	FOREIGN KEY (ID_lavoratore) REFERENCES lavoratore(ID)
);

CREATE TABLE acquisto (
	codice VARCHAR(10) PRIMARY KEY,
	data_acquisto DATE NOT NULL,
	targa VARCHAR(7) NOT NULL,
	CF VARCHAR(16) NOT NULL,
	ID_lavoratore VARCHAR(3) NOT NULL,
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

INSERT INTO patente VALUES
('RY8830112V', '2009-05-15', '2017-11-28', 'B', 'TSJPHL97P35G831I'),
('DD0697561Q', '2004-10-30', '2013-12-30', 'A', 'NKIUML24J11Q923R'),
('HA7246683R', '2016-11-13', '2029-07-11', 'E', 'LHFVOO46Y05X777Z'),
('TL0985028U', '2016-01-27', '2030-10-09', 'A', 'QTOEHE30B14R971P'),
('UC0610870F', '2003-01-06', '2034-09-27', 'B', 'JVPISK44Y40F049B'),
('EF7697758H', '2012-07-26', '2035-07-24', 'AM', 'ZYKUKW49P77O176S'),
('HB5818395E', '2016-12-01', '2020-02-26', 'C', 'EGSAFY87L48P287X'),
('NO5766704T', '2002-04-15', '2003-09-15', 'D', 'XZKXBT99E53M443W'),
('HZ2188782U', '2010-10-05', '2020-11-19', 'D', 'PWKMJS23W68Q347T'),
('SL4452565G', '2010-05-05', '2030-06-30', 'A', 'NEXGWP48B09A248Y'),
('AP0639470A', '2017-05-07', '2019-07-22', 'B', 'TSJPHL97P35G831I'),
('QN4451925V', '2017-06-26', '2036-03-08', 'B', 'AUCIYU39G06O833V'),
('BR9237160G', '2003-01-13', '2010-07-05', 'B', 'BSJGVG58P59M263N'),
('KC5721120N', '2006-03-02', '2022-02-08', 'B', 'CFYDLL19I85M469F'),
('WT6413388F', '2007-07-27', '2035-07-14', 'B', 'BSJGVG58P59M263N'),
('UH3935514P', '2000-03-03', '2001-09-08', 'A', 'NKIUML24J11Q923R'),
('OL4839653G', '2000-10-22', '2001-04-17', 'AM', 'HZJTVS68X33K590B'),
('KE6665604X', '2019-03-12', '2029-12-18', 'B', 'MMULDD16G49N561X'),
('YX8204669R', '2001-12-27', '2031-03-10', 'B', 'EGSAFY87L48P287X'),
('YG5605415G', '2014-12-10', '2015-01-13', 'B', 'QJGRHQ64U95J443W'),
('DB8725980H', '2008-06-02', '2021-09-14', 'B', 'VRSQHT76V59T281R'),
('BX0431483F', '2001-07-08', '2003-09-22', 'B', 'NKIUML24J11Q923R'),
('ZW1845669G', '2009-05-11', '2031-04-26', 'D', 'QJGRHQ64U95J443W'),
('KA1556106I', '2010-04-20', '2014-05-28', 'B', 'QJGRHQ64U95J443W'),
('AF5266430I', '2020-06-14', '2029-12-19', 'C', 'HRKUEB99Z37H176V'),
('XE6642909E', '2019-10-12', '2037-02-23', 'A', 'NKIUML24J11Q923R'),
('UM1864475M', '2006-07-17', '2033-09-27', 'E', 'VRSQHT76V59T281R'),
('TG4703090H', '2017-05-11', '2021-01-27', 'A', 'YULQKQ73P86X286L'),
('AR4743142T', '2020-08-18', '2037-05-05', 'A', 'MYWXWR60R27F733H'),
('XM4192794R', '2003-05-26', '2013-05-30', 'B', 'JJYVQV80F70J976H');

INSERT INTO lavoratore VALUES
('1', 'Von', 'Pawsey', 'DIRIGENTE'),
('2', 'Elsinore', 'Oswell', 'DIRIGENTE'),
('3', 'Kermie', 'Smaling', 'DIRIGENTE'),
('4', 'Konstanze', 'Edgeon', 'RESPONSABILE'),
('5', 'Raquela', 'Leinweber', 'RESPONSABILE'),
('6', 'Birk', 'Muddiman', 'RESPONSABILE'),
('7', 'Ab', 'Augustus', 'RESPONSABILE'),
('8', 'Lucienne', 'Suttie', 'RESPONSABILE'),
('9', 'Kristian', 'Twoohy', 'RESPONSABILE'),
('10', 'Cinnamon', 'Kidston', 'DIPENDENTE'),
('11', 'Henri', 'Kermitt', 'DIPENDENTE'),
('12', 'Candis', 'Pedgrift', 'DIPENDENTE'),
('13', 'Peggie', 'Fookes', 'DIPENDENTE'),
('14', 'Erwin', 'Mosson', 'DIPENDENTE'),
('15', 'Sanson', 'O Growgane', 'DIPENDENTE'),
('16', 'Rosemaria', 'Slaght', 'DIPENDENTE'),
('17', 'Earle', 'Kyd', 'DIPENDENTE'),
('18', 'Alice', 'Cheesman', 'DIPENDENTE'),
('19', 'Doy', 'Blant', 'DIPENDENTE'),
('20', 'Gustie', 'Choulerton', 'DIPENDENTE');

INSERT INTO fornitore VALUES
('Dodge', '2604 Sutteridge Drive', 'Tempe'),
('Mercury', '595 Atwood Way', 'Suresnes'),
('Ford', '86 Columbus Center', 'Hengfan'),
('Nissan', '63662 Dorton Pass', 'Tagiura'),
('Jeep', '12830 Ridge Oak Drive', 'Wirodayan'),
('Buick', '9517 Raven Center', 'Pho Thale'),
('Cadillac', '5 Cottonwood Lane', 'Nevel'),
('Audi', '2 Graedel Terrace', 'Minneapolis'),
('Hyundai', '6 Clarendon Parkway', 'Rešetari'),
('Chevrolet', '64 Pepper Wood Terrace', 'Mulchén'),
('Infiniti', '1012 Farmco Alley', 'Luleå'),
('Shelby', '9052 Columbus Alley', 'Lenningen'),
('Porsche', '9052 Columbus Alley', 'Lenningen'),
('Saab', '551 Jackson Circle', 'Volodars’k-Volyns’kyy'),
('Honda', '615 Gateway Terrace', 'Pueblo Nuevo'),
('Oldsmobile', '56 Arrowood Circle', 'Wilamowice'),
('Volvo', '7 Mallory Pass', 'Sukakarya'),
('Spyker', '63 North Court', 'Suka Makmue'),
('Mustang', '4310 Manitowish Crossing', 'Vallehermoso'),
('Mercedes-Benz', '0 Brown Street', 'Fengyi'),
('Infinity', '0 Banding Hill', 'Xidajie'),
('Pagani', '832 Havey Court', 'Al Majāridah'),
('Ferrari', '953 Brickson Park Place', 'Loreto'),
('Lotus', '5184 Nova Parkway', 'Tbêng Méanchey'),
('Koenigsegg', '4819 Sommers Trail', 'Coyaima'),
('Toyota', '9085 Russell Court', 'Nancang'),
('Alfa Romeo', '28 Pierstorff Pass', 'Lingbei'),
('Lamborghini', '21 Texas Way', 'Tayug'),
('Volkswagen', '82804 Autumn Leaf Junction', 'Lao Suea Kok'),
('Pontiac', '6 Erie Alley', 'Ardabīl'),
('Bugatti', '8127 Cascade Park', 'Myronivka'),
('Maserati', '508 Westport Parkway', 'Fulong'),
('Eagle', '29223 Norway Maple Court', 'Sritanjung'),
('GMC', '20223 Ridge Oak Drive', 'Sukakarya'),
('Lincoln', '462 North Court', 'Fengyi');

INSERT INTO parcheggio VALUES
('7 Dakota Point', 'Anolaima', 83),
('23 Bultman Pass', 'Messina', 62),
('1 Tennessee Avenue', 'Mlonggo', 23),
('171 Del Mar Pass', 'Bagay', 67),
('21284 Mifflin Road', 'Lidköping', 31),
('50758 La Follette Alley', 'Saint Hubert', 79),
('1889 3rd Alley', 'Valleymount', 61),
('536 Thierer Terrace', 'Waihi Beach', 71),
('8 Vera Place', 'Funaishikawa', 87),
('0342 Kensington Hill', 'Limoges', 22),
('231 Oakridge Alley', 'Jiazhuyuan', 23),
('03531 Eastlawn Lane', 'Kyprínos', 95),
('6 Northwestern Circle', 'Wang Nam Yen', 87),
('80 Texas Road', 'Cochabamba', 86),
('9 Northfield Parkway', 'Zougang', 73);

INSERT INTO autoveicolo VALUES 
('QG613BR', 'SC', 1993, 115240, true, 'Manuale', 4940, 'Benzina', '9 Northfield Parkway', 'Zougang', 57, 'Volkswagen', 280, NULL, 'AUTO', NULL, NULL, 6),
('TV674FS', 'Sierra 2500', 2002, 59672, false, 'Manuale', 4755, 'Diesel', '80 Texas Road', 'Cochabamba', 12, 'GMC', 382, NULL, 'AUTO', NULL, NULL, 9),
('WV741YT', 'MKZ', 2007, 48471, false, 'Manuale', 3085, 'Benzina', '6 Northwestern Circle', 'Wang Nam Yen', 65, 'Lincoln', 258, NULL, 'AUTO', NULL, NULL, 9),
('BX345HC', 'Tribute', 2003, 36269, false, 'Manuale', 3448, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 11, 'Pontiac', 22, NULL, 'AUTO', NULL, NULL, 9),
('NF738BM', 'Prelude', 1992, 52375, false, 'Manuale', 3389, 'Benzina', '03531 Eastlawn Lane', 'Kyprínos', 9, 'Honda', NULL, 74075, 'AUTO', NULL, NULL, 4),
('XP889ZR', 'Impreza', 2011, 98099, false, 'Manuale', 4940, 'Diesel', '0342 Kensington Hill', 'Limoges', 14, 'Saab', NULL, 28309, 'AUTO', NULL, NULL, 4),
('AS689NK', 'Ram 3500', 2009, 25519, false, 'Manuale', 1770, 'Benzina', '8 Vera Place', 'Funaishikawa', 87, 'Dodge', NULL, 77453, 'AUTO', NULL, NULL, 6),
('FN890WN', 'SL-Class', 2008, 44415, false, 'Manuale', 1369, 'Metano', '536 Thierer Terrace', 'Waihi Beach', 30, 'Mercedes-Benz', 365, NULL, 'AUTO', NULL, NULL, 4),
('WM196TI', 'XC90', 2006, 96796, false, 'Manuale', 3794, 'Benzina', '1889 3rd Alley', 'Valleymount', 42, 'Volvo', NULL, 38178, 'AUTO', NULL, NULL, 9),
('RF585AZ', '98', 1992, 54164, true, 'Manuale', 1879, 'Diesel', '50758 La Follette Alley', 'Saint Hubert', 65, 'Oldsmobile', NULL, 37584, 'AUTO', NULL, NULL, 7),
('BU100EL', 'Rodeo', 1995, 88128, false, 'Manuale', 907, 'GPL', '21284 Mifflin Road', 'Lidköping', 24, 'Infiniti', 473, NULL, 'AUTO', NULL, NULL, 7),
('TR321ZV', 'Savana 2500', 1996, 34818, true, 'Manuale', 4477, 'Benzina', '171 Del Mar Pass', 'Bagay', 44, 'GMC', NULL, 64778, 'AUTO', NULL, NULL, 3),
('EI429CG', 'Lancer Evolution', 2002, 125340, true, 'Automatico', 4460, 'Diesel', '1 Tennessee Avenue', 'Mlonggo', 13, 'Jeep', 304, NULL, 'AUTO', NULL, NULL, 9),
('NR781TW', 'I', 2004, 76459, false, 'Automatico', 1564, 'Metano', '23 Bultman Pass', 'Messina', 58, 'Infiniti', 90, NULL, 'AUTO', NULL, NULL, 7),
('VJ296AW', 'Crown Victoria', 2007, 2366, true, 'Automatico', 1957, 'Benzina', '7 Dakota Point', 'Anolaima', 68, 'Ford', NULL, 94262, 'AUTO', NULL, NULL, 4),
('LG070KV', 'Suburban 2500', 1996, 114413, true, 'Automatico', 3352, 'Diesel', '9 Northfield Parkway', 'Zougang', 67, 'Chevrolet', 437, NULL, 'AUTO', NULL, NULL, 7),
('JU237VE', 'Durango', 2009, 138749, false, 'Automatico', 2422, 'Metano', '80 Texas Road', 'Cochabamba', 1, 'Dodge', NULL, 92447, 'AUTO', NULL, NULL, 7),
('DE945DJ', 'S-Series', 1997, 149524, false, 'Automatico', 2708, 'Benzina', '6 Northwestern Circle', 'Wang Nam Yen', 41, 'Alfa Romeo', 75, NULL, 'AUTO', NULL, NULL, 6),
('FA966IV', 'QX', 2009, 24900, true, 'Automatico', 4188, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 12, 'Infiniti', 398, NULL, 'AUTO', NULL, NULL, 6),
('KD354QI', 'SL-Class', 2000, 14845, false, 'Automatico', 3433, 'Diesel', '03531 Eastlawn Lane', 'Kyprínos', 57, 'Mercedes-Benz', NULL, 89431, 'AUTO', NULL, NULL, 3),
('IF561CB', 'Jetta', 1998, 65308, false, 'Sequenziale', 3049, 'Benzina', '0342 Kensington Hill', 'Limoges', 3, 'Porsche', NULL, 54069, 'AUTO', NULL, NULL, 5),
('JO483SW', 'XK Series', 2000, 6832, false, 'Sequenziale', 3284, 'Diesel', '8 Vera Place', 'Funaishikawa', 39, 'Buick', NULL, 33541, 'AUTO', NULL, NULL, 9),
('ED838DV', 'A6', 2007, 147773, true, 'Sequenziale', 4888, 'Benzina', '536 Thierer Terrace', 'Waihi Beach', 22, 'Audi', NULL, 55005, 'AUTO', NULL, NULL, 9),
('DY375WP', '911', 2004, 52371, true, 'Sequenziale', 4575, 'Benzina', '1889 3rd Alley', 'Valleymount', 45, 'Porsche', 715, NULL, 'AUTO', NULL, NULL, 6),
('MV668SM', 'Avalanche', 2012, 25898, true, 'Sequenziale', 3692, 'GPL', '50758 La Follette Alley', 'Saint Hubert', 56, 'Chevrolet', 164, NULL, 'AUTO', NULL, NULL, 4),
('WK585IG', 'Vibe', 2004, 132444, false, 'Sequenziale', 2842, 'Benzina', '21284 Mifflin Road', 'Lidköping', 7, 'Pontiac', 154, NULL, 'AUTO', NULL, NULL, 7),
('CL232MU', 'B-Series', 1997, 57197, true, 'Sequenziale', 2688, 'Benzina', '171 Del Mar Pass', 'Bagay', 19, 'Maserati', 402, NULL, 'AUTO', NULL, NULL, 3),
('XB658EK', 'Fifth Ave', 1993, 91888, true, 'Sequenziale', 4044, 'Benzina', '1 Tennessee Avenue', 'Mlonggo', 3, 'Mercury', NULL, 32122, 'AUTO', NULL, NULL, 8),
('VS956HK', 'Explorer', 2007, 103, false, 'Sequenziale', 4003, 'Benzina', '23 Bultman Pass', 'Messina', 31, 'Ford', NULL, 83626, 'AUTO', NULL, NULL, 4),

('XX567XL', 'Discovery Series II', 1999, 88867, false, 'Automatico', 1200, 'Benzina', '7 Dakota Point', 'Anolaima', 43, 'Eagle', 71, NULL, 'MOTO', true, NULL, 2),
('RQ752TB', 'Envoy', 2002, 115719, true, 'Automatico', 900, 'Benzina', '9 Northfield Parkway', 'Zougang', 15, 'GMC', 81, NULL, 'MOTO', true, NULL, 1),
('JZ951ZV', 'TL', 2004, 64407, true, 'Automatico', 750, 'Diesel', '80 Texas Road', 'Cochabamba', 37, 'Cadillac', 74, NULL, 'MOTO', true, NULL, 2),
('TQ003FR', '4Runner', 2009, 35236, false, 'Automatico', 125, 'Benzina', '6 Northwestern Circle', 'Wang Nam Yen', 9, 'Toyota', NULL, 53775, 'MOTO', false, NULL, 2),
('UV505BB', 'Metro', 2000, 67697, false, 'Automatico', 50, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 22, 'Honda', NULL, 59181, 'MOTO', false, NULL, 2),
('QD039OH', 'Thunderbird', 1989, 14228, true, 'Automatico', 50, 'Diesel', '03531 Eastlawn Lane', 'Kyprínos', 79, 'Ford', 70, NULL, 'MOTO', false, NULL, 2),
('UE629TA', 'GTO', 1969, 131865, true, 'Automatico', 50, 'Benzina', '0342 Kensington Hill', 'Limoges', 20, 'Pontiac', NULL, 59650, 'MOTO', false, NULL, 2),
('YP235LW', 'Dakota Club', 1993, 48669, false, 'Sequenziale', 125, 'Diesel', '8 Vera Place', 'Funaishikawa', 80, 'Dodge', 136, NULL, 'MOTO', false, NULL, 1),
('XJ858RY', 'XJ Series', 2005, 7501, true, 'Sequenziale', 315, 'Diesel', '536 Thierer Terrace', 'Waihi Beach', 48, 'Honda', NULL, 53688, 'MOTO', true, NULL, 1),
('PR568TE', 'Grand Caravan', 2000, 93970, false, 'Sequenziale', 900, 'Benzina', '1889 3rd Alley', 'Valleymount', 61, 'Dodge', NULL, 90941, 'MOTO', true, NULL, 1),
('RG333AR', 'Probe', 1990, 96362, false, 'Sequenziale', 250, 'Diesel', '50758 La Follette Alley', 'Saint Hubert', 14, 'Ford', 420, NULL, 'MOTO', true, NULL, 2),
('ZX041AL', 'Silverado 1500', 2006, 125615, true, 'Sequenziale', 1200, 'Benzina', '21284 Mifflin Road', 'Lidköping', 9, 'Chevrolet', NULL, 56695, 'MOTO', true, NULL, 1),

('DC106UD', 'Boxster', 2004, 94192, true, 'Automatico', 2167, 'Benzina', '171 Del Mar Pass', 'Bagay', 6, 'Saab', NULL, 81308, 'FURGONE', NULL, 4412, NULL),
('UD710MV', 'Accord', 2003, 64184, false, 'Automatico', 2940, 'Diesel', '1 Tennessee Avenue', 'Mlonggo', 1, 'Buick', NULL, 84238, 'FURGONE', NULL, 4470, NULL),
('YE595LD', 'Yukon XL 2500', 2007, 148127, false, 'Automatico', 3667, 'Benzina', '23 Bultman Pass', 'Messina', 62, 'GMC', 235, NULL, 'FURGONE', NULL, 6482, NULL),
('QK547YC', 'IPL G', 2011, 27903, false, 'Automatico', 4671, 'Benzina', '7 Dakota Point', 'Anolaima', 58, 'Infiniti', NULL, 94471, 'FURGONE', NULL, 6989, NULL),
('XM447OV', 'Mystique', 1998, 58103, false, 'Automatico', 4784, 'Benzina', '9 Northfield Parkway', 'Zougang', 53, 'Mercury', 257, NULL, 'FURGONE', NULL, 6359, NULL),
('LG619NQ', 'Cooper', 2012, 71001, true, 'Manuale', 4963, 'Benzina', '80 Texas Road', 'Cochabamba', 9, 'Volvo', 375, NULL, 'FURGONE', NULL, 5058, NULL),
('WT712AG', 'Sierra', 2008, 54325, false, 'Manuale', 3129, 'Diesel', '6 Northwestern Circle', 'Wang Nam Yen', 39, 'GMC', 339, NULL, 'FURGONE', NULL, 6239, NULL),
('WC395CJ', 'Accord', 1998, 33691, true, 'Manuale', 1309, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 28, 'Buick', NULL, 35395, 'FURGONE', NULL, 6833, NULL),
('AN046SG', 'Cayman', 2012, 72196, true, 'Manuale', 1242, 'Diesel', '03531 Eastlawn Lane', 'Kyprínos', 93, 'Saab', 449, NULL, 'FURGONE', NULL, 4932, NULL);

INSERT INTO polizza VALUES
('KT9434', 'User-friendly 24 hour artificial intelligence', 10538243, 777, 'QG613BR'),
('DH4701', 'Mandatory discrete project', 6710266, 563, 'TV674FS'),
('EU8994', 'Persevering composite contingency', 7628568, 871, 'WV741YT'),
('TN9381', 'Vision-oriented upward-trending approach', 11196813, 584, 'BX345HC'),
('EG8993', 'Upgradable intermediate leverage', 8752748, 371, 'FN890WN'),
('XB6868', 'Profit-focused hybrid monitoring', 19144822, 639, 'BU100EL'),
('KC3986', 'Business-focused eco-centric matrices', 8691968, 72, 'EI429CG'),
('JO4534', 'Up-sized system-worthy product', 15244176, 827, 'NR781TW'),
('OA5707', 'Universal human-resource framework', 11749606, 130, 'LG070KV'),
('NF7230', 'Streamlined executive infrastructure', 15160114, 424, 'DE945DJ'),
('AI1823', 'Re-contextualized intermediate projection', 10669536, 991, 'FA966IV'),
('KF4009', 'Customer-focused actuating time-frame', 14496555, 491, 'DY375WP'),
('AH5021', 'Mandatory static process improvement', 9775369, 64, 'MV668SM'),
('WY3650', 'Compatible regional groupware', 15742087, 819, 'WK585IG'),
('VN2165', 'Future-proofed local customer loyalty', 8921619, 642, 'CL232MU'),
('XB3055', 'Universal national secured line', 11606007, 85, 'XX567XL'),
('JB9685', 'Enhanced global definition', 7059075, 320, 'RQ752TB'),
('FL9660', 'Enhanced empowering paradigm', 8748351, 370, 'JZ951ZV'),
('IY5415', 'Centralized intermediate portal', 10976079, 603, 'QD039OH'),
('XA4819', 'Future-proofed intermediate infrastructure', 11040235, 76, 'YP235LW'),
('SV8087', 'Innovative 6th generation functionalities', 9499925, 141, 'RG333AR'),
('SJ7915', 'Compatible scalable budgetary management', 5810141, 429, 'YE595LD'),
('XM1971', 'Re-contextualized upward-trending success', 5203276, 991, 'XM447OV'),
('PL6621', 'Enterprise-wide systematic parallelism', 11457396, 838, 'LG619NQ'),
('DA3416', 'Total logistical frame', 7777386, 402, 'WT712AG');

INSERT INTO noleggio VALUES
('1', '2021-07-20', '2022-10-03', 'QG613BR', 'MYWXWR60R27F733H', '15'),
('2', '2014-05-17', '2015-09-28', 'TV674FS', 'PCEYQP56O75F568D', '1'),
('3', '2021-08-27', '2023-02-12', 'WV741YT', 'MKVHRN09K78T127P', '19'),
('4', '2005-09-20', '2005-09-28', 'LG619NQ', 'EFXRBC33O71Y493Z', '3'),
('5', '2009-10-28', '2010-05-24', 'MV668SM', 'JVPISK44Y40F049B', '7'),
('6', '2021-07-20', '2023-02-18', 'XM447OV', 'NFFOLB76Y25M343V', '1'),
('7', '2021-10-22', '2022-10-21', 'RG333AR', 'MMULDD16G49N561X', '9'),
('8', '2017-09-24', '2020-09-24', 'MV668SM', 'YGOPRP75X80G302A', '18'),
('9', '2014-01-23', '2015-01-23', 'QD039OH', 'JVPISK44Y40F049B', '14'),
('10', '2019-09-06', '2020-10-24', 'LG070KV', 'VRSQHT76V59T281R', '13'),
('11', '2018-02-25', '2019-06-01', 'WT712AG', 'TSJPHL97P35G831I', '4'),
('12', '2021-03-03', '2023-03-23', 'LG619NQ', 'SDRYFM75G32A157H', '8'),
('13', '2015-02-18', '2022-07-03', 'XX567XL', 'CFDDIU53E90P414S', '3'),
('14', '2014-05-19', '2016-05-19', 'FA966IV', 'MKVHRN09K78T127P', '2'),
('15', '2002-12-23', '2003-01-07', 'WK585IG', 'MMULDD16G49N561X', '11'),
('16', '2009-03-06', '2010-05-10', 'YE595LD', 'ZYKUKW49P77O176S', '12'),
('17', '2013-11-10', '2014-08-29', 'XM447OV', 'NFFOLB76Y25M343V', '15'),
('18', '2002-05-24', '2002-06-05', 'TV674FS', 'MKVHRN09K78T127P', '17'),
('19', '2018-08-08', '2018-09-24', 'YP235LW', 'VRSQHT76V59T281R', '1'),
('20', '2017-06-11', '2018-11-09', 'MV668SM', 'LHFVOO46Y05X777Z', '9');

INSERT INTO acquisto VALUES
('1', '2012-11-30', 'WC395CJ', 'EFXRBC33O71Y493Z', '10'),
('2', '2004-03-01', 'QK547YC', 'NLRKLX70B04T482F', '8'),
('3', '2009-01-02', 'ZX041AL', 'NFFOLB76Y25M343V', '3'),
('4', '2004-11-02', 'PR568TE', 'VSOUYZ76G32H046N', '1'),
('5', '2004-09-26', 'XJ858RY', 'PWKMJS23W68Q347T', '18'),
('6', '2018-01-23', 'UE629TA', 'VSOUYZ76G32H046N', '20'),
('7', '2005-04-29', 'UV505BB', 'HRKUEB99Z37H176V', '5'),
('8', '2013-02-21', 'TQ003FR', 'VWQPWZ11A62S854P', '3'),
('9', '2013-10-25', 'VS956HK', 'HZJTVS68X33K590B', '2'),
('10', '2010-03-02', 'XB658EK', 'QJGRHQ64U95J443W', '8'),
('11', '2021-05-21', 'ED838DV', 'HZJTVS68X33K590B', '16'),
('12', '2020-06-02', 'IF561CB', 'OMPWJW04L87M229C', '12'),
('13', '2011-02-18', 'KD354QI', 'NLRKLX70B04T482F', '3'),
('14', '2003-01-06', 'JU237VE', 'TSJPHL97P35G831I', '9'),
('15', '2021-11-17', 'VJ296AW', 'COGIFU01E96P143P', '17'),
('16', '2008-01-22', 'TR321ZV', 'HRKUEB99Z37H176V', '7'),
('17', '2002-03-21', 'RF585AZ', 'VWQPWZ11A62S854P', '16'),
('18', '2018-11-24', 'WM196TI', 'JVPISK44Y40F049B', '19'),
('19', '2003-04-27', 'AS689NK', 'QTOEHE30B14R971P', '20'),
('20', '2015-01-12', 'XP889ZR', 'BAKDFQ87U68B707M', '1');