#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>

__global__ void cudd(){                                                       // it is a kernal/device code
	printf("Hasan Nawazish printing using cuda");
}

int main(){                                                                   // Host Code
cudd <<<1,1>>>();
cudaDeviceSynchronize();                                                      // wait untile previously launched kernals finishes
cudaDeviceReset();
}
