#include "final_sm.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "alt_types.h"
#include "system.h"

#define biquad_index		(alt_u8*) 			BIQUAD_INDEX_BASE
#define coefficient			(alt_u32*)			COEFFICIENT_BASE
#define to_hw_sig			(alt_u8*)			TO_HW_SIG_BASE
#define to_sw_sig			(volatile alt_u8*)	TO_SW_SIG_BASE

#define F_string			(alt_u32*)				F_STRING_BASE
#define G_string			(alt_u32*)				G_STRING_BASE
#define Q_string			(alt_u32*)				Q_STRING_BASE
#define type_index			(alt_u8*)				TYPE_INDEX_BASE

int state = 0;
// state list
// 0 - reset
// 1 - E pressed, waiting for biquad selection
// 2 - biquad selected, waiting for filter type
// 3 - filter selected, waiting on center freq
// 4 - center freq selected, waiting on Q factor
// 5 - Q factor entered, waiting for gain if necessary
// 6 - Gain entered, processing shit, will auto go to 0 after

int biquad, type, F, int_in;
double Q, G, double_in;

double Fs = 48000;
long double A, alpha, w0, a0;
long double b0, b1, b2, a1, a2;

double aCoeffsSq, bCoeffsSq;
float frequencies[517] = {0};
int samples[8][517]; // initialize to 0db, aka 191
// Constants, in an attempt to speed up processing
static const float toSample = (float) 32 / 5;

void generate_frequencies() {
	printf("Generating the frequency range...\n");
	*to_hw_sig = 7;
	int i;
	const double log20 = log10(20);
	for (i = 0; i < 517; i++) {
		frequencies[i] = pow(10, ((float) i / 172) + log20);
	}
}

// return 1 if anything was done, 0 otherwise
int sm_init() {
	if (state == 0) {
		printf("Select biquad #1-8 then press [ENTER]\n");
		biquad = 0;
		*to_hw_sig =  8;
		F = 0;
		Q = 0;
		state = 1;
		return 1;
	}
	return 0;
}

void sm_process_str(char* str) {
	switch (state) {
	case 1:
		int_in = atoi(str);
		if (int_in >= 1 && int_in <= 9) {
			biquad = int_in;
			printf("Pick the type of filter then press [ENTER]\n");
			printf("1: Peak EQ\n");
			printf("2: Low Shelf\n");
			printf("3: High Shelf\n");
			printf("4: Low Pass\n");
			printf("5: High Pass\n");
			*to_hw_sig = 15;
			state = 2;
		} else {
			printf("Please select a biquad in the range 1 to 8 then press [ENTER]\n");
		}
		break;
	case 2:
		int_in = atoi(str);
		if (int_in >= 1 && int_in <= 5) {
			type = int_in;
			printf("Enter the Center Frequency (F) then press [ENTER]\n");
			*to_hw_sig = 14;
			state = 3;
		} else {
			printf("Please select a filter in the range 1 to 5 then press [ENTER]\n");
			*to_hw_sig = 13;
		}
		break;
	case 3:
		int_in = atoi(str);
		if (int_in >= 20 && int_in <= 20000) {
			F = int_in;
			printf("Input the Q factor then press [ENTER]\n");
			*to_hw_sig = 12;
			state = 4;
		} else {
			printf("Please select a center frequency between 20 and 20,000 then press [ENTER]\n");
			*to_hw_sig = 11;
		}
		break;
	case 4:
		double_in = atof(str);
		if (double_in >= 0 && double_in < 20) {
			Q = double_in;
			if (type >= 1 && type <= 3) { // these filters need a gain
				printf("Enter the gain of the filter then press [ENTER]\n");
				*to_hw_sig = 10;
				state = 5;
			} else {
				process_filter();
			}
		} else {
			printf("Please select a non-negative Q factor less than 20 then press [ENTER]\n");
			*to_hw_sig = 9;
		}
		break;
	case 5:
		double_in = atof(str);
		if (double_in >= -20 && double_in <= 20) {
			G = double_in;
			process_filter();
		} else {
			printf("Please select a gain in the range -20db to 20db then press [ENTER]\n");
			*to_hw_sig = 8;
		}
	}
}

