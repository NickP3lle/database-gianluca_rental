#include "dependencies/include/libpq-fe.h"
#include <cstdio>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#define PG_HOST "127.0.0.1"                 // Insert your IP here
#define PG_DB "concessionaria_autonoleggio" // Insert your database name here
#define PG_PASS "12345"                     // Insert your password here
#define PG_PORT 5432
#define PG_USER "postgres"

void checkResults(PGresult *res, const PGconn *conn);
void printResults(PGresult *res);

void showMenu();
void showQuery();

void selectQuery(PGconn *conn);
void queries1To6(PGconn *conn, int k);
void queries7To9(PGconn *conn, int k);
void query10(PGconn *conn);

std::vector<std::string> queries{
    "SELECT A.targa, A.marca, A.modello, A.tipo_veicolo FROM autoveicolo AS A JOIN Polizza as P ON P.targa = A.targa WHERE "
    "P.massimale >= 10000000",
    "SELECT A.marca as fornitore, F.citta, F.indirizzo, COUNT(*) AS numElementiForniti FROM autoveicolo AS A JOIN fornitore "
    "AS F ON A.marca = F.nome GROUP BY A.marca, F.citta, F.indirizzo ORDER BY numElementiForniti DESC",
    "SELECT DISTINCT C.cognome, C.nome, C.cf, C.email, C.telefono, C.inizio_cliente FROM cliente AS C JOIN patente "
    "AS P ON P.CF = C.CF WHERE data_scadenza < '2023-06-18' ORDER BY C.cognome, C.nome ",
    "SELECT id_lavoratore, nome, cognome, count(*) as numVendite FROM acquisto JOIN lavoratore ON acquisto.id_lavoratore = "
    "lavoratore.id GROUP BY id_lavoratore, nome, cognome ORDER BY numVendite DESC LIMIT 1 ",
    "SELECT indirizzo, citta, count(*) AS numVeicoli FROM parcheggio AS P LEFT JOIN autoveicolo AS A ON P.indirizzo = "
    "A.indirizzo_parcheggio AND P.citta = A.citta_parcheggio GROUP BY indirizzo,citta HAVING count(*) > 0 ORDER BY "
    "numVeicoli DESC",
    "SELECT DISTINCT * FROM ((SELECT DISTINCT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente FROM cliente AS C JOIN "
    "acquisto AS A ON C.cf = A.cf) UNION (SELECT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente FROM cliente AS C "
    "JOIN noleggio AS N ON C.cf = N.cf GROUP BY C.cf HAVING count(*) >= 2)) as fedeli WHERE inizio_cliente <= '2010-12-31'",
    "SELECT C.nome, C.cognome, C.cf, C.sesso, C.email, C.telefono FROM Cliente AS C JOIN Noleggio AS N "
    "on N.CF = C.CF JOIN Autoveicolo AS A ON N.targa = A.targa JOIN Lavoratore AS L ON L.ID = "
    "N.ID_lavoratore WHERE A.lusso=true AND N.ID_lavoratore = $1::varchar",
    "SELECT P.numero_polizza, A.targa, P.massimale, P.franchigia FROM polizza AS P JOIN autoveicolo AS "
    "A ON P.targa = A.targa JOIN noleggio AS N ON A.targa = N.targa WHERE codice = $1::varchar",
    "SELECT N.codice as codiceNoleggio, A.targa, A.marca, A.modello, DATE_PART('day', AGE(N.data_fine, "
    "N.data_inizio)) * A.prezzo_giornaliero AS prezzoGiornaliero FROM noleggio AS N JOIN autoveicolo AS "
    "A ON N.targa = A.targa WHERE codice = $1::varchar",
    "SELECT targa, marca, modello FROM autoveicolo WHERE tipo_veicolo = $1 AND prezzo IS null "
    "EXCEPT (SELECT A.targa, A.marca, A.modello FROM autoveicolo AS A JOIN noleggio as N ON A.targa = "
    "N.targa WHERE N.data_inizio < $2 AND N.data_fine> $2) "};

int main(int argc, char **argv) {

    char conninfo[250];
    sprintf(conninfo, "user=%s password=%s dbname=%s hostaddr=%s port=%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);

    PGconn *conn;
    conn = PQconnectdb(conninfo);

    /// Check connection
    if (PQstatus(conn) != CONNECTION_OK) {
        std::cout << "Connessione al database " << PQerrorMessage(conn) << " fallita" << std::endl;
        PQfinish(conn);
        return 1;
    }
    std::cout << "Connessione al database " << PG_DB << " con successo!" << std::endl;

    int i = 0;
    while (i != 2) {
        showMenu();
        std::cin >> i;
        switch (i) {
        case 1:
            selectQuery(conn);
            break;
        case 2:
            std::cout << "Chiusura in corso..." << std::endl;
            // i = 2;
            break;
        default:
            std::cout << "Opzione non valida" << std::endl;
            break;
        }
    }

    PQfinish(conn);

    return 0;
}

/// @brief Check the result of a query
void checkResults(PGresult *res, const PGconn *conn) {
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        std::cout << "Risultati inconsistenti! " << PQerrorMessage(conn) << std::endl;
        PQclear(res);
        exit(1);
    }
}

