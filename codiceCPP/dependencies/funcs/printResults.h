#ifndef PRINTRESULTS_H
#define PRINTRESULTS_H

#include "../include/libpq-fe.h"
#include <cstdio>
#include <iostream>

/// Print the result of a query
void printResults(PGresult *res);

#endif