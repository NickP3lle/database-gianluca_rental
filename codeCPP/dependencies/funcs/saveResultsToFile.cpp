#include "saveResultsToFile.h"

void saveResultsToFile(PGresult *res, char *filename) {
    std::ofstream file(filename);
    if (!file.is_open()) {
        std::cout << "Errore apertura file" << std::endl;
        exit(1);
    }
    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    for (int i = 0; i < campi; ++i) {
        file << PQfname(res, i) << ",";
    }

    file << std::endl;

    // Salvo i valori selezionati
    for (int i = 0; i < tuple; ++i) {
        for (int j = 0; j < campi; ++j) {
            file << PQgetvalue(res, i, j) << ",";
        }
        file << std::endl;
    }
    file.close();
    std::cout << "File " << filename << " salvato correttamente!" << std::endl;
}