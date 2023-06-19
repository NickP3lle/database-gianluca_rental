#include "dependencies/funcs/checkResults.h"
#include "dependencies/funcs/printResults.h"
#include "dependencies/funcs/saveResultsToFile.h"
#include "dependencies/include/libpq-fe.h"
#include <cstdio>
#include <iostream>

#define PG_HOST "127.0.0.1"                 // Insert your IP here
#define PG_DB "concessionaria_autonoleggio" // Insert your database name here
#define PG_PASS "12345"                     // Insert your password here
#define PG_PORT 5432
#define PG_USER "postgres"
#define FILE_NAME "output.csv"

void showMenu();
void showQuery();

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
    PGresult *res;
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

    PQclear(res);
    // PQclear(stmt);
    PQfinish(conn);

    return 0;
}

void showMenu() {
    std::cout << "Selezionare una delle seguenti opzioni:" << std::endl;
    std::cout << "1. Effettua una query" << std::endl;
    std::cout << "2. Esci" << std::endl << std::endl;
}

void showQuery() {
    std::cout << std::endl << "Selezionare una delle seguenti query:" << std::endl << std::endl;
    std::cout << "0. Torna al menu principale" << std::endl << std::endl;

    std::cout << "1. Query 1" << std::endl;
    std::cout << "2. Query 2" << std::endl;
    std::cout << "3. Query 3" << std::endl;
    std::cout << "4. Query 4" << std::endl;
    std::cout << "5. Query 5" << std::endl;
    std::cout << "6. Query 6" << std::endl;
    std::cout << "7. Query 7" << std::endl << std::endl;

    std::cout << "Query parametriche:" << std::endl;

    std::cout << "8. Query 8" << std::endl;
    std::cout << "9. Query 9" << std::endl;
    std::cout << "10. Query 10" << std::endl;
    std::cout << "11. Query 11" << std::endl;
    std::cout << "12. Query 12" << std::endl;

    int j = 0;
    std::cin >> j;
    switch (j) {
    case 1:
        break;
    }
}