/*
 * encrypt.c
 *
 *  Created on: 22 Feb 2019
 *      Author: mrz
 */

#include "crypto_aead.h"
#include "led.h"
#include "cilipadi.h"
#include "api.h"
#include <stdio.h>
//#include <stdlib.h> // malloc() and free()

/*
 * the code for the AEAD implementation goes here,
 *
 * generating a ciphertext c[0],c[1],...,c[*clen-1]
 * from a plaintext m[0],m[1],...,m[mlen-1]
 * and associated data ad[0],ad[1],...,ad[adlen-1]
 * and nonce npub[0],npub[1],...
 * and secret key k[0],k[1],...
 * the implementation shall not use nsec
 *
 */
int crypto_aead_encrypt(
	unsigned char *c,
	unsigned long long *clen,
	const unsigned char *m,
	unsigned long long mlen,
	const unsigned char *ad,
	unsigned long long adlen,
	const unsigned char *nsec,
	const unsigned char *npub,
	const unsigned char *k) {

	unsigned char state[32]; // 16-byte state
	unsigned char state_r[8]; // 8-byte rate part of the state
	const unsigned char iv[8] = {0x00, 0x80, 0x00, 0x40, 0x12, 0x10, 0x04, 0x00};
	int i, j, t_mlen;
	int nlen = 32; // the length of permutation in bytes
	int taglen = 16; // length of the tag in bytes

	/*
	 * Initialization
	 */

	// fill in the IV
	for (i=0; i<8; i++) {
		state[i] = iv[i];
	}

	// fill in the key
	for (i=8; i<24; i++) {
		state[i] = k[i-8];
	}

	// fill in the nonce
	for (i=24; i<nlen; i++) {
		state[i] = npub[i-24];
	}

	printf("initial state = \n");
	for (i=0; i<nlen; i++) printf("%02x ", state[i]); printf("\n");

	permutation_n(state, 18);

	/*
	 * Processing the associated data
	 */
	// bitrate r = 64 bits
	// assume that we have only one AD
	for (i = 0; i < adlen; ++i) {
		state_r[i] = ad[i];
	}

	printf("state (before AD phase) = \n");
	for (i=0; i<nlen; i++) printf("%02x", state[i]); printf("\n");

	// XOR with AD
	xor_bytes(state, state_r, 8);

	printf("state (after XOR with AD = \n");
	for (i=0; i<nlen; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, 16);

	// XOR the last bit of the state with '1' to indicate completion of AD phase
	state[31] ^= 1;

	printf("state (after AD phase) = \n");
	for (i=0; i<nlen; i++) printf("%02x", state[i]); printf("\n");


	/*
	 * Processing the plaintext
	 */
	t_mlen = mlen/8;
	printf("t_mlen = %d\n", t_mlen);

	// allocate array for ciphertext
	//c = malloc((size_t)(mlen + taglen)); // ciphertext + tag

	for (i = 0; i < (t_mlen-1); ++i) {

		for (j = 0; j < 8; ++j) {
			state_r[j] = m[i*8+j];
		}

		// XOR message with bitrate part of the state
		xor_bytes(state, state_r, 8);

		// output ciphertext
		for (j = 0; j < 8; ++j) {
			c[i*8+j] = state[j];
		}

		printf("state (after XOR with message %2d) \n", i+1);
		for (j = 0; j < nlen; ++j) {
			printf("%02x", state[j]);
		}
		printf("\n");

		permutation_n(state, 16);
	}

	for (j = 0; j < 8; ++j) {
		state_r[j] = m[(t_mlen-1)*8+j];
	}

	// XOR message with bitrate part of the state
	xor_bytes(state, state_r, 8);

	// output ciphertext
	for (j = 0; j < 8; ++j) {
		c[mlen-8+j] = state[j];
	}

	printf("state (after XOR with last plaintext) \n");
	for (i = 0; i < nlen; ++i) {
		printf("%02x", state[i]);
	}
	printf("\n");

	//printf("clen = %llu\n", *clen);

	/*
	 * Finalization Phase
	 */
	permutation_n(state, 18);

	printf("state (after applying p^a_n) \n");
	for (i = 0; i < nlen; ++i) {
		printf("%02x", state[i]);
	}
	printf("\n");

	// XOR with key
	xor_bytes(state, k, 16);

	printf("state (after XOR with key) = \n");
	for (i = 0; i < nlen; ++i) {
		printf("%02x", state[i]);
	}

	// output the tag
	*clen = mlen + taglen;
	for (i = 0; i < taglen; ++i) {
		c[*clen-taglen+i] = state[i];
	}

	return 0;
}

