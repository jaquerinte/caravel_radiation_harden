// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

<<<<<<< HEAD:verilog/dv/la_test10/la_test10_tb.v
`include "uprj_netlists.v"
`include "caravel_netlists.v"
`include "spiflash.v"
`include "tbuart.v"

module la_test10_tb;
=======
module wb_port_tb;
>>>>>>> 52a239652dd7a0722de75467858247e5f36b2500:verilog/dv/wb_port/wb_port_tb.v
	reg clock;
    reg RSTB;
	reg CSB;

	reg power1, power2;

    wire gpio;
	wire uart_tx;
    wire [37:0] mprj_io;
	wire [15:0] checkbits;

<<<<<<< HEAD:verilog/dv/la_test10/la_test10_tb.v
	assign checkbits  = mprj_io[31:16];
	assign uart_tx = mprj_io[6];
=======
	assign checkbits = mprj_io[31:16];

	assign mprj_io[3] = 1'b1;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.
>>>>>>> 52a239652dd7a0722de75467858247e5f36b2500:verilog/dv/wb_port/wb_port_tb.v

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;

	initial begin
		$dumpfile("la_test10.vcd");
		$dumpvars(0, la_test10_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
<<<<<<< HEAD:verilog/dv/la_test10/la_test10_tb.v
		repeat (200) begin
=======
		repeat (70) begin
>>>>>>> 52a239652dd7a0722de75467858247e5f36b2500:verilog/dv/wb_port/wb_port_tb.v
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test LA (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test LA (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	initial begin
<<<<<<< HEAD:verilog/dv/la_test10/la_test10_tb.v
		wait(mprj_io[25:20] == 6'd0);
		$display("LA Test 10 started");
		//wait(mprj_io[35:20] == 16'd255);
		wait(mprj_io[37:36] == 2'b10);
		wait(mprj_io[35:20] == 16'd1);
		wait(mprj_io[37:36] == 2'b00);
		
		$display("LA Test 10 Finish correctly");
		//wait(checkbits == 16'h0002);
		#10000;
		$finish;
=======
	   wait(checkbits == 16'hAB60);
		$display("Monitor: MPRJ-Logic WB Started");
		wait(checkbits == 16'hAB61);
		`ifdef GL
	    	$display("Monitor: Mega-Project WB (GL) Passed");
		`else
		    $display("Monitor: Mega-Project WB (RTL) Passed");
		`endif
	    $finish;
>>>>>>> 52a239652dd7a0722de75467858247e5f36b2500:verilog/dv/wb_port/wb_port_tb.v
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#100000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
	end

<<<<<<< HEAD:verilog/dv/la_test10/la_test10_tb.v
    	wire flash_csb;
=======
	wire flash_csb;
>>>>>>> 52a239652dd7a0722de75467858247e5f36b2500:verilog/dv/wb_port/wb_port_tb.v
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD1V8;
    	wire VDD3V3;
	wire VSS;
    
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
<<<<<<< HEAD:verilog/dv/la_test10/la_test10_tb.v
=======
		.vdda1_2  (VDD3V3),
>>>>>>> 52a239652dd7a0722de75467858247e5f36b2500:verilog/dv/wb_port/wb_port_tb.v
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("la_test10.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

	// Testbench UART
	tbuart tbuart (
		.ser_rx(uart_tx)
	);

endmodule
`default_nettype wire
