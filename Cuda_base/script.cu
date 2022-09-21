#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>

__global__ void cudd(){                                                       // it is a kernal/device code
	printf("Hasan Nawazish printing using cuda \n");
}

__global__ void print_threadids(){
	printf("threadIDx.x : %d, threadIDx.y : %d, threadIDx.z : %d \n",
		threadIdx.x, threadIdx.y, threadIdx.z);
}

int main(){                                                                   // Host Code
	int nx(16), ny(16);

	dim3 block(8,8);
	dim3 grid(nx / block.x, ny / block.y);
	print_threadids <<<grid,block>>>();

	cudaDeviceSynchronize();                                                      // wait untile previously launched kernals finishes
	cudaDeviceReset();
}
 
