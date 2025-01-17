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
//-----------------------------------------------------
// Project Name : a.out
// Function     : Main processor 
// Description  : This is the main processor
// Coder        : Jaquer AND VORIXO

//***Headers***

//***Module***
module state_counters #(
        parameter integer WORD_SIZE = 32,
        parameter integer VERIFICATION_PINS = 2,
        parameter integer WHISBONE_ADR = 32,
        parameter integer COUNTERSIZE = 32,
        parameter integer REGDIRSIZE = 5,
        parameter integer REGISTERS = 32,
        parameter [19:0]  ADDRBASE     = 20'h3000_0
    )
    (
        `ifdef USE_POWER_PINS
        inout wire vdda1,	// User area 1 3.3V supply
        inout wire vdda2,	// User area 2 3.3V supply
        inout wire vssa1,	// User area 1 analog ground
        inout wire vssa2,	// User area 2 analog ground
        inout wire vccd1,	// User area 1 1.8V supply
        inout wire vccd2,	// User area 2 1.8v supply
        inout wire vssd1,	// User area 1 digital ground
        inout wire vssd2,	// User area 2 digital ground
        `endif
        input  wire clk_i ,
        input  wire rst_i ,
        input  wire [REGDIRSIZE - 1 : 0] register_i ,
        input  wire wregister_i, 
        input  wire rregister_i,
        input  wire [3 : 0] wstrb_i,
        input  wire [WORD_SIZE -1 : 0] wdata_i,
        input  wire [WHISBONE_ADR - 1 : 0] wbs_adr_i,
        input  wire [VERIFICATION_PINS - 1 : 0] operation_result_i ,
        input  wire valid_i,
        input  wire wbs_we_i,
        output reg ready_o,
        output reg [WORD_SIZE - 1 : 0] rdata_o
    );

//***Internal logic generated by compiler***  


