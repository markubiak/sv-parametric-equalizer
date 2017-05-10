#ifndef FINAL_SM_H_
#define FINAL_SM_H_
#include "alt_types.h"

int sm_init();
void sm_process_str(char* in);
void process_filter();
void addToGraph(int i, double b0, double b1, double b2, double a1, double a2);
void generate_frequencies();

#endif
