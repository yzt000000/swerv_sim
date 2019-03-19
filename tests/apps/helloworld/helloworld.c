// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


#include "printf.h"

#define BASH_ADRS (0x00001000)
#define W_ADRS *(volatile unsigned int *) (BASH_ADRS + 0)
#define R_ADRS *(volatile unsigned int *) (BASH_ADRS + 0)
#define WRITE_REG(addr,ch)  *(volatile unsigned int *) (addr) = ch
#define READ_REG(addr,ch)  ch = *(volatile unsigned int *) (addr) 

int main(){
	//printf("Hello world from SweRV on FPGA!\n");
    int n;
    n=100;
    int i;
    for (i=0;i<n;i++) {
        WRITE_REG(0xd0580000,0x43);
    }
	printf("aaaaaaaaaa\n");
	return 0;
}
