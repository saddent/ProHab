#include <stdio.h>
#include <time.h>
#include <stdlib.h>

clock_t diff, start, end;

void daxpy(int n, double a, double *x, double *y){
  for (int i = 0; i < n;i++){
    y[i] = a*x[i] + y[i];
  }
}

int main(void){
  unsigned numElements = 50000;

  size_t size = numElements * sizeof(double);
  printf("addition of %d elements]\n",numElements);

  // Allocate the host input vector A
  double *h_A = (double *)malloc(size);

  // Allocate the host input vector B
  double *h_B = (double *)malloc(size);

  // Verify that allocations succeeded
  if (h_A == NULL || h_B == NULL) {
    fprintf(stderr, "Failed to allocate host vectors!\n");
    exit(EXIT_FAILURE);
  }

  // Initialize the host input vectors
  for (int i = 0; i < numElements; ++i) {
    h_A[i] = rand() / (double)RAND_MAX;
    h_B[i] = rand() / (double)RAND_MAX;
  }
  start = clock();
  daxpy(numElements, 35.0, h_A, h_B);
  end = clock();
  printf("Time Taken : %ld \n", end-start);
  free(h_A);
  free(h_B);
  return 0;
}
