#ifndef __GETARG__
#define __GETARG__

#include <stdbool.h>

#define INVALID_N_THREADS -1

bool parseArgs(int argc, char* argv[]);

bool showHelp();
int get_n_trials();
int get_warmup_trials();
int get_n_threads();

#endif
