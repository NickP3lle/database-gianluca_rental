#ifndef CHECKRESULTS_H
#define CHECKRESULTS_H

#include "../include/libpq-fe.h"
#include <cstdio>
#include <iostream>

/// Check the result of a query
void checkResults(PGresult *res, const PGconn *conn);

#endif