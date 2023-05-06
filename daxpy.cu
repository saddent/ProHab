#include <cuda_runtime.h>

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

clock_t diff, start, end;

__global__ void daxpy(const int n, double *x, double *y, double *z){
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  
  if(i < n){
    z[i] = 35.0*x[i] + y[i];
  }
}

int main(void){
  cudaError_t err = cudaSuccess;
  
  unsigned numElements = 50000;

  size_t size = numElements * sizeof(double);
  printf("addition of %d elements]\n",numElements);

  // Allocate the host input vector A
  double *h_A = (double *)malloc(size);

  // Allocate the host input vector B
  double *h_B = (double *)malloc(size);

  // Allocate the host input vector B
  double *h_C = (double *)malloc(size);

  // Verify that allocations succeeded
  if (h_A == NULL || h_B == NULL || h_C == NULL) {
    fprintf(stderr, "Failed to allocate host vectors!\n");
    exit(EXIT_FAILURE);
  }

  // Initialize the host input vectors
  for (int i = 0; i < numElements; ++i) {
    h_A[i] = rand() / (double)RAND_MAX;
    h_B[i] = rand() / (double)RAND_MAX;
    h_C[i] = rand() / (double)RAND_MAX;
  }

  double *d_A = NULL;
  err = cudaMalloc((void **)&d_A, size);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  double *d_B = NULL;
  err = cudaMalloc((void **)&d_B, size);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  double *d_C = NULL;
  err = cudaMalloc((void **)&d_C, size);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }


  printf("Copy input data from the host memory to the CUDA device\n");
  err = cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  err = cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  err = cudaMemcpy(d_C, h_C, size, cudaMemcpyHostToDevice);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  int threadsPerBlock = 256;

  // TODO : understand why numElements + threadsPerBlock?
  int blocksPerGrid = (numElements + threadsPerBlock -1) / threadsPerBlock;

  printf("CUDA kernel launch with %d blocks of %d threads\n", blocksPerGrid,
         threadsPerBlock);

   start = clock();
  daxpy<<<blocksPerGrid, threadsPerBlock>>>(numElements, d_A, d_B, d_C);
  end = clock();
  
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

    // Copy the device result vector in device memory to the host result vector
  // in host memory.
  printf("Copy output data from the CUDA device to the host memory\n");
  err = cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

  printf("Time Taken : %ld \n", end-start);
  // Verify that the result vector is correct
  for (int i = 0; i < numElements; ++i) {
    if (fabs(35.0*h_A[i] + h_B[i] - h_C[i]) > 1e-5) {
      fprintf(stderr, "Result verification failed at element %d!\n", i);
      exit(EXIT_FAILURE);
    }
  }

  printf("Test PASSED\n");

  // Free device global memory
  err = cudaFree(d_A);
  
  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  err = cudaFree(d_B);

  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }

  err = cudaFree(d_C);
  
  if (err != cudaSuccess) {
    exit(EXIT_FAILURE);
  }
  
  
  free(h_A);
  free(h_B);
  return 0;
}
