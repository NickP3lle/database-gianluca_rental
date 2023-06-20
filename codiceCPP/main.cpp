// #include "dependencies/funcs/checkResults.h"
// #include "dependencies/funcs/printResults.h"
// #include "dependencies/funcs/saveResultsToFile.h"
#include "dependencies/include/libpq-fe.h"
#include <cstdio>
#include <iostream>
#include <string>
#include <vector>

#define PG_HOST "127.0.0.1"                 // Insert your IP here
#define PG_DB "concessionaria_autonoleggio" // Insert your database name here
#define PG_PASS "12345"                     // Insert your password here
#define PG_PORT 5432
#define PG_USER "postgres"
#define FILE_NAME "output.csv"

void checkResults(PGresult *res, const PGconn *conn);
void printResults(PGresult *res);

void showMenu();
void showQuery();

void selectQuery(PGconn *conn);
void query1To6(PGconn *conn, int k);
// void query7(PGconn *conn);
// void query8(PGconn *conn);
// void query9(PGconn *conn);
// void query10(PGconn *conn);

std::vector<std::string> queries{
    "SELECT A.targa, A.marca, A.modello, A.tipo_veicolo FROM autoveicolo AS A JOIN Polizza as P ON P.targa = A.targa WHERE "
    "P.massimale >= 10000000",
    "SELECT A.marca as fornitore, F.citta, F.indirizzo, COUNT(*) AS numElementiForniti FROM autoveicolo AS A JOIN fornitore "
    "AS F ON A.marca = F.nome GROUP BY A.marca, F.citta, F.indirizzo ORDER BY numElementiForniti DESC",
    "SELECT DISTINCT C.cognome, C.nome, C.cf, C.email, C.telefono, C.email, C.inizio_cliente FROM cliente AS C JOIN patente "
    "AS P ON P.CF = C.CF WHERE data_scadenza < '2023-06-18' ORDER BY C.cognome, C.nome ",
    "SELECT id_lavoratore, nome, cognome, count(*) as numVendite FROM acquisto JOIN lavoratore ON acquisto.id_lavoratore = "
    "lavoratore.id GROUP BY id_lavoratore, nome, cognome ORDER BY numVendite DESC LIMIT 1 ",
    "SELECT indirizzo, citta, count(*) AS numVeicoli FROM parcheggio AS P LEFT JOIN autoveicolo AS A ON P.indirizzo = "
    "A.indirizzo_parcheggio AND P.citta = A.citta_parcheggio GROUP BY indirizzo,citta HAVING count(*) > 0 ORDER BY "
    "numVeicoli DESC",
    "SELECT DISTINCT * FROM ((SELECT DISTINCT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente FROM cliente AS C JOIN "
    "acquisto AS A ON C.cf = A.cf) UNION (SELECT C.nome, C.cognome, C.cf, C.telefono, C.inizio_cliente FROM cliente AS C "
    "JOIN noleggio AS N ON C.cf = N.cf GROUP BY C.cf HAVING count(*) >= 2)) as fedeli WHERE inizio_cliente <= '2010-12-31'"};

/**
 * Dependencies are for macOS, if you are using Linux or Windows, you have to change the path
 * @note Do not delete the dependencies/funcs folder, it contains the functions used in the main
 */
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
            showQuery();
            selectQuery(conn);
            break;
        case 2:
            std::cout << "Chiusura in corso..." << std::endl;
            i = 2;
            break;
        default:
            std::cout << "Opzione non valida" << std::endl;
            break;
        }
    }

    /// Query starts here
    // PGresult *res;
    // std::string query = "SELECT origin , destination , departure_time , arrival_time FROM hubs JOIN legs on origin = hub "
    //                     "WHERE country = $1::varchar ";

    // PGresult *stmt = PQprepare(conn, "query_legs", query.c_str(), 1, NULL);

    // std::string country;

    // std::cout << "Inserire codice paese di origine: ";
    // std::cin >> country;
    // const char *parameter = country.c_str();

    // res = PQexecPrepared(conn, "query_legs", 1, &parameter, NULL, 0, 0);
    // checkResults(res, conn);
    // printResults(res);
    // saveResultsToFile(res, FILE_NAME);

    // PQclear(res);
    // PQclear(stmt);
    PQfinish(conn);

    return 0;
}

/// @brief Check the result of a query
void checkResults(PGresult *res, const PGconn *conn) {
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        std::cout << "Risultati inconsistenti!" << PQerrorMessage(conn) << std::endl;
        PQclear(res);
        exit(1);
    }
}

/// @brief Print the result of a query
void printResults(PGresult *res) {
    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    // Stampo intestazioni
    for (int i = 0; i < campi; ++i) {
        std::cout << PQfname(res, i) << "\t\t";
    }
    std::cout << std::endl;

    // Stampo i valori selezionati
    for (int i = 0; i < tuple; ++i) {
        for (int j = 0; j < campi; ++j) {
            std::cout << PQgetvalue(res, i, j) << "\t\t";
        }
        std::cout << std::endl << std::endl;
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
    std::cout << std::endl << "Selezionare una delle seguenti query:" << std::endl << std::endl;
    std::cout << "0. Torna al menu principale" << std::endl << std::endl;

    std::cout << "1. Mostra tutte i veicoli noleggiabili con una polizza assicurativa con massimale maggiore di 1.000.000"
              << std::endl;
    std::cout << "2. Mostra tutti i fornitori in ordine di autoveicoli forniti e il numero di elementi forniti" << std::endl;
    std::cout << "3. Mostra tutti i clienti con la patente scaduta (in data 18-06-2023)" << std::endl;
    std::cout << "4. Mostra il lavoratore che ha venduto più veicoli" << std::endl;
    std::cout << "5. Mostra tutti i parcheggi in cui c'è parcheggiato almeno un veicolo" << std::endl;
    std::cout << "6. Mostra i clienti fedeli, ovvero quelli che sono clienti da prima del 2010 e hanno noleggiato almeno "
                 "due veicoli o compratone uno"
              << std::endl;

    std::cout << "Query parametriche:" << std::endl;

    std::cout << "7. Query 7" << std::endl << std::endl;
    std::cout << "8. Query 8" << std::endl;
    std::cout << "9. Query 9" << std::endl;
    std::cout << "10. Query 10" << std::endl;
    std::cout << "11. Query 11" << std::endl;
    std::cout << "12. Query 12" << std::endl << std::endl;
}

/// @brief Select the query to execute
void selectQuery(PGconn *conn) {
    int j = 0;
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
        query1To6(conn, j - 1);
        break;
    default:
        std::cout << "Opzione non valida" << std::endl;
        break;
    }
}

/// @brief
void query1To6(PGconn *conn, int k) {
    PGresult *res;

    res = PQexec(conn, queries[k].c_str());
    checkResults(res, conn);
    printResults(res);
    PQclear(res);
}