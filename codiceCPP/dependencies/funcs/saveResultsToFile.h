#ifndef SAVERESULTSTOFILE_H
#define SAVERESULTSTOFILE_H

#include "../include/libpq-fe.h"
#include <cstdio>
#include <fstream>
#include <iostream>

/// Save the result of a query to a file
void saveResultsToFile(PGresult *res, char *filename);

#endif