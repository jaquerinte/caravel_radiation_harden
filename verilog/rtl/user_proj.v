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
/*
 *-------------------------------------------------------------
 *
 * user_proj
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj #(
    parameter integer WORD_SIZE = 32,
    parameter integer REGISTERS = 32,
    parameter integer REGDIRSIZE = 5,
    parameter integer ECCBITS = 7,
    parameter integer VERIFICATION_PINS = 2,
    parameter integer WHISBONE_ADR = 32,
    parameter integer COUNTERSIZE = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;

    wire [WORD_SIZE-1:0] rdata; 
    wire [WORD_SIZE-1:0] wdata;
    wire [WORD_SIZE-1:0] output_data;
    wire [VERIFICATION_PINS-1:0] output_verification;

    wire valid;
    wire [3:0] wstrb;
    wire [WORD_SIZE-1:0] la_write;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = rdata;
    assign wdata = wbs_dat_i;

    // IO
    assign io_out = {output_verification,output_data[15:0], 20'b0};//{6'b000000,output_data};
    assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA probes 
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;
    // Assuming LA probes [63:32] are for controlling the input data
    //assign la_write = ~la_oenb[63:32] & ~{WORD_SIZE{valid}};
    assign la_data_out = {output_data, output_verification,{(127-WORD_SIZE+VERIFICATION_PINS){1'b0}}};

    register_file #(
        .WORD_SIZE (WORD_SIZE),
        .REGISTERS (REGISTERS),
        .WHISBONE_ADR (WHISBONE_ADR),
        .VERIFICATION_PINS (VERIFICATION_PINS),
        .REGDIRSIZE (REGDIRSIZE),
        .ECCBITS (ECCBITS),
        .COUNTERSIZE (COUNTERSIZE)
    ) register_file(
        .clk_i(clk),
        .rst_i(rst),
        .valid_i(valid),
        .wstrb_i(wstrb),
        .wdata_i(wdata),
        .wbs_we_i(wbs_we_i),
        .data_to_register_i(la_data_in[63:32]),
        .register_i(la_data_in[6:2]),
        .wregister_i(la_data_in[1]),
        .rregister_i(la_data_in[0]),
        .whisbone_addr_i (wbs_adr_i),
        .store_data_o(output_data),
        .operation_result_o(output_verification),
        .ready_o(wbs_ack_o),
        .rdata_o(rdata)
    );

endmodule
`default_nettype wire