//***Dumped Internal logic***

    reg [COUNTERSIZE-1:0] corrected_errors   [0:REGISTERS-1];
    reg [COUNTERSIZE-1:0] uncorrected_errors [0:REGISTERS-1];
    reg [COUNTERSIZE-1:0] reads_register     [0:REGISTERS-1];
    reg [COUNTERSIZE-1:0] writes_register    [0:REGISTERS-1];
    reg [COUNTERSIZE-1:0] total_corrected_errors;
    reg [COUNTERSIZE-1:0] total_uncorrected_errors;
    reg [COUNTERSIZE-1:0] total_reads_registers;
    reg [COUNTERSIZE-1:0] total_writes_registers;


    always @(posedge clk_i) begin

        if(rst_i) begin
            total_reads_registers    <= {WORD_SIZE {1'b0}}; 
            total_writes_registers   <= {WORD_SIZE {1'b0}}; 
            total_corrected_errors   <= {WORD_SIZE {1'b0}}; 
            total_uncorrected_errors <= {WORD_SIZE {1'b0}};
            // RESET ALLLL FUCKING REGISTERS BY HAND
            // 0
            writes_register[0]    <= {WORD_SIZE {1'b0}}; 
            reads_register[0]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[0]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[0] <= {WORD_SIZE {1'b0}}; 
            // 1
            writes_register[1]    <= {WORD_SIZE {1'b0}}; 
            reads_register[1]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[1]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[1] <= {WORD_SIZE {1'b0}}; 
            // 2
            writes_register[2]    <= {WORD_SIZE {1'b0}}; 
            reads_register[2]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[2]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[2] <= {WORD_SIZE {1'b0}}; 
            // 3
            writes_register[3]    <= {WORD_SIZE {1'b0}}; 
            reads_register[3]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[3]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[3] <= {WORD_SIZE {1'b0}}; 
            // 4
            writes_register[4]    <= {WORD_SIZE {1'b0}}; 
            reads_register[4]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[4]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[4] <= {WORD_SIZE {1'b0}}; 
            // 5
            writes_register[5]    <= {WORD_SIZE {1'b0}}; 
            reads_register[5]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[5]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[5] <= {WORD_SIZE {1'b0}}; 
            // 6
            writes_register[6]    <= {WORD_SIZE {1'b0}}; 
            reads_register[6]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[6]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[6] <= {WORD_SIZE {1'b0}}; 
            // 7
            writes_register[7]    <= {WORD_SIZE {1'b0}}; 
            reads_register[7]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[7]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[7] <= {WORD_SIZE {1'b0}}; 
            // 8
            writes_register[8]    <= {WORD_SIZE {1'b0}}; 
            reads_register[8]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[8]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[8] <= {WORD_SIZE {1'b0}}; 
            // 9
            writes_register[9]    <= {WORD_SIZE {1'b0}}; 
            reads_register[9]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[9]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[9] <= {WORD_SIZE {1'b0}}; 
            // 10
            writes_register[10]    <= {WORD_SIZE {1'b0}}; 
            reads_register[10]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[10]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[10] <= {WORD_SIZE {1'b0}}; 
            // 11
            writes_register[11]    <= {WORD_SIZE {1'b0}}; 
            reads_register[11]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[11]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[11] <= {WORD_SIZE {1'b0}}; 
            // 12
            writes_register[12]    <= {WORD_SIZE {1'b0}}; 
            reads_register[12]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[12]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[12] <= {WORD_SIZE {1'b0}}; 
            // 13
            writes_register[13]    <= {WORD_SIZE {1'b0}}; 
            reads_register[13]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[13]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[13] <= {WORD_SIZE {1'b0}}; 
            // 14
            writes_register[14]    <= {WORD_SIZE {1'b0}}; 
            reads_register[14]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[14]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[14] <= {WORD_SIZE {1'b0}}; 
            // 15
            writes_register[15]    <= {WORD_SIZE {1'b0}}; 
            reads_register[15]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[15]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[15] <= {WORD_SIZE {1'b0}}; 
            // 16
            writes_register[16]    <= {WORD_SIZE {1'b0}}; 
            reads_register[16]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[16]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[16] <= {WORD_SIZE {1'b0}}; 
            // 17
            writes_register[17]    <= {WORD_SIZE {1'b0}}; 
            reads_register[17]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[17]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[17] <= {WORD_SIZE {1'b0}}; 
            // 18
            writes_register[18]    <= {WORD_SIZE {1'b0}}; 
            reads_register[18]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[18]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[18] <= {WORD_SIZE {1'b0}}; 
            // 19
            writes_register[19]    <= {WORD_SIZE {1'b0}}; 
            reads_register[19]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[19]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[19] <= {WORD_SIZE {1'b0}}; 
            // 20
            writes_register[20]    <= {WORD_SIZE {1'b0}}; 
            reads_register[20]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[20]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[20] <= {WORD_SIZE {1'b0}}; 
            // 21
            writes_register[21]    <= {WORD_SIZE {1'b0}}; 
            reads_register[21]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[21]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[21] <= {WORD_SIZE {1'b0}}; 
            // 22
            writes_register[22]    <= {WORD_SIZE {1'b0}}; 
            reads_register[22]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[22]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[22] <= {WORD_SIZE {1'b0}}; 
            // 23
            writes_register[23]    <= {WORD_SIZE {1'b0}}; 
            reads_register[23]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[23]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[23] <= {WORD_SIZE {1'b0}}; 
            // 24
            writes_register[24]    <= {WORD_SIZE {1'b0}}; 
            reads_register[24]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[24]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[24] <= {WORD_SIZE {1'b0}}; 
            // 25
            writes_register[25]    <= {WORD_SIZE {1'b0}}; 
            reads_register[25]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[25]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[25] <= {WORD_SIZE {1'b0}}; 
            // 26
            writes_register[26]    <= {WORD_SIZE {1'b0}}; 
            reads_register[26]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[26]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[26] <= {WORD_SIZE {1'b0}}; 
            // 27
            writes_register[27]    <= {WORD_SIZE {1'b0}}; 
            reads_register[27]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[27]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[27] <= {WORD_SIZE {1'b0}}; 
            // 28
            writes_register[28]    <= {WORD_SIZE {1'b0}}; 
            reads_register[28]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[28]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[28] <= {WORD_SIZE {1'b0}}; 
            // 29
            writes_register[29]    <= {WORD_SIZE {1'b0}}; 
            reads_register[29]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[29]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[29] <= {WORD_SIZE {1'b0}}; 
            // 30
            writes_register[30]    <= {WORD_SIZE {1'b0}}; 
            reads_register[30]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[30]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[30] <= {WORD_SIZE {1'b0}}; 
            // 28
            writes_register[31]    <= {WORD_SIZE {1'b0}}; 
            reads_register[31]     <= {WORD_SIZE {1'b0}}; 
            corrected_errors[31]   <= {WORD_SIZE {1'b0}}; 
            uncorrected_errors[31] <= {WORD_SIZE {1'b0}}; 
           
            ready_o <= 1'b0;
        end
        else begin
            if (wregister_i) begin
                total_writes_registers <= total_writes_registers + 1;
                writes_register[register_i] <= writes_register[register_i] + 1;
            end
            if (rregister_i) begin
                total_reads_registers  <= total_reads_registers + 1;
                reads_register[register_i] <= reads_register[register_i] + 1;
                if (operation_result_i[0] == 1'b1) begin
                    total_corrected_errors <= total_corrected_errors + 1;
                    corrected_errors[register_i] <= corrected_errors[register_i] + 1;
                end
                if (operation_result_i[1] == 1'b1) begin
                    total_uncorrected_errors <= total_uncorrected_errors + 1;
                    uncorrected_errors[register_i] <= uncorrected_errors[register_i] + 1;
                end
            end

            if (valid_i && wbs_adr_i[31:12] == ADDRBASE) begin
                case (wbs_adr_i[3:0]) 
                4'h0: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) reads_register[wbs_adr_i[8:4]][7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) reads_register[wbs_adr_i[8:4]][15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) reads_register[wbs_adr_i[8:4]][23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) reads_register[wbs_adr_i[8:4]][31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {reads_register[wbs_adr_i[8:4]]};
                    end

                end
                4'h4: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) writes_register[wbs_adr_i[8:4]][7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) writes_register[wbs_adr_i[8:4]][15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) writes_register[wbs_adr_i[8:4]][23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) writes_register[wbs_adr_i[8:4]][31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {writes_register[wbs_adr_i[8:4]]};
                    end
                end
                4'h8: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) corrected_errors[wbs_adr_i[8:4]][7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) corrected_errors[wbs_adr_i[8:4]][15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) corrected_errors[wbs_adr_i[8:4]][23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) corrected_errors[wbs_adr_i[8:4]][31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {corrected_errors[wbs_adr_i[8:4]]};
                    end
                end
                4'hC: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) uncorrected_errors[wbs_adr_i[8:4]][7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) uncorrected_errors[wbs_adr_i[8:4]][15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) uncorrected_errors[wbs_adr_i[8:4]][23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) uncorrected_errors[wbs_adr_i[8:4]][31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {uncorrected_errors[wbs_adr_i[8:4]]};
                    end
                end
                default: ready_o <= 1'b0;
                
                endcase
                
            end
            else if (valid_i && wbs_adr_i[31:12] == ADDRBASE + 20'h000_1) begin 
                case (wbs_adr_i[3:0]) 
                4'h0: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) total_reads_registers[7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) total_reads_registers[15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) total_reads_registers[23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) total_reads_registers[31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {total_reads_registers};
                    end

                end
                4'h4: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) total_writes_registers[7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) total_writes_registers[15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) total_writes_registers[23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) total_writes_registers[31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {total_writes_registers};
                    end
                end
                4'h8: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) total_corrected_errors[7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) total_corrected_errors[15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) total_corrected_errors[23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) total_corrected_errors[31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {total_corrected_errors};
                    end
                end
                4'hC: begin
                    ready_o <= 1'b1;
                    if (wbs_we_i) begin
                        if (wstrb_i[0]) total_uncorrected_errors[7:0]   <= wdata_i[7:0];
                        if (wstrb_i[1]) total_uncorrected_errors[15:8]  <= wdata_i[15:8];
                        if (wstrb_i[2]) total_uncorrected_errors[23:16] <= wdata_i[23:16];
                        if (wstrb_i[3]) total_uncorrected_errors[31:24] <= wdata_i[31:24];
                    end
                    else begin
                        rdata_o <= {total_uncorrected_errors};
                    end
                end
                default: ready_o <= 1'b1; // if is not one put 1 to continue the wisbone execution if the addrss is bad
                
                endcase

            end
            else begin
                ready_o <= 1'b0;
            end
        end
    end

    
//***Handcrafted Internal logic*** 
//TODO
endmodule
