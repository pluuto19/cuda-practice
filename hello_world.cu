#include<stdio.h>
#include<stdlib.h>

__global__ void helloGPU(void){
    printf("Hello from GPU thread %d, %d", threadIdx.x, blockIdx.x);
}

int main(void){
    printf("This is host");
    helloGPU<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;
}