#include<stdio.h>
#include<stdlib.h>

__global__ void mythreadfunc(void){
    printf("Thread and Block ID %d,%d,%d,%d \n", threadIdx.x, threadIdx.y, blockIdx.x, blockIdx.y);
}

int main(void){
    printf("1 thread and 1 block\n");
    mythreadfunc<<<1,1>>>();
    cudaDeviceSynchronize();
    printf("10 threads in one block\n");
    mythreadfunc<<<1,10>>>();
    cudaDeviceSynchronize();
    printf("10 blocks and 1 thread\n");
    mythreadfunc<<<10,1>>>();
    cudaDeviceSynchronize();
    printf("10 blocks and 10 threads per block\n");
    mythreadfunc<<<10,10>>>();
    cudaDeviceSynchronize();
}