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
 * Initializataion Phase
 */
int init_phase(unsigned char *state, const unsigned char *npub, const unsigned char *k) {
	int i;

	// fill in the key
		for (i=0; i<CRYPTO_KEYBYTES; i++) {
			state[i] = k[i];
		}

		// fill in the nonce
		for (i=CRYPTO_KEYBYTES; i<STATELEN; i++) {
			state[i] = npub[i-CRYPTO_KEYBYTES];
		}

		printf("initial state = \n");
		for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

		permutation_n(state, AROUNDS);

	return 0;
}

int ad_phase(unsigned char *state, unsigned char *state_r, const unsigned char *ad, unsigned long long adlen) {
	int i, j, s_adlen;

	s_adlen = adlen / BYTERATE;

	for (i = 0; i < s_adlen; ++i) {
		for (j = 0; j < adlen; ++j) {
			state_r[j] = ad[i*BYTERATE+j];
		}

		// XOR with AD
		xor_bytes(state, state_r, BYTERATE);

		printf("state (after XOR with AD) = \n");
		for (j=0; j<STATELEN; j++) printf("%02x", state[j]); printf("\n");

		permutation_n(state, BROUNDS);
	}

	// XOR the last bit of the state with '1' to indicate completion of AD phase
	state[STATELEN-1] ^= 1;

	return 0;
}

/*
 * enc = { 0, 1 }. 0 = decrypt, 1 = encrypt
 */
