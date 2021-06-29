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


module majority_gate_32 #(
        parameter integer WORD_SIZE = 32
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

        input wire [WORD_SIZE - 1 : 0] value_1_i,
        input wire [WORD_SIZE - 1 : 0] value_2_i,
        input wire [WORD_SIZE - 1 : 0] value_3_i,
        output wire [WORD_SIZE - 1 : 0] result_o
    );


    sky130_fd_sc_hd__maj3_2 _maj_bit_0_ (
    .A(value_1_i[0]),
    .B(value_2_i[0]),
    .C(value_3_i[0]),
    .X(result_o[0]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_1_ (
    .A(value_1_i[1]),
    .B(value_2_i[1]),
    .C(value_3_i[1]),
    .X(result_o[1]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_2_ (
    .A(value_1_i[2]),
    .B(value_2_i[2]),
    .C(value_3_i[2]),
    .X(result_o[2]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_3_ (
    .A(value_1_i[3]),
    .B(value_2_i[3]),
    .C(value_3_i[3]),
    .X(result_o[3]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_4_ (
    .A(value_1_i[4]),
    .B(value_2_i[4]),
    .C(value_3_i[4]),
    .X(result_o[4]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_5_ (
    .A(value_1_i[5]),
    .B(value_2_i[5]),
    .C(value_3_i[5]),
    .X(result_o[5]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_6_ (
    .A(value_1_i[6]),
    .B(value_2_i[6]),
    .C(value_3_i[6]),
    .X(result_o[6]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_7_ (
    .A(value_1_i[7]),
    .B(value_2_i[7]),
    .C(value_3_i[7]),
    .X(result_o[7]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_8_ (
    .A(value_1_i[8]),
    .B(value_2_i[8]),
    .C(value_3_i[8]),
    .X(result_o[8]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_9_ (
    .A(value_1_i[9]),
    .B(value_2_i[9]),
    .C(value_3_i[9]),
    .X(result_o[9]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_10_ (
    .A(value_1_i[10]),
    .B(value_2_i[10]),
    .C(value_3_i[10]),
    .X(result_o[10]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_11_ (
    .A(value_1_i[11]),
    .B(value_2_i[11]),
    .C(value_3_i[11]),
    .X(result_o[11]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_12_ (
    .A(value_1_i[12]),
    .B(value_2_i[12]),
    .C(value_3_i[12]),
    .X(result_o[12]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_13_ (
    .A(value_1_i[13]),
    .B(value_2_i[13]),
    .C(value_3_i[13]),
    .X(result_o[13]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_14_ (
    .A(value_1_i[14]),
    .B(value_2_i[14]),
    .C(value_3_i[14]),
    .X(result_o[14]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_15_ (
    .A(value_1_i[15]),
    .B(value_2_i[15]),
    .C(value_3_i[15]),
    .X(result_o[15]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


    sky130_fd_sc_hd__maj3_2 _maj_bit_16_ (
    .A(value_1_i[16]),
    .B(value_2_i[16]),
    .C(value_3_i[16]),
    .X(result_o[16]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));



    sky130_fd_sc_hd__maj3_2 _maj_bit_17_ (
    .A(value_1_i[17]),
    .B(value_2_i[17]),
    .C(value_3_i[17]),
    .X(result_o[17]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_18_ (
    .A(value_1_i[18]),
    .B(value_2_i[18]),
    .C(value_3_i[18]),
    .X(result_o[18]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_19_ (
    .A(value_1_i[19]),
    .B(value_2_i[19]),
    .C(value_3_i[19]),
    .X(result_o[19]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_20_ (
    .A(value_1_i[20]),
    .B(value_2_i[20]),
    .C(value_3_i[20]),
    .X(result_o[20]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_21_ (
    .A(value_1_i[21]),
    .B(value_2_i[21]),
    .C(value_3_i[21]),
    .X(result_o[21]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_22_ (
    .A(value_1_i[22]),
    .B(value_2_i[22]),
    .C(value_3_i[22]),
    .X(result_o[22]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_23_ (
    .A(value_1_i[23]),
    .B(value_2_i[23]),
    .C(value_3_i[23]),
    .X(result_o[23]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_24_ (
    .A(value_1_i[24]),
    .B(value_2_i[24]),
    .C(value_3_i[24]),
    .X(result_o[24]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));
    
    sky130_fd_sc_hd__maj3_2 _maj_bit_25_ (
    .A(value_1_i[25]),
    .B(value_2_i[25]),
    .C(value_3_i[25]),
    .X(result_o[25]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_26_ (
    .A(value_1_i[26]),
    .B(value_2_i[26]),
    .C(value_3_i[26]),
    .X(result_o[26]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_27_ (
    .A(value_1_i[27]),
    .B(value_2_i[27]),
    .C(value_3_i[27]),
    .X(result_o[27]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_28_ (
    .A(value_1_i[28]),
    .B(value_2_i[28]),
    .C(value_3_i[28]),
    .X(result_o[28]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_29_ (
    .A(value_1_i[29]),
    .B(value_2_i[29]),
    .C(value_3_i[29]),
    .X(result_o[29]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_30_ (
    .A(value_1_i[30]),
    .B(value_2_i[30]),
    .C(value_3_i[30]),
    .X(result_o[30]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));

    sky130_fd_sc_hd__maj3_2 _maj_bit_31_ (
    .A(value_1_i[31]),
    .B(value_2_i[31]),
    .C(value_3_i[31]),
    .X(result_o[31]),
    .VGND(vssd1),
    .VNB(vssd1),
    .VPB(vccd1),
    .VPWR(vccd1));


endmodule
