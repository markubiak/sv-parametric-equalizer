#define FINAL_INPUT_C_
#include "final_input.h"
#include "final_sm.h"
#include <stdio.h>
#include <stdlib.h>

#define true 1
#define false 0

char str[6] = {0,0,0,0,0,0}; // can store 5 characters
int i = -1;

void handle_keycode(char key) {
	if (i >= 4 && key != 0x28) // handle out of bounds
		return;
	switch (key) {
	case 0x08: // 'E'
		if (sm_init()) { // if initialization ran, clear any existing data
			for (i = 0; i < 6; i++) {
				str[i] = 0;
			}
			i = -1;
		}
		break;
	case 0x28: // ENTER
		if (i != -1) {
			sm_process_str(str);
			for (i = 0; i < 6; i++) {
				str[i] = 0;
			}
			i = -1;
		}
		break;
	case 0x1e: // '1'
		i++;
		str[i] = '1';
		break;
	case 0x1f: // '2'
		i++;
		str[i] = '2';
		break;
	case 0x20: // '3'
		i++;
		str[i] = '3';
		break;
	case 0x21: // '4'
		i++;
		str[i] = '4';
		break;
	case 0x22: // '5'
		i++;
		str[i] = '5';
		break;
	case 0x23: // '6'
		i++;
		str[i] = '6';
		break;
	case 0x24: // '7'
		i++;
		str[i] = '7';
		break;
	case 0x25: // '8'
		i++;
		str[i] = '8';
		break;
	case 0x26: // '9'
		i++;
		str[i] = '9';
		break;
	case 0x27: // '0'
		i++;
		str[i] = '0';
		break;
	case 0x37: // '.'
		i++;
		str[i] = '.';
		break;
	case 0x2d: // '-'
		i++;
		str[i] = '-';
		break;
	}
}
