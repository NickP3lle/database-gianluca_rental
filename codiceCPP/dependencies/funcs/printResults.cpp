#include "printResults.h"

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
        std::cout << std::endl;
    }
}