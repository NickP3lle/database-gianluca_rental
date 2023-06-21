--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.2

-- Started on 2023-06-20 23:08:00 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3681 (class 1262 OID 17862)
-- Name: concessionaria_autonoleggio; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE concessionaria_autonoleggio WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE concessionaria_autonoleggio OWNER TO postgres;

\connect concessionaria_autonoleggio

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 845 (class 1247 OID 17864)
-- Name: catveicolo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.catveicolo AS ENUM (
    'AUTO',
    'MOTO',
    'FURGONE'
);


ALTER TYPE public.catveicolo OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17956)
-- Name: acquisto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acquisto (
    codice character varying(10) NOT NULL,
    data_acquisto date NOT NULL,
    targa character varying(7) NOT NULL,
    cf character varying(16) NOT NULL,
    id_lavoratore character varying(3) NOT NULL
);


ALTER TABLE public.acquisto OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17909)
-- Name: autoveicolo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autoveicolo (
    targa character varying(7) NOT NULL,
    modello character varying(255) NOT NULL,
    anno integer NOT NULL,
    km integer NOT NULL,
    lusso boolean NOT NULL,
    cambio character varying(255) NOT NULL,
    cilindrata integer NOT NULL,
    carburante character varying(255) NOT NULL,
    indirizzo_parcheggio character varying(255) NOT NULL,
    citta_parcheggio character varying(255) NOT NULL,
    posto_parcheggio integer NOT NULL,
    marca character varying(255) NOT NULL,
    prezzo_giornaliero integer,
    prezzo integer,
    tipo_veicolo public.catveicolo NOT NULL,
    motociclo boolean,
    carico_massimo integer,
    posti_passeggeri integer
);


ALTER TABLE public.autoveicolo OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17871)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cf character varying(16) NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    sesso character varying(1) NOT NULL,
    email character varying(255),
    telefono character varying(12) NOT NULL,
    inizio_cliente date NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17895)
-- Name: fornitore; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornitore (
    nome character varying(255) NOT NULL,
    indirizzo character varying(255) NOT NULL,
    citta character varying(255) NOT NULL
);


ALTER TABLE public.fornitore OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17888)
-- Name: lavoratore; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lavoratore (
    id character varying(3) NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    contratto character varying(255) NOT NULL
);


ALTER TABLE public.lavoratore OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17936)
-- Name: noleggio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.noleggio (
    codice character varying(10) NOT NULL,
    data_inizio date NOT NULL,
    data_fine date NOT NULL,
    targa character varying(7) NOT NULL,
    cf character varying(16) NOT NULL,
    id_lavoratore character varying(3) NOT NULL,
    CONSTRAINT noleggio_check CHECK ((data_inizio <= data_fine))
);


ALTER TABLE public.noleggio OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17902)
-- Name: parcheggio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parcheggio (
    indirizzo character varying(255) NOT NULL,
    citta character varying(255) NOT NULL,
    posti_totali integer NOT NULL
);


ALTER TABLE public.parcheggio OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17878)
-- Name: patente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patente (
    numpatente character varying(10) NOT NULL,
    data_rilascio date NOT NULL,
    data_scadenza date NOT NULL,
    tipo character varying(3) NOT NULL,
    cf character varying(16) NOT NULL
);


ALTER TABLE public.patente OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17926)
-- Name: polizza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.polizza (
    numero_polizza character varying(12) NOT NULL,
    tipo character varying(255) NOT NULL,
    massimale integer NOT NULL,
    franchigia integer NOT NULL,
    targa character varying(7) NOT NULL
);


ALTER TABLE public.polizza OWNER TO postgres;

--
-- TOC entry 3675 (class 0 OID 17956)
-- Dependencies: 222
-- Data for Name: acquisto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.acquisto VALUES ('1', '2012-11-30', 'WC395CJ', 'EFXRBC33O71Y493Z', '10');
INSERT INTO public.acquisto VALUES ('2', '2004-03-01', 'QK547YC', 'NLRKLX70B04T482F', '8');
INSERT INTO public.acquisto VALUES ('3', '2009-01-02', 'ZX041AL', 'NFFOLB76Y25M343V', '3');
INSERT INTO public.acquisto VALUES ('4', '2004-11-02', 'PR568TE', 'VSOUYZ76G32H046N', '1');
INSERT INTO public.acquisto VALUES ('5', '2004-09-26', 'XJ858RY', 'PWKMJS23W68Q347T', '18');
INSERT INTO public.acquisto VALUES ('6', '2018-01-23', 'UE629TA', 'VSOUYZ76G32H046N', '20');
INSERT INTO public.acquisto VALUES ('7', '2005-04-29', 'UV505BB', 'HRKUEB99Z37H176V', '5');
INSERT INTO public.acquisto VALUES ('8', '2013-02-21', 'TQ003FR', 'VWQPWZ11A62S854P', '3');
INSERT INTO public.acquisto VALUES ('9', '2013-10-25', 'VS956HK', 'HZJTVS68X33K590B', '2');
INSERT INTO public.acquisto VALUES ('10', '2010-03-02', 'XB658EK', 'QJGRHQ64U95J443W', '8');
INSERT INTO public.acquisto VALUES ('11', '2021-05-21', 'ED838DV', 'HZJTVS68X33K590B', '16');
INSERT INTO public.acquisto VALUES ('12', '2020-06-02', 'IF561CB', 'OMPWJW04L87M229C', '12');
INSERT INTO public.acquisto VALUES ('13', '2011-02-18', 'KD354QI', 'NLRKLX70B04T482F', '3');
INSERT INTO public.acquisto VALUES ('14', '2003-01-06', 'JU237VE', 'TSJPHL97P35G831I', '9');
INSERT INTO public.acquisto VALUES ('15', '2021-11-17', 'VJ296AW', 'COGIFU01E96P143P', '17');
INSERT INTO public.acquisto VALUES ('16', '2008-01-22', 'TR321ZV', 'HRKUEB99Z37H176V', '7');
INSERT INTO public.acquisto VALUES ('17', '2002-03-21', 'RF585AZ', 'VWQPWZ11A62S854P', '16');
INSERT INTO public.acquisto VALUES ('18', '2018-11-24', 'WM196TI', 'JVPISK44Y40F049B', '19');
INSERT INTO public.acquisto VALUES ('19', '2003-04-27', 'AS689NK', 'QTOEHE30B14R971P', '20');
INSERT INTO public.acquisto VALUES ('20', '2015-01-12', 'XP889ZR', 'BAKDFQ87U68B707M', '1');