/// @brief Print the result of a query
void printResults(PGresult *res) {
    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    if (tuple == 0) {
        std::cout << "Nessun risultato trovato" << std::endl;
        return;
    }

    // Calculate maximum width for each column
    std::vector<int> columnWidths(campi, 0);
    for (int j = 0; j < campi; j++) {
        for (int i = 0; i < tuple; i++) {
            int width = strlen(PQgetvalue(res, i, j));
            if (width > columnWidths[j]) {
                columnWidths[j] = width + 4;
            }
        }
    }

    // Print column headers
    for (int i = 0; i < campi; i++) {
        std::cout << std::setw(columnWidths[i]) << std::left << PQfname(res, i);
    }
    std::cout << std::endl;

    // Print the selected values
    for (int i = 0; i < tuple; i++) {
        for (int j = 0; j < campi; j++) {
            std::cout << std::setw(columnWidths[j]) << std::left << PQgetvalue(res, i, j);
        }
        std::cout << std::endl;
    }
}

/// @brief Show the menu
void showMenu() {
    std::cout << "Selezionare una delle seguenti opzioni:" << std::endl;
    std::cout << "1. Effettua una query" << std::endl;
    std::cout << "2. Esci" << std::endl << std::endl;
}

/// @brief Show the query list
void showQuery() {
    std::cout << std::endl << "Selezionare una delle seguenti query:" << std::endl;
    std::cout << "0. Torna al menu principale" << std::endl << std::endl;

    std::cout << "1. Mostra tutti i veicoli noleggiabili con una polizza assicurativa con massimale maggiore di 1.000.000"
              << std::endl;
    std::cout << "2. Mostra tutti i fornitori in ordine di autoveicoli forniti e il numero di elementi forniti" << std::endl;
    std::cout << "3. Mostra tutti i clienti con la patente scaduta (in data 18-06-2023)" << std::endl;
    std::cout << "4. Mostra il lavoratore che ha venduto più veicoli" << std::endl;
    std::cout << "5. Mostra tutti i parcheggi in cui c'è parcheggiato almeno un veicolo" << std::endl;
    std::cout << "6. Mostra i clienti fedeli, ovvero quelli che sono clienti da prima del 2010 e hanno noleggiato almeno "
                 "due veicoli o compratone uno"
              << std::endl
              << std::endl;

    std::cout << "Query parametriche:" << std::endl;

    std::cout << "7. Mostra i clienti che hanno noleggiato un veicolo di lusso attraverso un lavoratore" << std::endl;
    std::cout << "8. Mostra franchigia e massimale della polizza di un noleggio dato l'id del noleggio" << std::endl;
    std::cout << "9. Mostra quanto deve pagare un cliente per il suo noleggio dato il codice del noleggio" << std::endl;
    std::cout << "10. Mostra tutti i veicoli del tipo inserito disponibili nella data inserita al noleggio" << std::endl
              << std::endl;
}

/// @brief Select the query to execute
void selectQuery(PGconn *conn) {
    int j = 1;
    while (j != 0) {
        showQuery();

        std::cin >> j;
        switch (j) {
        case 0:
            std::cout << "Torno al menu principale" << std::endl;
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            queries1To6(conn, j - 1);
            break;
        case 7:
        case 8:
        case 9:
            queries7To9(conn, j - 1);
            break;
        case 10:
            query10(conn);
            break;
        default:
            std::cout << "Opzione non valida" << std::endl;
            break;
        }

        if (j != 0) {
            std::cout << "Premere enter per continuare...";
            std::cin.ignore();
            std::cin.get();
        }
    }
}

/// @brief Execute the queries from 1 to 6
void queries1To6(PGconn *conn, int k) {
    PGresult *res;

    res = PQexec(conn, queries[k].c_str());
    checkResults(res, conn);
    printResults(res);
    std::cout << std::endl << std::endl;
    PQclear(res);
}

/// @brief Execute the queries from 7 to 9
void queries7To9(PGconn *conn, int k) {
    PGresult *res;

    PGresult *stmt = PQprepare(conn, ("query" + std::to_string(k + 1)).c_str(), queries[k].c_str(), 1, NULL);

    std::string codice;

    if (k == 6) {
        std::cout << "Inserire codice del lavoratore (valori tra 1 e 20): ";
    } else {
        std::cout << "Inserire codice del noleggio (valori tra 1 e 20): ";
    }
    std::cin >> codice;
    const char *parameter = codice.c_str();

    res = PQexecPrepared(conn, ("query" + std::to_string(k + 1)).c_str(), 1, &parameter, NULL, 0, 0);
    checkResults(res, conn);
    printResults(res);

    PQclear(res);
    PQclear(stmt);
}

/// @brief Execute the query 10
void query10(PGconn *conn) {
    PGresult *res;

    PGresult *stmt = PQprepare(conn, "query_disponibility", queries[9].c_str(), 2, NULL);

    std::string tipoVeicolo;
    std::string data;

    std::cout << "Inserire tipo veicolo (AUTO o MOTO o FURGONE): ";
    std::cin >> tipoVeicolo;
    std::cout << "Inserire data (formato YYYY-MM-DD): ";
    std::cin >> data;

    const char *parameter[2];
    parameter[0] = tipoVeicolo.c_str();
    parameter[1] = data.c_str();

    res = PQexecPrepared(conn, "query_disponibility", 2, parameter, NULL, 0, 0);
    checkResults(res, conn);
    printResults(res);

    PQclear(res);
    PQclear(stmt);
}