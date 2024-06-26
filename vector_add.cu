#include<stdio.h>
#include<stdlib.h>
#define N 512

void host_add(int *a, int *b, int *c) {
    for(int idx=0;idx<N;idx++)
        c[idx] = a[idx] + b[idx];
}

void fill_array(int *data) {
    for(int idx=0;idx<N;idx++)
        data[idx] = idx;
}
void print_output(int *a, int *b, int*c) {
    for(int idx=0;idx<N;idx++)
        printf("\n %d + %d = %d", a[idx] , b[idx], c[idx]);
}
__global__ void device_add(int *a, int *b, int *c) {
    c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}
int main(void) {
    int *a, *b, *c;
    int *d_a, *d_b, *d_c;
    int size = N * sizeof(int);

    a = (int *)malloc(size);
    b = (int *)malloc(size);
    c = (int *)malloc(size);
    fill_array(a);
    fill_array(b);

    cudaMalloc(&d_a, N * sizeof(int));
    cudaMalloc(&d_b, N * sizeof(int));
    cudaMalloc(&d_c, N * sizeof(int));

    cudaMemcpy(d_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, N* sizeof(int), cudaMemcpyHostToDevice);

    device_add<<<1,1>>>(d_a,d_b,d_c);

    cudaMemcpy(c, d_c, N * sizeof(int), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();

    print_output(a,b,c);

    free(a); free(b); free(c);

    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    return 0;
}

