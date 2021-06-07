/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include "verilog/dv/caravel/defs.h"
#include "verilog/dv/caravel/stub.c"

// --------------------------------------------------------

/*
	MPRJ Logic Analyzer Test:
		- Observes counter value through LA probes [31:0] 
		- Sets counter initial value through LA probes [63:32]
		- Flags when counter value exceeds 500 through the management SoC gpio
		- Outputs message to the UART when the test concludes successfuly
*/
int clk = 0;

void clock(){
	// clock
	reg_la2_data = 0x00000001;
	reg_la2_data = 0x00000000;
	// end clock
}

void add_value_to_shadow_register(uint32_t value, uint32_t selected_register){

	reg_la0_data = (selected_register << 5| 14 & 0x1F);
	reg_la1_data = value;
}

void read_value_from_shadow_register(uint32_t selected_register){

	reg_la0_data = (selected_register << 5| 13 & 0x1F);

}

void add_value_to_register(uint32_t value, uint32_t selected_register){

	reg_la0_data = (selected_register << 5| 2 & 0x1F);
	reg_la1_data = value;
}

void read_value_from_register(uint32_t selected_register){

	reg_la0_data = (selected_register << 5| 1 & 0x1F);

}

void main()
{

	/* Set up the housekeeping SPI to be connected internally so	*/
	/* that external pin changes don't affect it.			*/

	reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

	// Connect the housekeeping SPI to the SPI master
	// so that the CSB line is not left floating.  This allows
	// all of the GPIO pins to be used for user functions.

	// The upper GPIO pins are configured to be output
	// and accessble to the management SoC.
	// Used to flad the start/end of a test 
	// The lower GPIO pins are configured to be output
	// and accessible to the user project.  They show
	// the project count value, although this test is
	// designed to read the project count through the
	// logic analyzer probes.
	// I/O 6 is configured for the UART Tx line

        reg_mprj_io_37 = GPIO_MODE_USER_STD_OUTPUT;
		reg_mprj_io_36 = GPIO_MODE_USER_STD_OUTPUT;
		reg_mprj_io_35 = GPIO_MODE_USER_STD_OUTPUT;
		reg_mprj_io_34 = GPIO_MODE_USER_STD_OUTPUT;
		reg_mprj_io_33 = GPIO_MODE_USER_STD_OUTPUT;
		reg_mprj_io_32 = GPIO_MODE_USER_STD_OUTPUT;
		reg_mprj_io_31 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_30 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_29 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_28 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_27 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_26 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_25 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_24 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_23 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_22 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_21 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_20 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_19 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_18 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_17 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_16 = GPIO_MODE_USER_STD_OUTPUT;

        reg_mprj_io_15 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_14 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_13 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_12 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_11 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_10 = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_9  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_8  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_7  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_5  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_4  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_3  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_2  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_1  = GPIO_MODE_USER_STD_OUTPUT;
        reg_mprj_io_0  = GPIO_MODE_USER_STD_OUTPUT;

        reg_mprj_io_6  = GPIO_MODE_MGMT_STD_OUTPUT;

	// Set UART clock to 64 kbaud (enable before I/O configuration)
	reg_uart_clkdiv = 625;
	reg_uart_enable = 1;

        /* Apply configuration */
        reg_mprj_xfer = 1;
        while (reg_mprj_xfer == 1);

	// Configure LA probes 
	// outputs from the cpu are inputs for my project denoted for been 0 
	// inputs to the cpu are outpus for my project denoted for been 1
	reg_la0_oenb = reg_la0_iena = 0x00000000;    // [31:0] 
	reg_la1_oenb = reg_la1_iena = 0x00000000;    // [63:32]
	reg_la2_oenb = reg_la2_iena = 0xFFFFFFFC;    // [95:64]
	reg_la3_oenb = reg_la3_iena = 0xFFFFFFFF;    // [127:96]

	
	// Flag start of the test 
	reg_mprj_datal = 0xAB400000;

	// clock and reset
	reg_la2_data = 0x00000003;
	reg_la2_data = 0x00000000;
	// end clock

	for (uint32_t i = 0; i < 16; ++i ){
		add_value_to_shadow_register(i+1, i);
		clock();
	}
	for (uint32_t i = 0; i < 16; ++i ){
		read_value_from_shadow_register(i);
		clock();
	}

	reg_mprj_datal = 0xAB410000;
	print("\n");
	print("Monitor: Test 6 Passed\n\n");	// Makes simulation very long!
	reg_mprj_datal = 0xAB510000;
	



	
}

