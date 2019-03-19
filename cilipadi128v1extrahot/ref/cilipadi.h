/*
 * cilipadi.h
 *
 *  Created on: 25 Feb 2019
 *      Author: mrz
 */

#ifndef CILIPADI128V1_REF_CILIPADI_H_
#define CILIPADI128V1_REF_CILIPADI_H_

#define BYTERATE 8 // bitrate in bytes
#define AROUNDS 18 // number of rounds for P_{a,n}
#define BROUNDS 16 // number of rounds for P_{b,n}
#define STATELEN 32 // state size in bytes

int permutation_n(unsigned char *state, int rounds);
int permutation_n_inv(unsigned char *state, int rounds);
int f_function(unsigned char *x);
int xor_bytes(unsigned char *x, const unsigned char *y, int len);

#endif /* CILIPADI128V1_REF_CILIPADI_H_ */
