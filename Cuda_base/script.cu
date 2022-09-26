#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>

__global__ void cudd(){                                                       // it is a kernal/device code
	printf("Hasan Nawazish printing using cuda \n");
}

__global__ void print_blockids(){
	printf("blockIDx.x : %d, blockIDx.y : %d, blockIDx.z : %d, blockDim.x : %d, blockDim.y : %d, gridDim.x : %d, gridDim.y : %d \n",
		blockIdx.x, blockIdx.y, blockIdx.z, blockDim.x, blockDim.y, gridDim.x, gridDim.y);
}

__global__ void print_threadids(){
	printf("threadIDx.x : %d, threadIDx.y : %d, threadIDx.z : %d \n",
		threadIdx.x, threadIdx.y, threadIdx.z);
}

__global__ void unique_idx_calc_threadIdx(int * input){
	int tid = threadIdx.x;
	printf("threadIdx : %d, value : %d \n", tid, input[tid]);
}

int main(){                                                                   // Host Code
	// int nx(16), ny(16);

	// dim3 block(8,8);
	// dim3 grid(nx / block.x, ny / block.y);
	// print_blockids <<<grid,block>>>();

    int array_size = 8;
	int array_byte_size = sizeof(int) * array_size;
	int h_data[] = {23,1,3,56,43,76,76,8};
	for(int i=0; i< array_size; i++){
		printf("%d", h_data[i]);
	}
	printf("\n \n");

	int * d_data;
	cudaMalloc((void**)&d_data, array_byte_size);
	cudaMemcpy(d_data, h_data, array_byte_size, cudaMemcpyHostToDevice);
	dim3 block(4);
	dim3 grid(2);

	unique_idx_calc_threadIdx <<< grid, block >>> (d_data);


	cudaDeviceSynchronize();                                                      // wait untile previously launched kernals finishes
	cudaDeviceReset();
}
 