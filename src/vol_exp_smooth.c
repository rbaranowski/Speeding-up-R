#include <R.h>


/* This function estimates the volatility using Exponentially Weighted Exponential Average, for details see the presentation.
 * 
 * Meaning of the parameters:
 * x: a vector with data (e.g. financial returns)
 * n: length of x
 * lambda: scalar in (0,1), parameter for EWEA
 * vol: vector of the same lenght as x, here we strore the result
 * 
 */

void vol_exp_smooth(double *x, int *n, double *lambda, double *vol){
  
  unsigned int i = 0;

  vol[0] = x[0]*x[0];
  
  for(i=1; i<(*n); i++) vol[i] = (*lambda) * (x[i-1] *x[i-1]) + (1-(*lambda))*vol[i-1];
  
  
}
