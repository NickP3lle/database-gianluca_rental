#include "checkResults.h"

void checkResults(PGresult *res, const PGconn *conn) {
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        std::cout << "Risultati inconsistenti!" << PQerrorMessage(conn) << std::endl;
        PQclear(res);
        exit(1);
    }
}