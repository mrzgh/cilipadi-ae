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
#include <stdlib.h> // for malloc(), free()
#include "api.h"

int xor_bytes(unsigned char *x, const unsigned char *y, int len) {
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
	int i;

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

int permutation_n_inv(unsigned char *state, int rounds) {
	unsigned char x1[8];
	unsigned char x2[8];
	unsigned char x3[8];
	unsigned char x4[8];
	unsigned char temp[8];
	int i;

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

		// shuffle (reverse from the forward direction)
		memcpy(temp, x4, 8);
		memcpy(x4, x3, 8); // x3 -> x4
		memcpy(x3, x2, 8); // x2 -> x3
		memcpy(x2, x1, 8); // x1 -> x2
		memcpy(x1, temp, 8); // temp -> x1

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

//*
int main() {
	//unsigned char c[32]; // 16-byte ciphertext + 16-byte tag
	unsigned char *c;
	unsigned long long *clen;
	const unsigned char m[32] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			  	  	  	  	  	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
								  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
			  	  	  	  	  	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	unsigned char *m_dec;
	unsigned long long mlen = 32;
	//const unsigned char ad[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	const unsigned char ad[16] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
							 	   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
	unsigned long long adlen = BYTERATE;
	const unsigned char npub[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
									 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	const unsigned char k[32] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
								  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
								  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
								  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

	int i;

	//clen = &mlen;
	clen = malloc((size_t)(1));
	c = malloc((size_t)(mlen + CRYPTO_ABYTES));
	crypto_aead_encrypt(c, clen, m, mlen, ad, adlen, NULL, npub, k);


	printf("\nENCRYPTION\n");

	printf("\nPlaintext =");
	for (i = 0; i < mlen; ++i) {
		if ((i%BYTERATE) == 0)
			printf("\n");
		printf("%02x", m[i]);
	}

	printf("\nAD =");
	for (i = 0; i < adlen; ++i) {
		if ((i%BYTERATE) == 0)
			printf("\n");
		printf("%02x", ad[i]);
	}

	//printf("\nt_mlen = %2d\n", t_mlen);
	printf("\nCiphertext =");
	for (i = 0; i < (*clen - CRYPTO_ABYTES); ++i) {
		if ((i%BYTERATE) == 0)
			printf("\n");
		printf("%02x", c[i]);
	}

	printf("\nTag = \n");
	for (i = 0; i < CRYPTO_ABYTES; ++i) {
		printf("%02x", c[(*clen - CRYPTO_ABYTES)+i]);
	}


	printf("\n\nDECRYPTION\n");

	//printf("\nt_mlen = %2d\n", t_mlen);
	printf("\nCiphertext =");
	for (i = 0; i < (*clen - CRYPTO_ABYTES); ++i) {
		if ((i%BYTERATE) == 0)
			printf("\n");
		printf("%02x", c[i]);
	}

	// tamper
	//c[0] ^=1;

	m_dec = malloc((size_t)(*clen));
	if (crypto_aead_decrypt(m_dec, &mlen, NULL, c, *clen, ad, adlen, npub, k) == 0) {
		printf("\nPlaintext =");
		for (i = 0; i < mlen; ++i) {
			if ((i%BYTERATE) == 0)
				printf("\n");
			printf("%02x", m_dec[i]);
		}

		printf("\nAD =");
		for (i = 0; i < adlen; ++i) {
			if ((i%BYTERATE) == 0)
				printf("\n");
			printf("%02x", ad[i]);
		}
	}


	free(clen);
	free(c);
	free(m_dec);

	return 0;
}
//*/
