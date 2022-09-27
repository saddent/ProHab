#include <iostream>
#include <omp.h>
#include <stdio.h>

#define iterations 100

int main(int argc, char *argv[]) {
    int i, a;

    /*
        How the work sharing construct works?
        The iterations are statically/dynamically mapped to the threads.
        The private iteration variables range from the start to the end of the 
        interations in the original loop. 
    */
    #pragma omp parallel for private(i, a)
        for(i = 1; i < iterations; i++){
            a = i + 1;

            printf("Thread Id : %d, a : %d, i: %d\n", omp_get_thread_num(), a, i);
            // using cout introduces unwanted interleaving for the output
            /* std::cout    << "thread: " << omp_get_thread_num()
                << "\na: " << a
                << "\ni: " << i 
                << "\n\n"; */
    }
}