void process_filter() {
	printf("Processing filter... \n");
	printf("Biquad %d, Type: %d, F: %d, Q: %f, G: %f\n", biquad, type, F, Q, G);

	A = pow(10, G / 40);
	w0 = 2*M_PI*((double)F / Fs);
	alpha = sin(w0)/(2 * Q);
	if (type == 1) // PeakEQ
		a0 = 1 + (alpha / A);
	else if (type == 2) // Low Shelf
		a0 = (A + 1) + ((A - 1) * cos(w0)) + (2 * sqrt(A) * alpha);
	else if (type == 3) // High Shelf
		a0 = (A + 1) - ((A - 1) * cos(w0)) + (2 * sqrt(A) * alpha);
	else if (type == 4 || type == 5) // Passband
		a0 = 1 + alpha;

	switch (type) {
	case 1: //Peak EQ
		b0 = (1 + (alpha * A)) / a0;
		b1 = (-2 * cos(w0)) / a0;
		b2 = (1 - (alpha * A)) / a0;
		a1 = -(-2 * cos(w0)) / a0;
		a2 = -(1 - (alpha / A)) / a0;
		break;
	case 2: //Low Shelf
		b0 = (A*((A+1)-((A-1)*cos(w0))+(2*sqrt(A)*alpha)))/a0;
		b1 = (2*A*((A-1) - ((A+1)*cos(w0))))/a0;
		b2 = (A*((A+1)-((A-1)*cos(w0))-(2*sqrt(A)*alpha)))/a0;
		a1 = -(-2*((A-1) + ((A+1)*cos(w0))))/a0;
		a2 = -((A+1) + ((A-1)*cos(w0)) - (2*sqrt(A)*alpha))/a0;
		break;
	case 3: //High shelf
		b0 = (A*((A+1)+((A-1)*cos(w0))+(2*sqrt(A)*alpha)))/a0;
		b1 = (-2*A*((A-1) + ((A+1)*cos(w0))))/a0;
		b2 = (A*((A+1)+((A-1)*cos(w0))-(2*sqrt(A)*alpha)))/a0;
		a1 = -(2*((A-1) - ((A+1)*cos(w0))))/a0;
		a2 = -((A+1) - ((A-1)*cos(w0)) - (2*sqrt(A)*alpha))/a0;
		break;
	case 4: //low pass
		b0 = ((1-cos(w0))/(2))/a0;
		b1 = (1-cos(w0))/a0;
		b2 = ((1-cos(w0))/(2))/a0;
		a1 = -(-2*cos(w0))/a0;
		a2 = -(1-alpha)/a0;
		break;
	case 5: //high pass
		b0 = ((1+cos(w0))/(2))/a0;
		b1 = -(1+cos(w0))/a0;
		b2 = ((1+cos(w0))/(2))/a0;
		a1 = -(-2*cos(w0))/a0;
		a2 = -(1-alpha)/a0;
		break;
	}

	printf("b0: %Lf, b1: %Lf, b2: %Lf, a1: %Lf, a2: %Lf\n", b0, b1, b2, a1, a2);
	long double coeffs[5];
	coeffs[0] = b0;
	coeffs[1] = b1;
	coeffs[2] = b2;
	coeffs[3] = a1;
	coeffs[4] = a2;

	// to_sw_signal:
	// 0: Doing nothing
	// 1: Coefficient processed

	// to_hw_signal:
	// 0: Doing nothing
	// 1: Process the coefficient

	int i;
	char F_str[4];
	char G_str[4];
	char Q_str[4];
	// Calculate displayed signals
	*biquad_index = biquad - 1;
	*type_index = type;
	if (F >= 10000) {
		sprintf(F_str, "%3d", (int) ((double) F / 1000));
		F_str[3] = 'K';
	} else if (F >= 1000) {
		sprintf(F_str, "%3f", (double) F / 1000);
		F_str[3] = 'K';
	} else {
		sprintf(F_str, "%4d", F);
	}
	*F_string = (F_str[0] << 24) | (F_str[1] << 16) | (F_str[2] << 8) | F_str[3];

	if (G <= -10) {
		sprintf(G_str, "%4d", (int) round(G));
	} else {
		sprintf(G_str, "%4f", G);
	}
	*G_string = (G_str[0] << 24) | (G_str[1] << 16) | (G_str[2] << 8) | G_str[3];

	sprintf(Q_str, "%4f", Q);
	*Q_string = (Q_str[0] << 24) | (Q_str[1] << 16) | (Q_str[2] << 8) | Q_str[3];

	for (i = 0; i < 5; i++) {
		while (*to_sw_sig != 0); // wait until hardware is doing nothing
		*coefficient = (alt_u32)(coeffs[i] * (1 << 14));
		*to_hw_sig = 1; // tell hw to process the coefficient
		while (*to_sw_sig != 1); // wait until hw is done
		*to_hw_sig = 0; // tell hw that we know it's done
	}
	printf("Beginning graph calculations...");
	bCoeffsSq = pow(b0 + b1 + b2, 2);
	aCoeffsSq = pow(1 + -a1 + -a2, 2);
	for (i = 0; i < 517; i++) {
		while (*to_sw_sig != 0); // wait until hardware is doing nothing
		addToGraph(i, b0, b1, b2, a1, a2);
		int sampleSum = 191;
		int j;
		for (j = 0; j < 8; j++)
			sampleSum += samples[j][i];
		if (sampleSum < 0) {
			sampleSum = 0;
		} else if (sampleSum > 255) {
			sampleSum = 255;
		}
		*coefficient = (alt_u32)(sampleSum);
		*to_hw_sig = 1; // tell hw to process the coefficient
		while (*to_sw_sig != 1); // wait until hw is done
		*to_hw_sig = 0; // tell hw that we know it's done
	}
	while (*to_sw_sig != 0);
	*to_hw_sig = 1;
	while (*to_sw_sig != 1);
	*to_hw_sig = 0;
	while (*to_sw_sig != 0); // wait until it's back in the reset state

	state = 0;
	printf("\nPress E to edit the filters\n");
	*to_hw_sig = 6;
}

void addToGraph(int i, double b0, double b1, double b2, double a1, double a2) {
	double w = 2 * M_PI * frequencies[i] / Fs;
	double phi = 4 * pow(sin(w / 2), 2);
	double bCalc = (b0 * b2 * phi) - ((b1 * (b0 + b2)) + (4 * b0 * b2));
	double aCalc = (1 * -a2 * phi) - ((-a1 * (1 + -a2)) + (4 * 1 * -a2));
	// printf("%f: bCalc - %f, aCalc - %f\n", F, bCalc, aCalc);
	double db = (10 * log10(bCoeffsSq + (bCalc * phi))) -
			   (10 * log10(aCoeffsSq + (aCalc * phi)));
	// each integer is 5/32 of a db.  Range is -30db to +10db.  0db is 191
	samples[biquad - 1][i] = round(db * toSample);
}