int ciphering_phase(unsigned char *state,
		unsigned char *state_r,
		const unsigned char *in,
		unsigned long long inlen,
		unsigned char *out,
		int enc) {
	int i, j;
	int t_inlen;

	t_inlen = inlen/BYTERATE;
	printf("t_mlen = %d\n", t_inlen);

	// allocate array for ciphertext
	//c = malloc((size_t)(mlen + taglen)); // ciphertext + tag

	if (enc) {
		for (i = 0; i < (t_inlen-1); ++i) {

			for (j = 0; j < BYTERATE; ++j) {
				state_r[j] = in[i*BYTERATE+j];
			}

			// XOR message with bitrate part of the state
			xor_bytes(state, state_r, BYTERATE);

			// output ciphertext
			for (j = 0; j < BYTERATE; ++j) {
				out[i*BYTERATE+j] = state[j];
			}

			printf("state (after XOR with message %2d) \n", i+1);
			for (j = 0; j < STATELEN; ++j) {
				printf("%02x", state[j]);
			}
			printf("\n");

			permutation_n(state, BROUNDS);
		}
	}
	else {
		for (i = 0; i < (t_inlen-1); ++i) {

			// XOR ciphertext with bitrate part of the state to obtain message
			for (j = 0; j < BYTERATE; ++j) {
				out[i*BYTERATE+j] = in[i*BYTERATE+j] ^ state[j];
			}

			// replace bitrate part of the state with the current ciphertext block
			for (j = 0; j < BYTERATE; ++j) {
				state[j] = in[i*BYTERATE+j];
			}

			printf("state (after XOR with ciphertext %2d) \n", i+1);
			for (j = 0; j < STATELEN; ++j) printf("%02x", state[j]); printf("\n");

			//permutation_n_inv(state, BROUNDS);
			permutation_n(state, BROUNDS);
		}
	}

	printf("state (after permutation) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	if (enc) {
		for (i = 0; i < BYTERATE; ++i) {
			state_r[i] = in[(t_inlen-1)*BYTERATE+i];
		}

		// XOR message with bitrate part of the state
		xor_bytes(state, state_r, BYTERATE);

		// output ciphertext
		for (i = 0; i < BYTERATE; ++i) {
			out[inlen-CRYPTO_ABYTES+i] = state[i];
		}
	}
	else {

		// output message
		for (j = 0; j < BYTERATE; ++j) {
			out[inlen-BYTERATE+j] = in[(t_inlen-1)*BYTERATE+j] ^ state[j];
		}

		// replace bitrate part of the state with the current ciphertext block
		for (j = 0; j < BYTERATE; ++j) {
			state[j] = in[(t_inlen-1)*BYTERATE+j];
		}
	}

	printf("state (after XOR with last input) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	return 0;
}

/*
 * Finalization Phase
 */
int finalization_phase(unsigned char *state, const unsigned char *k) {
	int i;

	permutation_n(state, AROUNDS);

	printf("state (after applying p^a_n) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	// XOR with key
	xor_bytes(state, k, CRYPTO_KEYBYTES);

	printf("state (after XOR with key) = \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");
	return 0;
}

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

	unsigned char state[STATELEN]; // state
	unsigned char state_r[BYTERATE]; // rate part of the state
	int i;

	/*
	 * Initialization
	 */
	init_phase(state, npub, k);

	// fill in the key
	/*
	for (i=0; i<CRYPTO_KEYBYTES; i++) {
		state[i] = k[i];
	}

	// fill in the nonce
	for (i=CRYPTO_KEYBYTES; i<STATELEN; i++) {
		state[i] = npub[i-16];
	}

	printf("initial state = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, AROUNDS);
	*/

	/*
	 * Processing the associated data
	 */
	printf("state (before AD phase) = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

	ad_phase(state, state_r, ad, adlen);

	/*
	// assume that we have only one AD
	for (i = 0; i < adlen; ++i) {
		state_r[i] = ad[i];
	}

	// XOR with AD
	xor_bytes(state, state_r, BYTERATE);

	printf("state (after XOR with AD) = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, BROUNDS);

	// XOR the last bit of the state with '1' to indicate completion of AD phase
	state[STATELEN-1] ^= 1;
	*/

	printf("state (after AD phase) = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");


	/*
	 * Processing the plaintext
	 */
	ciphering_phase(state, state_r, m, mlen, c, 1);

	/*
	t_mlen = mlen/BYTERATE;
	printf("t_mlen = %d\n", t_mlen);

	// allocate array for ciphertext
	//c = malloc((size_t)(mlen + taglen)); // ciphertext + tag

	for (i = 0; i < (t_mlen-1); ++i) {

		for (j = 0; j < BYTERATE; ++j) {
			state_r[j] = m[i*BYTERATE+j];
		}

		// XOR message with bitrate part of the state
		xor_bytes(state, state_r, BYTERATE);

		// output ciphertext
		for (j = 0; j < BYTERATE; ++j) {
			c[i*BYTERATE+j] = state[j];
		}

		printf("state (after XOR with message %2d) \n", i+1);
		for (j = 0; j < STATELEN; ++j) {
			printf("%02x", state[j]);
		}
		printf("\n");

		permutation_n(state, BROUNDS);
	}

	printf("state (after permutation) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	for (j = 0; j < BYTERATE; ++j) {
		state_r[j] = m[(t_mlen-1)*BYTERATE+j];
	}

	// XOR message with bitrate part of the state
	xor_bytes(state, state_r, BYTERATE);

	// output ciphertext
	for (j = 0; j < BYTERATE; ++j) {
		c[mlen-CRYPTO_ABYTES+j] = state[j];
	}

	printf("state (after XOR with last plaintext) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	//printf("clen = %llu\n", *clen);
	*/

	/*
	 * Finalization Phase
	 */
	finalization_phase(state, k);
	/*
	permutation_n(state, AROUNDS);

	printf("state (after applying p^a_n) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	// XOR with key
	xor_bytes(state, k, CRYPTO_KEYBYTES);

	printf("state (after XOR with key) = \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");
	*/

	// output the tag
	*clen = mlen + CRYPTO_ABYTES;
	for (i = 0; i < CRYPTO_ABYTES; ++i) {
		c[*clen-CRYPTO_ABYTES+i] = state[i];
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

	unsigned char state[STATELEN]; // 16-byte state
	unsigned char state_r[BYTERATE]; // 8-byte rate part of the state
	int i;
	unsigned char tag[CRYPTO_ABYTES]; // computed tag

	/*
	 * Initialization
	 */
	init_phase(state, npub, k);

	// fill in the key
	/*
	for (i=0; i<CRYPTO_KEYBYTES; i++) {
		state[i] = k[i];
	}

	// fill in the nonce
	for (i=CRYPTO_KEYBYTES; i<STATELEN; i++) {
		state[i] = npub[i-CRYPTO_KEYBYTES];
	}

	printf("initial state = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, AROUNDS);
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
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

	ad_phase(state, state_r, ad, adlen);

	/*
	// XOR with AD
	xor_bytes(state, state_r, BYTERATE);

	printf("state (after XOR with AD) = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");

	permutation_n(state, BROUNDS);

	// XOR the last bit of the state with '1' to indicate completion of AD phase
	state[STATELEN-1] ^= 1;
	*/

	printf("state (after AD phase) = \n");
	for (i=0; i<STATELEN; i++) printf("%02x", state[i]); printf("\n");


	/*
	 * Processing the ciphertext
	 */
	ciphering_phase(state, state_r, c, clen, m, 0);

	/*
	t_clen = (clen-taglen)/8;
	printf("t_mlen = %d\n", t_clen);

	// allocate array for ciphertext
	//c = malloc((size_t)(mlen + taglen)); // ciphertext + tag

	for (i = 0; i < (t_clen-1); ++i) {

		// XOR ciphertext with bitrate part of the state to obtain message
		for (j = 0; j < BYTERATE; ++j) {
			m[i*BYTERATE+j] = c[i*BYTERATE+j] ^ state[j];
		}

		// replace bitrate part of the state with the current ciphertext block
		for (j = 0; j < BYTERATE; ++j) {
			state[j] = c[i*BYTERATE+j];
		}

		printf("state (after XOR with ciphertext %2d) \n", i+1);
		for (j = 0; j < STATELEN; ++j) printf("%02x", state[j]); printf("\n");

		//permutation_n_inv(state, BROUNDS);
		permutation_n(state, BROUNDS);
	}

	printf("state (after permutation) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	*mlen = clen - taglen;

	// output message
	for (j = 0; j < BYTERATE; ++j) {
		m[*mlen-BYTERATE+j] = c[(t_clen-1)*BYTERATE+j] ^ state[j];
	}

	// replace bitrate part of the state with the current ciphertext block
	for (j = 0; j < BYTERATE; ++j) {
		state[j] = c[(t_clen-1)*BYTERATE+j];
	}

	printf("state (after XOR with last ciphertext) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	//printf("clen = %llu\n", *clen);
	*/

	/*
	 * Finalization Phase
	 */
	finalization_phase(state, k);
	/*
	permutation_n(state, AROUNDS);

	printf("state (after applying p^a_n) \n");
	for (i = 0; i < STATELEN; ++i) printf("%02x", state[i]); printf("\n");

	// XOR with key
	xor_bytes(state, k, CRYPTO_KEYBYTES);

	printf("state (after XOR with key) = \n");
	for (i = 0; i < STATELEN; ++i) {
		printf("%02x", state[i]);
	}
	*/

	// output the tag
	*mlen = clen - CRYPTO_ABYTES;
	for (i = 0; i < CRYPTO_ABYTES; ++i) {
		tag[i] = state[i];
	}

	// compare computed tag with the one received
	for (i = 0; i < CRYPTO_ABYTES; ++i) {
		if (tag[i] != c[clen-CRYPTO_ABYTES+i]) {
			printf("Ciphertext not authenticated!\n");
			return -1;
		}
	}

	return 0;
}
