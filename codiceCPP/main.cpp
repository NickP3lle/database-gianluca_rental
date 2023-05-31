#include "dependencies/funcs/checkResults.h"
#include "dependencies/funcs/printResults.h"
#include "dependencies/funcs/saveResultsToFile.h"
#include "dependencies/include/libpq-fe.h"
#include <cstdio>
#include <iostream>

#define PG_HOST "127.0.0.1"  // Insert your IP here
#define PG_DB "lab3"         // Insert your database name here
#define PG_PASS "**********" // Insert your password here
#define PG_PORT 5432
#define PG_USER "postgres"
#define FILE_NAME "output.csv"

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