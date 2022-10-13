#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <cstring>

__global__ void mem_trans_test_up(int * input, int array_size){
    int gid = blockIdx.x * blockDim.x + threadIdx.x;
    if(gid < array_size)
        printf("tid : %d, gid : %d, value : %d \n",threadIdx.x, gid, input[gid]);
}

int main()
{
    int size = 64;
	int byte_size = sizeof(int) * size;

	int * h_input;
    h_input = (int*)malloc(byte_size);       //allocating memory for host          //malloc returns void pointer by default so we have to cast it to int.

    time_t t;
    srand((unsigned)time(&t));
    for(int i = 0; i < size; i++){
        h_input[i] = (int)(rand() & 0xff);
    }

    int * d_input;
    //allocating memory in device        // now we will use CUDA memory functions

	cudaMalloc((void**)&d_input, byte_size);
    // transfer the initiallized array in host to device using cudaMemcpy
	cudaMemcpy(d_input, h_input, byte_size, cudaMemcpyHostToDevice);
    //kernal parameters
    dim3 block(2);
    dim3 grid(5);
    //kernal launch
    mem_trans_test_up <<<grid, block>>>(d_input,size);
    //wait until kernal processing finished
    cudaDeviceSynchronize();
    //reclaiming memory
    cudaFree(d_input);
    free(h_input);
}
