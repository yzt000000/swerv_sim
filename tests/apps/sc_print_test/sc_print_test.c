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


//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
#include "sc_print.h"
//#include "printf.h"

#define BASH_ADRS (0x00001000)
#define W_ADRS *(volatile unsigned int *) (BASH_ADRS + 0)
#define R_ADRS *(volatile unsigned int *) (BASH_ADRS + 0)
#define WRITE_REG(addr,ch)  *(volatile unsigned int *) (addr) = ch
#define READ_REG(addr,ch)  ch = *(volatile unsigned int *) (addr) 

#define SC_SIM_OUTPORT (0xd0580000)
//#define SC_SIM_OUTPORT (0x00003000)
#define CHAR_BIT (8)


void main(){
    int n;
    int i;
    int j;
    int a;
    n=2;
   //for(i=0;i<n;i++) {
   //    for(j=0;i<100;j++){
   //        WRITE_REG(SC_SIM_OUTPORT,0x21+i);
   //    }
   //}

  //WRITE_REG(SC_SIM_OUTPORT,0x31);
  //for(i=0;i<n;i++) {
  //    WRITE_REG(SC_SIM_OUTPORT,0x30);
  //}

  //uart_printf("a");
  //for(i=0;i<n;i++) {
  //    WRITE_REG(SC_SIM_OUTPORT,0x30+i);
  //}
  
  //for(i=0;i<n;i++) {
  //    WRITE_REG(SC_SIM_OUTPORT,0x31);
  //}
  //
  //int a,b,c;
  //a = 100;
  //b = 3;
  //c= a/b;

    for(i=0;i<n;i++) {
        WRITE_REG(SC_SIM_OUTPORT,0x41+i);
        WRITE_REG(SC_SIM_OUTPORT,0x42+i);
        WRITE_REG(SC_SIM_OUTPORT,0x43+i);
        WRITE_REG(SC_SIM_OUTPORT,0x0a  );
    }
        WRITE_REG(SC_SIM_OUTPORT,0x0a  );
        WRITE_REG(SC_SIM_OUTPORT,0x0a  );
        WRITE_REG(SC_SIM_OUTPORT,0x0a  );
        WRITE_REG(SC_SIM_OUTPORT,0x0a  );
        WRITE_REG(SC_SIM_OUTPORT,0x0a  );

   for (i=0;i<=10;i++) {
       READ_REG(0x300+i*4,a);
       sc_printf("%x",a);
   }
  sc_printf("\nhello world\n");
  sc_printf("hello world\n");

}

