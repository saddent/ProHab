SSEON:
	clang SIMD.c -o SIMD
SSEOFF:
	clang -mno-sse SIMD.c -o SIMD-SSE
