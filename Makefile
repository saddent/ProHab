CUDA_PATH=$(HOME)/cuda-11.4

SSEON:
	clang SIMD.c -o SIMDON
SSEOFF:
	clang -mno-sse SIMD.c -o SIMDOFF

CUDA_dax:
	$(CUDA_PATH)/bin/nvcc -ccbin clang++ -I$(CUDA_PATH)/include -m64 -gencode arch=compute_86,code=compute_86 -o daxpy daxpy.cu

CUDA_vecadd:
	$(CUDA_PATH)/bin/nvcc -ccbin clang++ -I$(CUDA_PATH)/include -m64 -gencode arch=compute_86,code=compute_86 -o vectorAdd vectorAdd.cu
