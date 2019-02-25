/*
 * cilipadi.c
 *
 *  Created on: 25 Feb 2019
 *      Author: mrz
 */

#include <stdio.h>
#include "cilipadi.h"
#include "led.h"
#include "crypto_aead.h"
#include <string.h> // for memcpy

int xor_bytes(unsigned char *x, unsigned char *y, int len) {
	int i;

	for (i = 0; i < len; ++i) {
		x[i]^=y[i];
	}

	return 0;
}

int permutation_n(unsigned char *state, int rounds) {
	unsigned char x1[8];
	unsigned char x2[8];
	unsigned char x3[8];
	unsigned char x4[8];
	unsigned char temp[8];
	int i, j;

	// divide the input into 4 branches
	for (i = 0; i < 8; ++i) x1[i] = state[i];
	for (i = 0; i < 8; ++i) x2[i] = state[i+8];
	for (i = 0; i < 8; ++i) x3[i] = state[i+16];
	for (i = 0; i < 8; ++i) x4[i] = state[i+24];

	//printf("state (input to round 1) = \n");
	//for (i=0; i<32; i++) printf("%02x ", state[i]); printf("\n");

	for (i = 0; i < rounds; ++i) {
		/*
		printf("round %d\n", i);

		for (j=0; j<8; j++) printf("%02x", x1[j]); printf(" ");
		for (j=0; j<8; j++) printf("%02x", x2[j]); printf(" ");
		for (j=0; j<8; j++) printf("%02x", x3[j]); printf(" ");
		for (j=0; j<8; j++) printf("%02x", x4[j]); printf("\n");
		 */

		memcpy(temp, x1, 8);
		f_function(temp);
		xor_bytes(x2, temp, 8);

		memcpy(temp, x3, 8);
		f_function(temp);
		xor_bytes(x4, temp, 8);

		// shuffle
		memcpy(temp, x1, 8);
		memcpy(x1, x2, 8); // x2 -> x1
		memcpy(x2, x3, 8); // x3 -> x2
		memcpy(x3, x4, 8); // x4 -> x3
		memcpy(x4, temp, 8); // temp -> x4

		/*
		printf("-\n");
		for (j=0; j<8; j++) printf("%02x", x1[j]); printf(" ");
		for (j=0; j<8; j++) printf("%02x", x2[j]); printf(" ");
		for (j=0; j<8; j++) printf("%02x", x3[j]); printf(" ");
		for (j=0; j<8; j++) printf("%02x", x4[j]); printf("\n");
		*/
	}

	// put value back to state
	for (i = 0; i < 8; ++i) state[i   ] = x1[i];
	for (i = 0; i < 8; ++i) state[i+ 8] = x2[i];
	for (i = 0; i < 8; ++i) state[i+16] = x3[i];
	for (i = 0; i < 8; ++i) state[i+24] = x4[i];

	//printf("state (output of permutation_a_n)\n");
	//for (j=0; j<32; j++) printf("%02x", state[j]); printf("\n");

	return 0;
}

int f_function(unsigned char *x) {
	unsigned char led_state[4][4];
	int i, j, rounds=2;

	// decompose input into LED 4x4 state bytes
	for (i = 0; i < 16; ++i) {
		if(i%2) led_state[i/4][i%4] = x[i>>1]&0xF;
		else led_state[i/4][i%4] = (x[i>>1]>>4)&0xF;
	}

	for (i = 0; i < rounds; ++i) {
		AddConstants(led_state, i);
		SubCell(led_state);
		ShiftRow(led_state);
		MixColumn(led_state);
	}

	// put back into x
	for (i = 0; i < 4; ++i) {
		for (j = 0; j < 2; ++j) {
			x[i*2+j]  = led_state[i][j*2  ] << 4;
			x[i*2+j] |= led_state[i][j*2+1];
		}
	}

	return 0;
}

int main() {
	unsigned char c[16];
	unsigned long long *clen;
	const unsigned char m[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			  	  	  	  	  	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	unsigned long long mlen = 16;
	//const unsigned char ad[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	const unsigned char ad[8] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
	unsigned long long adlen = 8;
	const unsigned char *nsec;
	const unsigned char npub[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	const unsigned char k[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
								  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

	unsigned char x[4] = { 0x00, 0x01, 0x20, 0x30 };
	unsigned char y[4] = { 0xff, 0x12, 0x20, 0x03 };
	int i, j, t_mlen;

	printf("Test\n");
	for (i=0; i<4; i++) printf("%02x ", x[i]); printf("\n");
	for (i=0; i<4; i++) printf("%02x ", y[i]); printf("\n");
	xor_bytes(x, y, 4);

	for (i=0; i<4; i++) printf("%02x ", x[i]); printf("\n");

	clen = &mlen;
	crypto_aead_encrypt(c, clen, m, mlen, ad, adlen, nsec, npub, k);

	t_mlen = mlen / 8;
	printf("\nCiphertext =\n");
	for (i = 0; i < t_mlen; ++i) {
		for (j = 0; j < 8; ++j) {
			printf("%02x", c[i*8+j]);
		}
		printf("\n");
	}

	return 0;
}