--
-- TOC entry 3672 (class 0 OID 17909)
-- Dependencies: 219
-- Data for Name: autoveicolo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.autoveicolo VALUES ('QG613BR', 'SC', 1993, 115240, true, 'Manuale', 4940, 'Benzina', '9 Northfield Parkway', 'Zougang', 57, 'Volkswagen', 280, NULL, 'AUTO', NULL, NULL, 6);
INSERT INTO public.autoveicolo VALUES ('TV674FS', 'Sierra 2500', 2002, 59672, false, 'Manuale', 4755, 'Diesel', '80 Texas Road', 'Cochabamba', 12, 'GMC', 382, NULL, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('WV741YT', 'MKZ', 2007, 48471, false, 'Manuale', 3085, 'Benzina', '6 Northwestern Circle', 'Wang Nam Yen', 65, 'Lincoln', 258, NULL, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('BX345HC', 'Tribute', 2003, 36269, false, 'Manuale', 3448, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 11, 'Pontiac', 22, NULL, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('NF738BM', 'Prelude', 1992, 52375, false, 'Manuale', 3389, 'Benzina', '03531 Eastlawn Lane', 'Kyprínos', 9, 'Honda', NULL, 74075, 'AUTO', NULL, NULL, 4);
INSERT INTO public.autoveicolo VALUES ('XP889ZR', 'Impreza', 2011, 98099, false, 'Manuale', 4940, 'Diesel', '0342 Kensington Hill', 'Limoges', 14, 'Saab', NULL, 28309, 'AUTO', NULL, NULL, 4);
INSERT INTO public.autoveicolo VALUES ('AS689NK', 'Ram 3500', 2009, 25519, false, 'Manuale', 1770, 'Benzina', '8 Vera Place', 'Funaishikawa', 87, 'Dodge', NULL, 77453, 'AUTO', NULL, NULL, 6);
INSERT INTO public.autoveicolo VALUES ('FN890WN', 'SL-Class', 2008, 44415, false, 'Manuale', 1369, 'Metano', '536 Thierer Terrace', 'Waihi Beach', 30, 'Mercedes-Benz', 365, NULL, 'AUTO', NULL, NULL, 4);
INSERT INTO public.autoveicolo VALUES ('WM196TI', 'XC90', 2006, 96796, false, 'Manuale', 3794, 'Benzina', '1889 3rd Alley', 'Valleymount', 42, 'Volvo', NULL, 38178, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('RF585AZ', '98', 1992, 54164, true, 'Manuale', 1879, 'Diesel', '50758 La Follette Alley', 'Saint Hubert', 65, 'Oldsmobile', NULL, 37584, 'AUTO', NULL, NULL, 7);
INSERT INTO public.autoveicolo VALUES ('BU100EL', 'Rodeo', 1995, 88128, false, 'Manuale', 907, 'GPL', '21284 Mifflin Road', 'Lidköping', 24, 'Infiniti', 473, NULL, 'AUTO', NULL, NULL, 7);
INSERT INTO public.autoveicolo VALUES ('TR321ZV', 'Savana 2500', 1996, 34818, true, 'Manuale', 4477, 'Benzina', '171 Del Mar Pass', 'Bagay', 44, 'GMC', NULL, 64778, 'AUTO', NULL, NULL, 3);
INSERT INTO public.autoveicolo VALUES ('EI429CG', 'Lancer Evolution', 2002, 125340, true, 'Automatico', 4460, 'Diesel', '1 Tennessee Avenue', 'Mlonggo', 13, 'Jeep', 304, NULL, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('NR781TW', 'I', 2004, 76459, false, 'Automatico', 1564, 'Metano', '23 Bultman Pass', 'Messina', 58, 'Infiniti', 90, NULL, 'AUTO', NULL, NULL, 7);
INSERT INTO public.autoveicolo VALUES ('VJ296AW', 'Crown Victoria', 2007, 2366, true, 'Automatico', 1957, 'Benzina', '7 Dakota Point', 'Anolaima', 68, 'Ford', NULL, 94262, 'AUTO', NULL, NULL, 4);
INSERT INTO public.autoveicolo VALUES ('LG070KV', 'Suburban 2500', 1996, 114413, true, 'Automatico', 3352, 'Diesel', '9 Northfield Parkway', 'Zougang', 67, 'Chevrolet', 437, NULL, 'AUTO', NULL, NULL, 7);
INSERT INTO public.autoveicolo VALUES ('JU237VE', 'Durango', 2009, 138749, false, 'Automatico', 2422, 'Metano', '80 Texas Road', 'Cochabamba', 1, 'Dodge', NULL, 92447, 'AUTO', NULL, NULL, 7);
INSERT INTO public.autoveicolo VALUES ('DE945DJ', 'S-Series', 1997, 149524, false, 'Automatico', 2708, 'Benzina', '6 Northwestern Circle', 'Wang Nam Yen', 41, 'Alfa Romeo', 75, NULL, 'AUTO', NULL, NULL, 6);
INSERT INTO public.autoveicolo VALUES ('FA966IV', 'QX', 2009, 24900, true, 'Automatico', 4188, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 12, 'Infiniti', 398, NULL, 'AUTO', NULL, NULL, 6);
INSERT INTO public.autoveicolo VALUES ('KD354QI', 'SL-Class', 2000, 14845, false, 'Automatico', 3433, 'Diesel', '03531 Eastlawn Lane', 'Kyprínos', 57, 'Mercedes-Benz', NULL, 89431, 'AUTO', NULL, NULL, 3);
INSERT INTO public.autoveicolo VALUES ('IF561CB', 'Jetta', 1998, 65308, false, 'Sequenziale', 3049, 'Benzina', '0342 Kensington Hill', 'Limoges', 3, 'Porsche', NULL, 54069, 'AUTO', NULL, NULL, 5);
INSERT INTO public.autoveicolo VALUES ('JO483SW', 'XK Series', 2000, 6832, false, 'Sequenziale', 3284, 'Diesel', '8 Vera Place', 'Funaishikawa', 39, 'Buick', NULL, 33541, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('ED838DV', 'A6', 2007, 147773, true, 'Sequenziale', 4888, 'Benzina', '536 Thierer Terrace', 'Waihi Beach', 22, 'Audi', NULL, 55005, 'AUTO', NULL, NULL, 9);
INSERT INTO public.autoveicolo VALUES ('DY375WP', '911', 2004, 52371, true, 'Sequenziale', 4575, 'Benzina', '1889 3rd Alley', 'Valleymount', 45, 'Porsche', 715, NULL, 'AUTO', NULL, NULL, 6);
INSERT INTO public.autoveicolo VALUES ('MV668SM', 'Avalanche', 2012, 25898, true, 'Sequenziale', 3692, 'GPL', '50758 La Follette Alley', 'Saint Hubert', 56, 'Chevrolet', 164, NULL, 'AUTO', NULL, NULL, 4);
INSERT INTO public.autoveicolo VALUES ('WK585IG', 'Vibe', 2004, 132444, false, 'Sequenziale', 2842, 'Benzina', '21284 Mifflin Road', 'Lidköping', 7, 'Pontiac', 154, NULL, 'AUTO', NULL, NULL, 7);
INSERT INTO public.autoveicolo VALUES ('CL232MU', 'B-Series', 1997, 57197, true, 'Sequenziale', 2688, 'Benzina', '171 Del Mar Pass', 'Bagay', 19, 'Maserati', 402, NULL, 'AUTO', NULL, NULL, 3);
INSERT INTO public.autoveicolo VALUES ('XB658EK', 'Fifth Ave', 1993, 91888, true, 'Sequenziale', 4044, 'Benzina', '1 Tennessee Avenue', 'Mlonggo', 3, 'Mercury', NULL, 32122, 'AUTO', NULL, NULL, 8);
INSERT INTO public.autoveicolo VALUES ('VS956HK', 'Explorer', 2007, 103, false, 'Sequenziale', 4003, 'Benzina', '23 Bultman Pass', 'Messina', 31, 'Ford', NULL, 83626, 'AUTO', NULL, NULL, 4);
INSERT INTO public.autoveicolo VALUES ('XX567XL', 'Discovery Series II', 1999, 88867, false, 'Automatico', 1200, 'Benzina', '7 Dakota Point', 'Anolaima', 43, 'Eagle', 71, NULL, 'MOTO', true, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('RQ752TB', 'Envoy', 2002, 115719, true, 'Automatico', 900, 'Benzina', '9 Northfield Parkway', 'Zougang', 15, 'GMC', 81, NULL, 'MOTO', true, NULL, 1);
INSERT INTO public.autoveicolo VALUES ('JZ951ZV', 'TL', 2004, 64407, true, 'Automatico', 750, 'Diesel', '80 Texas Road', 'Cochabamba', 37, 'Cadillac', 74, NULL, 'MOTO', true, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('TQ003FR', '4Runner', 2009, 35236, false, 'Automatico', 125, 'Benzina', '6 Northwestern Circle', 'Wang Nam Yen', 9, 'Toyota', NULL, 53775, 'MOTO', false, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('UV505BB', 'Metro', 2000, 67697, false, 'Automatico', 50, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 22, 'Honda', NULL, 59181, 'MOTO', false, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('QD039OH', 'Thunderbird', 1989, 14228, true, 'Automatico', 50, 'Diesel', '03531 Eastlawn Lane', 'Kyprínos', 79, 'Ford', 70, NULL, 'MOTO', false, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('UE629TA', 'GTO', 1969, 131865, true, 'Automatico', 50, 'Benzina', '0342 Kensington Hill', 'Limoges', 20, 'Pontiac', NULL, 59650, 'MOTO', false, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('YP235LW', 'Dakota Club', 1993, 48669, false, 'Sequenziale', 125, 'Diesel', '8 Vera Place', 'Funaishikawa', 80, 'Dodge', 136, NULL, 'MOTO', false, NULL, 1);
INSERT INTO public.autoveicolo VALUES ('XJ858RY', 'XJ Series', 2005, 7501, true, 'Sequenziale', 315, 'Diesel', '536 Thierer Terrace', 'Waihi Beach', 48, 'Honda', NULL, 53688, 'MOTO', true, NULL, 1);
INSERT INTO public.autoveicolo VALUES ('PR568TE', 'Grand Caravan', 2000, 93970, false, 'Sequenziale', 900, 'Benzina', '1889 3rd Alley', 'Valleymount', 61, 'Dodge', NULL, 90941, 'MOTO', true, NULL, 1);
INSERT INTO public.autoveicolo VALUES ('RG333AR', 'Probe', 1990, 96362, false, 'Sequenziale', 250, 'Diesel', '50758 La Follette Alley', 'Saint Hubert', 14, 'Ford', 420, NULL, 'MOTO', true, NULL, 2);
INSERT INTO public.autoveicolo VALUES ('ZX041AL', 'Silverado 1500', 2006, 125615, true, 'Sequenziale', 1200, 'Benzina', '21284 Mifflin Road', 'Lidköping', 9, 'Chevrolet', NULL, 56695, 'MOTO', true, NULL, 1);
INSERT INTO public.autoveicolo VALUES ('DC106UD', 'Boxster', 2004, 94192, true, 'Automatico', 2167, 'Benzina', '171 Del Mar Pass', 'Bagay', 6, 'Saab', NULL, 81308, 'FURGONE', NULL, 4412, NULL);
INSERT INTO public.autoveicolo VALUES ('UD710MV', 'Accord', 2003, 64184, false, 'Automatico', 2940, 'Diesel', '1 Tennessee Avenue', 'Mlonggo', 1, 'Buick', NULL, 84238, 'FURGONE', NULL, 4470, NULL);
INSERT INTO public.autoveicolo VALUES ('YE595LD', 'Yukon XL 2500', 2007, 148127, false, 'Automatico', 3667, 'Benzina', '23 Bultman Pass', 'Messina', 62, 'GMC', 235, NULL, 'FURGONE', NULL, 6482, NULL);
INSERT INTO public.autoveicolo VALUES ('QK547YC', 'IPL G', 2011, 27903, false, 'Automatico', 4671, 'Benzina', '7 Dakota Point', 'Anolaima', 58, 'Infiniti', NULL, 94471, 'FURGONE', NULL, 6989, NULL);
INSERT INTO public.autoveicolo VALUES ('XM447OV', 'Mystique', 1998, 58103, false, 'Automatico', 4784, 'Benzina', '9 Northfield Parkway', 'Zougang', 53, 'Mercury', 257, NULL, 'FURGONE', NULL, 6359, NULL);
INSERT INTO public.autoveicolo VALUES ('LG619NQ', 'Cooper', 2012, 71001, true, 'Manuale', 4963, 'Benzina', '80 Texas Road', 'Cochabamba', 9, 'Volvo', 375, NULL, 'FURGONE', NULL, 5058, NULL);
INSERT INTO public.autoveicolo VALUES ('WT712AG', 'Sierra', 2008, 54325, false, 'Manuale', 3129, 'Diesel', '6 Northwestern Circle', 'Wang Nam Yen', 39, 'GMC', 339, NULL, 'FURGONE', NULL, 6239, NULL);
INSERT INTO public.autoveicolo VALUES ('WC395CJ', 'Accord', 1998, 33691, true, 'Manuale', 1309, 'Diesel', '231 Oakridge Alley', 'Jiazhuyuan', 28, 'Buick', NULL, 35395, 'FURGONE', NULL, 6833, NULL);
INSERT INTO public.autoveicolo VALUES ('AN046SG', 'Cayman', 2012, 72196, true, 'Manuale', 1242, 'Diesel', '03531 Eastlawn Lane', 'Kyprínos', 93, 'Saab', 449, NULL, 'FURGONE', NULL, 4932, NULL);


--
-- TOC entry 3667 (class 0 OID 17871)
-- Dependencies: 214
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES ('TSJPHL97P35G831I', 'Lita', 'Morgans', 'F', NULL, '406 576 7923', '2006-06-17');
INSERT INTO public.cliente VALUES ('HZJTVS68X33K590B', 'Dredi', 'Robey', 'F', 'drobey1@engadget.com', '843 876 2716', '2003-08-06');
INSERT INTO public.cliente VALUES ('EFXRBC33O71Y493Z', 'Pattin', 'Kermeen', 'M', 'pkermeen2@pagesperso-orange.fr', '639 413 9976', '2014-06-16');
INSERT INTO public.cliente VALUES ('BAKDFQ87U68B707M', 'Zulema', 'Stenhouse', 'F', 'zstenhouse3@loc.gov', '414 666 8595', '2011-02-11');
INSERT INTO public.cliente VALUES ('MYWXWR60R27F733H', 'Gabe', 'Blowfield', 'M', 'gblowfield4@howstuffworks.com', '208 333 1351', '2017-08-06');
INSERT INTO public.cliente VALUES ('ZBFXOZ29V61O596V', 'Isidor', 'Grant', 'M', 'igrant5@mlb.com', '450 437 4992', '2021-11-01');
INSERT INTO public.cliente VALUES ('NEXGWP48B09A248Y', 'Aloysius', 'McGurn', 'M', 'amcgurn6@arstechnica.com', '299 946 5521', '2004-09-10');
INSERT INTO public.cliente VALUES ('TNKRQM98H48R236H', 'Jess', 'McAnellye', 'F', 'jmcanellye7@phpbb.com', '837 775 1454', '2004-04-15');
INSERT INTO public.cliente VALUES ('AUCIYU39G06O833V', 'Edmund', 'Pidgeley', 'M', 'epidgeley8@unesco.org', '949 613 5643', '2010-03-19');
INSERT INTO public.cliente VALUES ('HRKUEB99Z37H176V', 'Cassy', 'McCormick', 'F', 'cmccormick9@admin.ch', '130 622 6576', '2007-08-15');
INSERT INTO public.cliente VALUES ('OMPWJW04L87M229C', 'Brook', 'Wanklin', 'F', 'bwanklina@meetup.com', '848 590 8507', '2006-02-20');
INSERT INTO public.cliente VALUES ('CFYDLL19I85M469F', 'Hanni', 'Gotter', 'F', NULL, '854 790 0953', '2006-01-31');
INSERT INTO public.cliente VALUES ('JJYVQV80F70J976H', 'Gordon', 'Aldington', 'M', 'galdingtonc@imdb.com', '728 296 1030', '2011-04-13');
INSERT INTO public.cliente VALUES ('ZUIWSN90B32P200V', 'Land', 'Twoohy', 'M', NULL, '427 603 3419', '2020-09-21');
INSERT INTO public.cliente VALUES ('YGOPRP75X80G302A', 'Jonathan', 'Mussard', 'M', 'jmussarde@aboutads.info', '682 765 3211', '2005-10-11');
INSERT INTO public.cliente VALUES ('PCEYQP56O75F568D', 'Loren', 'Farran', 'F', 'lfarranf@dropbox.com', '431 335 5976', '2008-02-15');
INSERT INTO public.cliente VALUES ('XZKXBT99E53M443W', 'Franni', 'Clint', 'F', 'fclintg@dailymail.co.uk', '776 967 9518', '2004-10-31');
INSERT INTO public.cliente VALUES ('NLRKLX70B04T482F', 'Prent', 'Elliff', 'M', NULL, '804 640 9962', '2023-02-02');
INSERT INTO public.cliente VALUES ('SDRYFM75G32A157H', 'Asa', 'Parmer', 'M', 'aparmeri@symantec.com', '691 679 8937', '2008-02-13');
INSERT INTO public.cliente VALUES ('BYCHDG64H24K119Y', 'Nichols', 'Blore', 'M', 'nblorej@aol.com', '761 708 7036', '2009-05-15');
INSERT INTO public.cliente VALUES ('EGSAFY87L48P287X', 'Emelda', 'Yerrington', 'F', 'eyerringtonk@seattletimes.com', '505 296 8317', '2000-01-30');
INSERT INTO public.cliente VALUES ('NKIUML24J11Q923R', 'Free', 'Gimblett', 'M', 'fgimblettl@blinklist.com', '261 380 0768', '2009-05-16');
INSERT INTO public.cliente VALUES ('JVPISK44Y40F049B', 'Kale', 'Grzes', 'M', 'kgrzesm@archive.org', '918 788 2462', '2009-08-31');
INSERT INTO public.cliente VALUES ('LHFVOO46Y05X777Z', 'Ulrike', 'Causley', 'F', 'ucausleyn@sfgate.com', '290 597 5463', '2017-05-20');
INSERT INTO public.cliente VALUES ('COGIFU01E96P143P', 'Ferrell', 'Jackman', 'M', 'fjackmano@unesco.org', '874 169 2665', '2001-11-28');
INSERT INTO public.cliente VALUES ('MKVHRN09K78T127P', 'Malina', 'Gridley', 'F', 'mgridleyp@flavors.me', '914 595 4984', '2020-08-23');
INSERT INTO public.cliente VALUES ('VRSQHT76V59T281R', 'Hortensia', 'Taylour', 'F', 'htaylourq@barnesandnoble.com', '359 766 3852', '2009-07-27');
INSERT INTO public.cliente VALUES ('NFFOLB76Y25M343V', 'Parnell', 'Mosedale', 'M', 'pmosedaler@technorati.com', '529 613 4195', '2015-04-30');
INSERT INTO public.cliente VALUES ('CFDDIU53E90P414S', 'Brigid', 'Maus', 'F', 'bmauss@feedburner.com', '829 539 2470', '2016-05-26');
INSERT INTO public.cliente VALUES ('PWKMJS23W68Q347T', 'Margalit', 'Glavis', 'F', NULL, '243 832 1484', '2022-09-15');
INSERT INTO public.cliente VALUES ('YULQKQ73P86X286L', 'Clayson', 'Packham', 'M', 'cpackhamu@elegantthemes.com', '888 735 0431', '2021-07-03');
INSERT INTO public.cliente VALUES ('ZYKUKW49P77O176S', 'Ronald', 'McShane', 'M', NULL, '442 154 2699', '2016-10-24');
INSERT INTO public.cliente VALUES ('MMULDD16G49N561X', 'Carley', 'Winston', 'F', 'cwinstonw@fema.gov', '872 794 6974', '2018-10-04');
INSERT INTO public.cliente VALUES ('GRMGCW50Z30K624F', 'Steffen', 'Dunnan', 'M', 'sdunnanx@bravesites.com', '940 959 1873', '2020-12-23');
INSERT INTO public.cliente VALUES ('QTOEHE30B14R971P', 'Marvin', 'Crier', 'M', 'mcriery@bbc.co.uk', '121 152 0276', '2013-06-08');
INSERT INTO public.cliente VALUES ('ZREIWH07F35O917Q', 'Elberta', 'Bowry', 'F', 'ebowryz@webeden.co.uk', '164 808 5674', '2015-11-05');
INSERT INTO public.cliente VALUES ('VSOUYZ76G32H046N', 'Roxanne', 'Bartley', 'F', NULL, '126 480 1921', '2009-08-18');
INSERT INTO public.cliente VALUES ('BSJGVG58P59M263N', 'Kerk', 'McTeer', 'M', NULL, '126 760 6570', '2022-04-07');
INSERT INTO public.cliente VALUES ('VWQPWZ11A62S854P', 'Melanie', 'Benito', 'F', 'mbenito12@businessweek.com', '327 782 5299', '2019-07-07');
INSERT INTO public.cliente VALUES ('QJGRHQ64U95J443W', 'Frederich', 'Hanselman', 'M', 'fhanselman13@twitter.com', '551 929 4137', '2011-05-22');


--
-- TOC entry 3670 (class 0 OID 17895)
-- Dependencies: 217
-- Data for Name: fornitore; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fornitore VALUES ('Dodge', '2604 Sutteridge Drive', 'Tempe');
INSERT INTO public.fornitore VALUES ('Mercury', '595 Atwood Way', 'Suresnes');
INSERT INTO public.fornitore VALUES ('Ford', '86 Columbus Center', 'Hengfan');
INSERT INTO public.fornitore VALUES ('Nissan', '63662 Dorton Pass', 'Tagiura');
INSERT INTO public.fornitore VALUES ('Jeep', '12830 Ridge Oak Drive', 'Wirodayan');
INSERT INTO public.fornitore VALUES ('Buick', '9517 Raven Center', 'Pho Thale');
INSERT INTO public.fornitore VALUES ('Cadillac', '5 Cottonwood Lane', 'Nevel');
INSERT INTO public.fornitore VALUES ('Audi', '2 Graedel Terrace', 'Minneapolis');
INSERT INTO public.fornitore VALUES ('Hyundai', '6 Clarendon Parkway', 'Rešetari');
INSERT INTO public.fornitore VALUES ('Chevrolet', '64 Pepper Wood Terrace', 'Mulchén');
INSERT INTO public.fornitore VALUES ('Infiniti', '1012 Farmco Alley', 'Luleå');
INSERT INTO public.fornitore VALUES ('Shelby', '9052 Columbus Alley', 'Lenningen');
INSERT INTO public.fornitore VALUES ('Porsche', '9052 Columbus Alley', 'Lenningen');
INSERT INTO public.fornitore VALUES ('Saab', '551 Jackson Circle', 'Volodars’k-Volyns’kyy');
INSERT INTO public.fornitore VALUES ('Honda', '615 Gateway Terrace', 'Pueblo Nuevo');
INSERT INTO public.fornitore VALUES ('Oldsmobile', '56 Arrowood Circle', 'Wilamowice');
INSERT INTO public.fornitore VALUES ('Volvo', '7 Mallory Pass', 'Sukakarya');
INSERT INTO public.fornitore VALUES ('Spyker', '63 North Court', 'Suka Makmue');
INSERT INTO public.fornitore VALUES ('Mustang', '4310 Manitowish Crossing', 'Vallehermoso');
INSERT INTO public.fornitore VALUES ('Mercedes-Benz', '0 Brown Street', 'Fengyi');
INSERT INTO public.fornitore VALUES ('Infinity', '0 Banding Hill', 'Xidajie');
INSERT INTO public.fornitore VALUES ('Pagani', '832 Havey Court', 'Al Majāridah');
INSERT INTO public.fornitore VALUES ('Ferrari', '953 Brickson Park Place', 'Loreto');
INSERT INTO public.fornitore VALUES ('Lotus', '5184 Nova Parkway', 'Tbêng Méanchey');
INSERT INTO public.fornitore VALUES ('Koenigsegg', '4819 Sommers Trail', 'Coyaima');
INSERT INTO public.fornitore VALUES ('Toyota', '9085 Russell Court', 'Nancang');
INSERT INTO public.fornitore VALUES ('Alfa Romeo', '28 Pierstorff Pass', 'Lingbei');
INSERT INTO public.fornitore VALUES ('Lamborghini', '21 Texas Way', 'Tayug');
INSERT INTO public.fornitore VALUES ('Volkswagen', '82804 Autumn Leaf Junction', 'Lao Suea Kok');
INSERT INTO public.fornitore VALUES ('Pontiac', '6 Erie Alley', 'Ardabīl');
INSERT INTO public.fornitore VALUES ('Bugatti', '8127 Cascade Park', 'Myronivka');
INSERT INTO public.fornitore VALUES ('Maserati', '508 Westport Parkway', 'Fulong');
INSERT INTO public.fornitore VALUES ('Eagle', '29223 Norway Maple Court', 'Sritanjung');
INSERT INTO public.fornitore VALUES ('GMC', '20223 Ridge Oak Drive', 'Sukakarya');
INSERT INTO public.fornitore VALUES ('Lincoln', '462 North Court', 'Fengyi');


--
-- TOC entry 3669 (class 0 OID 17888)
-- Dependencies: 216
-- Data for Name: lavoratore; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lavoratore VALUES ('1', 'Von', 'Pawsey', 'DIRIGENTE');
INSERT INTO public.lavoratore VALUES ('2', 'Elsinore', 'Oswell', 'DIRIGENTE');
INSERT INTO public.lavoratore VALUES ('3', 'Kermie', 'Smaling', 'DIRIGENTE');
INSERT INTO public.lavoratore VALUES ('4', 'Konstanze', 'Edgeon', 'RESPONSABILE');
INSERT INTO public.lavoratore VALUES ('5', 'Raquela', 'Leinweber', 'RESPONSABILE');
INSERT INTO public.lavoratore VALUES ('6', 'Birk', 'Muddiman', 'RESPONSABILE');
INSERT INTO public.lavoratore VALUES ('7', 'Ab', 'Augustus', 'RESPONSABILE');
INSERT INTO public.lavoratore VALUES ('8', 'Lucienne', 'Suttie', 'RESPONSABILE');
INSERT INTO public.lavoratore VALUES ('9', 'Kristian', 'Twoohy', 'RESPONSABILE');
INSERT INTO public.lavoratore VALUES ('10', 'Cinnamon', 'Kidston', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('11', 'Henri', 'Kermitt', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('12', 'Candis', 'Pedgrift', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('13', 'Peggie', 'Fookes', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('14', 'Erwin', 'Mosson', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('15', 'Sanson', 'O Growgane', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('16', 'Rosemaria', 'Slaght', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('17', 'Earle', 'Kyd', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('18', 'Alice', 'Cheesman', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('19', 'Doy', 'Blant', 'DIPENDENTE');
INSERT INTO public.lavoratore VALUES ('20', 'Gustie', 'Choulerton', 'DIPENDENTE');


--
-- TOC entry 3674 (class 0 OID 17936)
-- Dependencies: 221
-- Data for Name: noleggio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.noleggio VALUES ('1', '2021-07-20', '2022-10-03', 'QG613BR', 'MYWXWR60R27F733H', '15');
INSERT INTO public.noleggio VALUES ('2', '2014-05-17', '2015-09-28', 'TV674FS', 'PCEYQP56O75F568D', '1');
INSERT INTO public.noleggio VALUES ('3', '2021-08-27', '2023-02-12', 'WV741YT', 'MKVHRN09K78T127P', '19');
INSERT INTO public.noleggio VALUES ('4', '2005-09-20', '2005-09-28', 'LG619NQ', 'EFXRBC33O71Y493Z', '3');
INSERT INTO public.noleggio VALUES ('5', '2009-10-28', '2010-05-24', 'MV668SM', 'JVPISK44Y40F049B', '7');
INSERT INTO public.noleggio VALUES ('6', '2021-07-20', '2023-02-18', 'XM447OV', 'NFFOLB76Y25M343V', '1');
INSERT INTO public.noleggio VALUES ('7', '2021-10-22', '2022-10-21', 'RG333AR', 'MMULDD16G49N561X', '9');
INSERT INTO public.noleggio VALUES ('8', '2017-09-24', '2020-09-24', 'MV668SM', 'YGOPRP75X80G302A', '18');
INSERT INTO public.noleggio VALUES ('9', '2014-01-23', '2015-01-23', 'QD039OH', 'JVPISK44Y40F049B', '14');
INSERT INTO public.noleggio VALUES ('10', '2019-09-06', '2020-10-24', 'LG070KV', 'VRSQHT76V59T281R', '13');
INSERT INTO public.noleggio VALUES ('11', '2018-02-25', '2019-06-01', 'WT712AG', 'TSJPHL97P35G831I', '4');
INSERT INTO public.noleggio VALUES ('12', '2021-03-03', '2023-03-23', 'LG619NQ', 'SDRYFM75G32A157H', '8');
INSERT INTO public.noleggio VALUES ('13', '2015-02-18', '2022-07-03', 'XX567XL', 'CFDDIU53E90P414S', '3');
INSERT INTO public.noleggio VALUES ('14', '2014-05-19', '2016-05-19', 'FA966IV', 'MKVHRN09K78T127P', '2');
INSERT INTO public.noleggio VALUES ('15', '2002-12-23', '2003-01-07', 'WK585IG', 'MMULDD16G49N561X', '11');
INSERT INTO public.noleggio VALUES ('16', '2009-03-06', '2010-05-10', 'YE595LD', 'ZYKUKW49P77O176S', '12');
INSERT INTO public.noleggio VALUES ('17', '2013-11-10', '2014-08-29', 'XM447OV', 'NFFOLB76Y25M343V', '15');
INSERT INTO public.noleggio VALUES ('18', '2002-05-24', '2002-06-05', 'TV674FS', 'MKVHRN09K78T127P', '17');
INSERT INTO public.noleggio VALUES ('19', '2018-08-08', '2018-09-24', 'YP235LW', 'VRSQHT76V59T281R', '1');
INSERT INTO public.noleggio VALUES ('20', '2017-06-11', '2018-11-09', 'MV668SM', 'LHFVOO46Y05X777Z', '9');


--
-- TOC entry 3671 (class 0 OID 17902)
-- Dependencies: 218
-- Data for Name: parcheggio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.parcheggio VALUES ('7 Dakota Point', 'Anolaima', 83);
INSERT INTO public.parcheggio VALUES ('23 Bultman Pass', 'Messina', 62);
INSERT INTO public.parcheggio VALUES ('1 Tennessee Avenue', 'Mlonggo', 23);
INSERT INTO public.parcheggio VALUES ('171 Del Mar Pass', 'Bagay', 67);
INSERT INTO public.parcheggio VALUES ('21284 Mifflin Road', 'Lidköping', 31);
INSERT INTO public.parcheggio VALUES ('50758 La Follette Alley', 'Saint Hubert', 79);
INSERT INTO public.parcheggio VALUES ('1889 3rd Alley', 'Valleymount', 61);
INSERT INTO public.parcheggio VALUES ('536 Thierer Terrace', 'Waihi Beach', 71);
INSERT INTO public.parcheggio VALUES ('8 Vera Place', 'Funaishikawa', 87);
INSERT INTO public.parcheggio VALUES ('0342 Kensington Hill', 'Limoges', 22);
INSERT INTO public.parcheggio VALUES ('231 Oakridge Alley', 'Jiazhuyuan', 23);
INSERT INTO public.parcheggio VALUES ('03531 Eastlawn Lane', 'Kyprínos', 95);
INSERT INTO public.parcheggio VALUES ('6 Northwestern Circle', 'Wang Nam Yen', 87);
INSERT INTO public.parcheggio VALUES ('80 Texas Road', 'Cochabamba', 86);
INSERT INTO public.parcheggio VALUES ('9 Northfield Parkway', 'Zougang', 73);


--
-- TOC entry 3668 (class 0 OID 17878)
-- Dependencies: 215
-- Data for Name: patente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patente VALUES ('RY8830112V', '2009-05-15', '2017-11-28', 'B', 'TSJPHL97P35G831I');
INSERT INTO public.patente VALUES ('DD0697561Q', '2004-10-30', '2013-12-30', 'A', 'NKIUML24J11Q923R');
INSERT INTO public.patente VALUES ('HA7246683R', '2016-11-13', '2029-07-11', 'E', 'LHFVOO46Y05X777Z');
INSERT INTO public.patente VALUES ('TL0985028U', '2016-01-27', '2030-10-09', 'A', 'QTOEHE30B14R971P');
INSERT INTO public.patente VALUES ('UC0610870F', '2003-01-06', '2034-09-27', 'B', 'JVPISK44Y40F049B');
INSERT INTO public.patente VALUES ('EF7697758H', '2012-07-26', '2035-07-24', 'AM', 'ZYKUKW49P77O176S');
INSERT INTO public.patente VALUES ('HB5818395E', '2016-12-01', '2020-02-26', 'C', 'EGSAFY87L48P287X');
INSERT INTO public.patente VALUES ('NO5766704T', '2002-04-15', '2003-09-15', 'D', 'XZKXBT99E53M443W');
INSERT INTO public.patente VALUES ('HZ2188782U', '2010-10-05', '2020-11-19', 'D', 'PWKMJS23W68Q347T');
INSERT INTO public.patente VALUES ('SL4452565G', '2010-05-05', '2030-06-30', 'A', 'NEXGWP48B09A248Y');
INSERT INTO public.patente VALUES ('AP0639470A', '2017-05-07', '2019-07-22', 'B', 'TSJPHL97P35G831I');
INSERT INTO public.patente VALUES ('QN4451925V', '2017-06-26', '2036-03-08', 'B', 'AUCIYU39G06O833V');
INSERT INTO public.patente VALUES ('BR9237160G', '2003-01-13', '2010-07-05', 'B', 'BSJGVG58P59M263N');
INSERT INTO public.patente VALUES ('KC5721120N', '2006-03-02', '2022-02-08', 'B', 'CFYDLL19I85M469F');
INSERT INTO public.patente VALUES ('WT6413388F', '2007-07-27', '2035-07-14', 'B', 'BSJGVG58P59M263N');
INSERT INTO public.patente VALUES ('UH3935514P', '2000-03-03', '2001-09-08', 'A', 'NKIUML24J11Q923R');
INSERT INTO public.patente VALUES ('OL4839653G', '2000-10-22', '2001-04-17', 'AM', 'HZJTVS68X33K590B');
INSERT INTO public.patente VALUES ('KE6665604X', '2019-03-12', '2029-12-18', 'B', 'MMULDD16G49N561X');
INSERT INTO public.patente VALUES ('YX8204669R', '2001-12-27', '2031-03-10', 'B', 'EGSAFY87L48P287X');
INSERT INTO public.patente VALUES ('YG5605415G', '2014-12-10', '2015-01-13', 'B', 'QJGRHQ64U95J443W');
INSERT INTO public.patente VALUES ('DB8725980H', '2008-06-02', '2021-09-14', 'B', 'VRSQHT76V59T281R');
INSERT INTO public.patente VALUES ('BX0431483F', '2001-07-08', '2003-09-22', 'B', 'NKIUML24J11Q923R');
INSERT INTO public.patente VALUES ('ZW1845669G', '2009-05-11', '2031-04-26', 'D', 'QJGRHQ64U95J443W');
INSERT INTO public.patente VALUES ('KA1556106I', '2010-04-20', '2014-05-28', 'B', 'QJGRHQ64U95J443W');
INSERT INTO public.patente VALUES ('AF5266430I', '2020-06-14', '2029-12-19', 'C', 'HRKUEB99Z37H176V');
INSERT INTO public.patente VALUES ('XE6642909E', '2019-10-12', '2037-02-23', 'A', 'NKIUML24J11Q923R');
INSERT INTO public.patente VALUES ('UM1864475M', '2006-07-17', '2033-09-27', 'E', 'VRSQHT76V59T281R');
INSERT INTO public.patente VALUES ('TG4703090H', '2017-05-11', '2021-01-27', 'A', 'YULQKQ73P86X286L');
INSERT INTO public.patente VALUES ('AR4743142T', '2020-08-18', '2037-05-05', 'A', 'MYWXWR60R27F733H');
INSERT INTO public.patente VALUES ('XM4192794R', '2003-05-26', '2013-05-30', 'B', 'JJYVQV80F70J976H');


--
-- TOC entry 3673 (class 0 OID 17926)
-- Dependencies: 220
-- Data for Name: polizza; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.polizza VALUES ('KT9434', 'User-friendly 24 hour artificial intelligence', 10538243, 777, 'QG613BR');
INSERT INTO public.polizza VALUES ('DH4701', 'Mandatory discrete project', 6710266, 563, 'TV674FS');
INSERT INTO public.polizza VALUES ('EU8994', 'Persevering composite contingency', 7628568, 871, 'WV741YT');
INSERT INTO public.polizza VALUES ('TN9381', 'Vision-oriented upward-trending approach', 11196813, 584, 'BX345HC');
INSERT INTO public.polizza VALUES ('EG8993', 'Upgradable intermediate leverage', 8752748, 371, 'FN890WN');
INSERT INTO public.polizza VALUES ('XB6868', 'Profit-focused hybrid monitoring', 19144822, 639, 'BU100EL');
INSERT INTO public.polizza VALUES ('KC3986', 'Business-focused eco-centric matrices', 8691968, 72, 'EI429CG');
INSERT INTO public.polizza VALUES ('JO4534', 'Up-sized system-worthy product', 15244176, 827, 'NR781TW');
INSERT INTO public.polizza VALUES ('OA5707', 'Universal human-resource framework', 11749606, 130, 'LG070KV');
INSERT INTO public.polizza VALUES ('NF7230', 'Streamlined executive infrastructure', 15160114, 424, 'DE945DJ');
INSERT INTO public.polizza VALUES ('AI1823', 'Re-contextualized intermediate projection', 10669536, 991, 'FA966IV');
INSERT INTO public.polizza VALUES ('KF4009', 'Customer-focused actuating time-frame', 14496555, 491, 'DY375WP');
INSERT INTO public.polizza VALUES ('AH5021', 'Mandatory static process improvement', 9775369, 64, 'MV668SM');
INSERT INTO public.polizza VALUES ('WY3650', 'Compatible regional groupware', 15742087, 819, 'WK585IG');
INSERT INTO public.polizza VALUES ('VN2165', 'Future-proofed local customer loyalty', 8921619, 642, 'CL232MU');
INSERT INTO public.polizza VALUES ('XB3055', 'Universal national secured line', 11606007, 85, 'XX567XL');
INSERT INTO public.polizza VALUES ('JB9685', 'Enhanced global definition', 7059075, 320, 'RQ752TB');
INSERT INTO public.polizza VALUES ('FL9660', 'Enhanced empowering paradigm', 8748351, 370, 'JZ951ZV');
INSERT INTO public.polizza VALUES ('IY5415', 'Centralized intermediate portal', 10976079, 603, 'QD039OH');
INSERT INTO public.polizza VALUES ('XA4819', 'Future-proofed intermediate infrastructure', 11040235, 76, 'YP235LW');
INSERT INTO public.polizza VALUES ('SV8087', 'Innovative 6th generation functionalities', 9499925, 141, 'RG333AR');
INSERT INTO public.polizza VALUES ('SJ7915', 'Compatible scalable budgetary management', 5810141, 429, 'YE595LD');
INSERT INTO public.polizza VALUES ('XM1971', 'Re-contextualized upward-trending success', 5203276, 991, 'XM447OV');
INSERT INTO public.polizza VALUES ('PL6621', 'Enterprise-wide systematic parallelism', 11457396, 838, 'LG619NQ');
INSERT INTO public.polizza VALUES ('DA3416', 'Total logistical frame', 7777386, 402, 'WT712AG');


--
-- TOC entry 3514 (class 2606 OID 17960)
-- Name: acquisto acquisto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acquisto
    ADD CONSTRAINT acquisto_pkey PRIMARY KEY (codice);


--
-- TOC entry 3507 (class 2606 OID 17915)
-- Name: autoveicolo autoveicolo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoveicolo
    ADD CONSTRAINT autoveicolo_pkey PRIMARY KEY (targa);


--
-- TOC entry 3497 (class 2606 OID 17877)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cf);


--
-- TOC entry 3503 (class 2606 OID 17901)
-- Name: fornitore fornitore_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornitore
    ADD CONSTRAINT fornitore_pkey PRIMARY KEY (nome);


--
-- TOC entry 3501 (class 2606 OID 17894)
-- Name: lavoratore lavoratore_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lavoratore
    ADD CONSTRAINT lavoratore_pkey PRIMARY KEY (id);


--
-- TOC entry 3512 (class 2606 OID 17940)
-- Name: noleggio noleggio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.noleggio
    ADD CONSTRAINT noleggio_pkey PRIMARY KEY (codice);


--
-- TOC entry 3505 (class 2606 OID 17908)
-- Name: parcheggio parcheggio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcheggio
    ADD CONSTRAINT parcheggio_pkey PRIMARY KEY (indirizzo, citta);


--
-- TOC entry 3499 (class 2606 OID 17882)
-- Name: patente patente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patente
    ADD CONSTRAINT patente_pkey PRIMARY KEY (numpatente);


--
-- TOC entry 3510 (class 2606 OID 17930)
-- Name: polizza polizza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polizza
    ADD CONSTRAINT polizza_pkey PRIMARY KEY (numero_polizza);


--
-- TOC entry 3508 (class 1259 OID 17977)
-- Name: indextipoveicolo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indextipoveicolo ON public.autoveicolo USING btree (modello, marca, tipo_veicolo);


--
-- TOC entry 3522 (class 2606 OID 17966)
-- Name: acquisto acquisto_cf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acquisto
    ADD CONSTRAINT acquisto_cf_fkey FOREIGN KEY (cf) REFERENCES public.cliente(cf);


--
-- TOC entry 3523 (class 2606 OID 17971)
-- Name: acquisto acquisto_id_lavoratore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acquisto
    ADD CONSTRAINT acquisto_id_lavoratore_fkey FOREIGN KEY (id_lavoratore) REFERENCES public.lavoratore(id);


--
-- TOC entry 3524 (class 2606 OID 17961)
-- Name: acquisto acquisto_targa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acquisto
    ADD CONSTRAINT acquisto_targa_fkey FOREIGN KEY (targa) REFERENCES public.autoveicolo(targa);


--
-- TOC entry 3516 (class 2606 OID 17916)
-- Name: autoveicolo autoveicolo_indirizzo_parcheggio_citta_parcheggio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoveicolo
    ADD CONSTRAINT autoveicolo_indirizzo_parcheggio_citta_parcheggio_fkey FOREIGN KEY (indirizzo_parcheggio, citta_parcheggio) REFERENCES public.parcheggio(indirizzo, citta);


--
-- TOC entry 3517 (class 2606 OID 17921)
-- Name: autoveicolo autoveicolo_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autoveicolo
    ADD CONSTRAINT autoveicolo_marca_fkey FOREIGN KEY (marca) REFERENCES public.fornitore(nome);


--
-- TOC entry 3519 (class 2606 OID 17946)
-- Name: noleggio noleggio_cf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.noleggio
    ADD CONSTRAINT noleggio_cf_fkey FOREIGN KEY (cf) REFERENCES public.cliente(cf);


--
-- TOC entry 3520 (class 2606 OID 17951)
-- Name: noleggio noleggio_id_lavoratore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.noleggio
    ADD CONSTRAINT noleggio_id_lavoratore_fkey FOREIGN KEY (id_lavoratore) REFERENCES public.lavoratore(id);


--
-- TOC entry 3521 (class 2606 OID 17941)
-- Name: noleggio noleggio_targa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.noleggio
    ADD CONSTRAINT noleggio_targa_fkey FOREIGN KEY (targa) REFERENCES public.autoveicolo(targa);


--
-- TOC entry 3515 (class 2606 OID 17883)
-- Name: patente patente_cf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patente
    ADD CONSTRAINT patente_cf_fkey FOREIGN KEY (cf) REFERENCES public.cliente(cf);


--
-- TOC entry 3518 (class 2606 OID 17931)
-- Name: polizza polizza_targa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polizza
    ADD CONSTRAINT polizza_targa_fkey FOREIGN KEY (targa) REFERENCES public.autoveicolo(targa);


-- Completed on 2023-06-20 23:08:00 CEST

--
-- PostgreSQL database dump complete
--


/* queries

--1
SELECT A.targa, A.marca, A.modello, A.tipo_veicolo
FROM autoveicolo AS A
JOIN Polizza as P
ON P.targa = A.targa
WHERE P.massimale >= 10000000

--2
SELECT A.marca as fornitore, F.citta, F.indirizzo, COUNT(*) AS numElementiForniti
FROM autoveicolo AS A
JOIN fornitore AS F
ON A.marca = F.nome
GROUP BY A.marca, F.citta, F.indirizzo
ORDER BY numElementiForniti DESC

--3
SELECT DISTINCT C.cognome, C.nome, C.cf, C.email, C.telefono, C.email, C.inizio_cliente 
FROM cliente AS C
JOIN patente AS P
ON P.CF = C.CF
WHERE data_scadenza < '2023-06-18'
ORDER BY C.cognome, C.nome

--4
SELECT id_lavoratore, nome, cognome, count(*) as numVendite
FROM acquisto
JOIN lavoratore
ON acquisto.id_lavoratore = lavoratore.id
GROUP BY id_lavoratore, nome, cognome
ORDER BY numVendite DESC
LIMIT 1

--5
SELECT indirizzo, citta, count(*) AS numVeicoli
FROM parcheggio AS P
LEFT JOIN autoveicolo AS A
ON P.indirizzo = A.indirizzo_parcheggio AND P.citta = A.citta_parcheggio
GROUP BY indirizzo,citta
HAVING count(*) > 0
ORDER BY numVeicoli DESC

--6
SELECT DISTINCT *
FROM
	((SELECT DISTINCT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente
	FROM cliente AS C
	JOIN acquisto AS A
	ON C.cf = A.cf)

	UNION

	(SELECT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente
	FROM cliente AS C
	JOIN noleggio AS N
	ON C.cf = N.cf
	GROUP BY C.cf
	HAVING count(*) >= 2)) as fedeli

WHERE inizio_cliente <= '2010-12-31'

--7
SELECT C.nome, C.cognome, C.cf, C.sesso, C.email, C.telefono
FROM Cliente AS C
JOIN Noleggio AS N on N.CF = C.CF
JOIN Autoveicolo AS A ON N.targa = A.targa
JOIN Lavoratore AS L ON L.ID = N.ID_lavoratore
WHERE A.lusso=true AND N.ID_lavoratore = '1'

--8
SELECT P.numero_polizza, A.targa, P.massimale, P.franchigia
FROM polizza AS P
JOIN autoveicolo AS A
ON P.targa = A.targa
JOIN noleggio AS N
ON A.targa = N.targa
WHERE codice = '1'

--9
SELECT N.codice as codiceNoleggio, A.targa, A.marca, A.modello, DATE_PART('day', AGE(N.data_fine, N.data_inizio)) * A.prezzo_giornaliero AS prezzoGiornaliero
FROM noleggio AS N
JOIN autoveicolo AS A
ON N.targa = A.targa
WHERE codice = '7'

--10
SELECT targa, marca, modello
FROM autoveicolo
WHERE tipo_veicolo = 'AUTO' AND prezzo IS null

EXCEPT

(SELECT A.targa, A.marca, A.modello
FROM autoveicolo AS A
JOIN noleggio as N
ON A.targa = N.targa
WHERE N.data_inizio < '2018-03-01' AND N.data_fine > '2018-03-01')
*/