/*
 * the code for the AEAD implementation goes here,
 *
... generating a plaintext m[0],m[1],...,m[*mlen-1]
... and secret message number nsec[0],nsec[1],...
... from a ciphertext c[0],c[1],...,c[clen-1]
... and associated data ad[0],ad[1],...,ad[adlen-1]
... and nonce number npub[0],npub[1],...
... and secret key k[0],k[1],... ...
 */

int crypto_aead_decrypt(
	unsigned char *m,
	unsigned long long *mlen,
	unsigned char *nsec,
	const unsigned char *c,
	unsigned long long clen,
	const unsigned char *ad,
	unsigned long long adlen,
	const unsigned char *npub,
	const unsigned char *k) {

	unsigned char state[32]; // 16-byte state
	unsigned char state_r[8]; // 8-byte rate part of the state
	const unsigned char iv[8] = {0x00, 0x80, 0x00, 0x40, 0x12, 0x10, 0x04, 0x00};
	int i, j, t_clen;
	int nlen = 32; // the length of permutation in bytes
	int taglen = 16; // length of the tag in bytes
	unsigned char tag[16]; // computed tag

	/*
	 * Initialization
	 */

	// fill in the IV
	for (i=0; i<8; i++) {
		state[i] = iv[i];
	}

	// fill in the key
	for (i=8; i<24; i++) {
		state[i] = k[i-8];
	}

	// fill in the nonce
	for (i=24; i<nlen; i++) {
		state[i] = npub[i-24];
	}

	printf("initial state = \n");
	for (i=0; i<nlen; i++) printf("%02x ", state[i]); printf("\n");

	permutation_n(state, 18);

	/*
	 * Processing the associated data
	 */
	// bitrate r = 64 bits
	// assume that we have only one AD
	for (i = 0; i < adlen; ++i) {
		state_r[i] = ad[i];
	}

	printf("state (before AD phase) = \n");
	for (i=0; i<nlen; i++) printf("%02x", state[i]); printf("\n");

	// XOR with AD
	xor_bytes(state, state_r, 8);

	printf("state (after XOR with AD = \n");
	for (i=0; i<nlen; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, 16);

	// XOR the last bit of the state with '1' to indicate completion of AD phase
	state[31] ^= 1;

	printf("state (after AD phase) = \n");
	for (i=0; i<nlen; i++) printf("%02x", state[i]); printf("\n");


	/*
	 * Processing the ciphertext
	 */
	t_clen = (clen-taglen)/8;
	printf("t_mlen = %d\n", t_clen);

	// allocate array for ciphertext
	//c = malloc((size_t)(mlen + taglen)); // ciphertext + tag

	for (i = 0; i < (t_clen-1); ++i) {

		// XOR ciphertext with bitrate part of the state to obtain message
		for (j = 0; j < 8; ++j) {
			m[i*8+j] = c[i*8+j] ^ state[j];
		}

		// replace bitrate part of the state with the current ciphertext block
		for (j = 0; j < 8; ++j) {
			state[j] = c[i*8+j];
		}

		printf("state (after XOR with ciphertext %2d) \n", i+1);
		for (j = 0; j < nlen; ++j) {
			printf("%02x", state[j]);
		}
		printf("\n");

		permutation_n_inv(state, 16);
	}

	*mlen = clen - taglen;

	// output message
	for (j = 0; j < 8; ++j) {
		m[*mlen-8+j] = c[(t_clen-1)*8+j] ^ state[j];
	}

	// replace bitrate part of the state with the current ciphertext block
	for (j = 0; j < 8; ++j) {
		state[j] = c[(t_clen-1)*8+j];
	}

	printf("state (after XOR with last ciphertext) \n");
	for (i = 0; i < nlen; ++i) {
		printf("%02x", state[i]);
	}
	printf("\n");

	//printf("clen = %llu\n", *clen);

	/*
	 * Finalization Phase
	 */
	permutation_n(state, 18);

	printf("state (after applying p^a_n) \n");
	for (i = 0; i < nlen; ++i) {
		printf("%02x", state[i]);
	}
	printf("\n");

	// XOR with key
	xor_bytes(state, k, 16);

	printf("state (after XOR with key) = \n");
	for (i = 0; i < nlen; ++i) {
		printf("%02x", state[i]);
	}

	// output the tag
	for (i = 0; i < taglen; ++i) {
		tag[i] = state[i];
	}

	// compare computed tag with the one received
	for (i = 0; i < taglen; ++i) {
		if (tag[i] != c[clen-taglen+i]) {
			printf("Ciphertext not authenticated!\n");
			return -1;
		}
	}

	return 0;
}
