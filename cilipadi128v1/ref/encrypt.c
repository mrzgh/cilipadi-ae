/*
 * encrypt.c
 *
 *  Created on: 22 Feb 2019
 *      Author: mrz
 */

#include "crypto_aead.h"
#include "led.h"
#include "cilipadi.h"
#include <stdio.h>

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
	unsigned char state_r[8]; // 8-byte bitrate part of the state
	const unsigned char iv[8] = {0x00, 0x80, 0x00, 0x40, 0x12, 0x10, 0x04, 0x00};
	int i, j, t_mlen;

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
	for (i=24; i<32; i++) {
		state[i] = npub[i-24];
	}

	printf("initial state = \n");
	for (i=0; i<32; i++) printf("%02x ", state[i]); printf("\n");

	permutation_n(state, 18);

	/*
	 * Padding of the associated data and message
	 */


	/*
	 * Processing the associated data
	 */
	// bitrate r = 64 bits
	// assume that we have only one AD
	for (i = 0; i < adlen; ++i) {
		state_r[i] = ad[i];
	}

	printf("state (before AD phase) = \n");
	for (i=0; i<32; i++) printf("%02x", state[i]); printf("\n");

	// XOR with AD
	xor_bytes(state, state_r, 8);

	printf("state (after XOR with AD = \n");
	for (i=0; i<32; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, 16);

	// XOR the last bit of the state with '1' to indicate completion of AD phase
	state[31] ^= 1;

	printf("state (after AD phase) = \n");
	for (i=0; i<32; i++) printf("%02x", state[i]); printf("\n");


	/*
	 * Processing the plaintext
	 */
	t_mlen = mlen/8;
	for (i = 0; i < t_mlen; ++i) {

		for (j = 0; j < 8; ++j) {
			state_r[j] = m[i*8+j];
		}

		// XOR message with bitrate part of the state
		xor_bytes(state, state_r, 8);

		// output ciphertext
		for (j = 0; j < 8; ++j) {
			c[i*8+j] = state[j];
		}

		permutation_n(state, 16);
	}

	//printf("clen = %llu\n", *clen);

	printf("state = \n");
	for (i = 0; i < 32; ++i) {
		printf("%02x", state[i]);
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

	return 0;
}
