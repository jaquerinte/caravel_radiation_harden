`default_nettype none
//-----------------------------------------------------
// Project Name : a.out
// Function     : Main processor 
// Description  : This is the main processor
// Coder        : Jaquer AND VORIXO

//***Headers***
//***Module***
module data_verificator #(
        parameter integer WORD_SIZE = 32,
        parameter integer ECCBITS = 7,
        parameter integer VERIFICATION_PINS = 2
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
        input  wire [WORD_SIZE + ECCBITS- 1 : 0] internal_data_i ,
        input  wire [VERIFICATION_PINS - 1 : 0] redundat_validation_i,
        input  wire operate_i ,
        input  wire [2 : 0] operation_type_i,
        output reg [VERIFICATION_PINS - 1 : 0] operation_result_o ,
        output reg [WORD_SIZE - 1 : 0] store_data_o
    );

//***Internal logic generated by compiler***  


    reg [1:0] state_of_data;
    reg [WORD_SIZE-1:0] data_store;
    reg [WORD_SIZE + ECCBITS -1:0] correction_stage;
    wire [WORD_SIZE + ECCBITS  :0] data_representation;
    wire [ECCBITS -1:0] parity_bits;

    
    /*
    #######################################################################################
    # Conversion table
    #######################################################################################
    Position -> value
    0:  parity_bits_i[0]
    1:  parity_bits_i[1]
    2:  internal_data_i[0]
    3:  parity_bits_i[2]
    4:  internal_data_i[1]
    5:  internal_data_i[2]
    6:  internal_data_i[3]
    7:  parity_bits_i[3]
    8:  internal_data_i[4]
    9:  internal_data_i[5]
    10: internal_data_i[6]
    11: internal_data_i[7]
    12: internal_data_i[8]
    13: internal_data_i[9]
    14: internal_data_i[10]
    15: parity_bits_i[4]
    16: internal_data_i[11]
    17: internal_data_i[12]
    18: internal_data_i[13]
    19: internal_data_i[14]
    20: internal_data_i[15]
    21: internal_data_i[16]
    22: internal_data_i[17]
    23: internal_data_i[18]
    24: internal_data_i[19]
    25: internal_data_i[20]
    26: internal_data_i[21]
    27: internal_data_i[22]
    28: internal_data_i[23]
    29: internal_data_i[24]
    30: internal_data_i[25]
    31: parity_bits_i[5]
    32: internal_data_i[26]
    33: internal_data_i[27]
    34: internal_data_i[28]
    35: internal_data_i[29]
    36: internal_data_i[30]
    37: internal_data_i[31]
    38: parity_bits_i[6]
    #######################################################################################
    */

    
    assign parity_bits[0] = operate_i ? internal_data_i[0] ^ internal_data_i[2] ^ internal_data_i[4] ^ internal_data_i[6] ^ internal_data_i[8] ^ internal_data_i[10] ^ internal_data_i[12] ^ internal_data_i[14] ^ internal_data_i[16] ^ internal_data_i[18] ^ internal_data_i[20] ^ internal_data_i[22] ^ internal_data_i[24] ^ internal_data_i[26] ^ internal_data_i[28] ^ internal_data_i[30] ^ internal_data_i[32] ^ internal_data_i[34] ^ internal_data_i[36] : 1'b0;
    //assign parity_bits[0] = operate_i ? parity_bits_i[0] ^ internal_data_i[0] ^ internal_data_i[1]^ internal_data_i[3] ^ internal_data_i[4]  ^ internal_data_i[6] ^ internal_data_i[8]^ internal_data_i[10] ^ internal_data_i[11] ^ internal_data_i[13]^ internal_data_i[15]^ internal_data_i[17] ^ internal_data_i[19] ^ internal_data_i[21] ^ internal_data_i[23] ^ internal_data_i[25] ^ internal_data_i[26] ^ internal_data_i[28] ^ internal_data_i[30] : 1'b0;
    assign parity_bits[1] = operate_i ? internal_data_i[1] ^ internal_data_i[2] ^ internal_data_i[5] ^ internal_data_i[6] ^ internal_data_i[9] ^ internal_data_i[10] ^ internal_data_i[13] ^ internal_data_i[14] ^ internal_data_i[17] ^ internal_data_i[18] ^ internal_data_i[21] ^ internal_data_i[22] ^ internal_data_i[25] ^ internal_data_i[26] ^ internal_data_i[29] ^ internal_data_i[30] ^ internal_data_i[33] ^ internal_data_i[34]^ internal_data_i[37] : 1'b0; 
    //assign parity_bits[1] = operate_i ? parity_bits_i[1] ^ internal_data_i[0] ^ internal_data_i[2]^ internal_data_i[3] ^ internal_data_i[5]  ^ internal_data_i[6] ^ internal_data_i[9]^ internal_data_i[10] ^ internal_data_i[12] ^ internal_data_i[13]^ internal_data_i[16]^ internal_data_i[17] ^ internal_data_i[20] ^ internal_data_i[21] ^ internal_data_i[24] ^ internal_data_i[25] ^ internal_data_i[27] ^ internal_data_i[28] ^ internal_data_i[31] : 1'b0;
    assign parity_bits[2] = operate_i ? internal_data_i[3] ^ internal_data_i[4] ^ internal_data_i[5] ^ internal_data_i[6] ^ internal_data_i[11] ^ internal_data_i[12] ^ internal_data_i[13] ^ internal_data_i[14] ^ internal_data_i[19] ^ internal_data_i[20] ^ internal_data_i[21] ^ internal_data_i[22] ^ internal_data_i[27] ^ internal_data_i[28] ^ internal_data_i[29] ^ internal_data_i[30] ^ internal_data_i[35] ^ internal_data_i[36] ^ internal_data_i[37] : 1'b0; 
    //assign parity_bits[2] = operate_i ? parity_bits_i[2] ^ internal_data_i[1] ^ internal_data_i[2]^ internal_data_i[3] ^ internal_data_i[7]  ^ internal_data_i[8] ^ internal_data_i[9]^ internal_data_i[10] ^ internal_data_i[14] ^ internal_data_i[15]^ internal_data_i[16]^ internal_data_i[17] ^ internal_data_i[22] ^ internal_data_i[23] ^ internal_data_i[24] ^ internal_data_i[25] ^ internal_data_i[29] ^ internal_data_i[30] ^ internal_data_i[31] : 1'b0;
    assign parity_bits[3] = operate_i ? internal_data_i[7] ^ internal_data_i[8] ^ internal_data_i[9] ^ internal_data_i[10] ^ internal_data_i[11] ^ internal_data_i[12] ^ internal_data_i[13] ^ internal_data_i[14] ^ internal_data_i[23] ^ internal_data_i[24] ^ internal_data_i[25] ^ internal_data_i[26] ^ internal_data_i[27] ^ internal_data_i[28] ^ internal_data_i[29] ^ internal_data_i[30] : 1'b0;              
    //assign parity_bits[3] = operate_i ? parity_bits_i[3] ^ internal_data_i[4] ^ internal_data_i[5]^ internal_data_i[6] ^ internal_data_i[7]  ^ internal_data_i[8] ^ internal_data_i[9]^ internal_data_i[10] ^ internal_data_i[18] ^ internal_data_i[19]^ internal_data_i[20]^ internal_data_i[21] ^ internal_data_i[22] ^ internal_data_i[23] ^ internal_data_i[24] ^ internal_data_i[25] : 1'b0;
    assign parity_bits[4] = operate_i ? internal_data_i[15] ^ internal_data_i[16] ^ internal_data_i[17] ^ internal_data_i[18] ^ internal_data_i[19] ^ internal_data_i[20] ^ internal_data_i[21] ^ internal_data_i[22] ^ internal_data_i[23] ^ internal_data_i[24] ^ internal_data_i[25] ^ internal_data_i[26] ^ internal_data_i[27] ^ internal_data_i[28] ^ internal_data_i[29] ^ internal_data_i[30] : 1'b0;
    //assign parity_bits[4] = operate_i ? parity_bits_i[4] ^ internal_data_i[11] ^ internal_data_i[12] ^ internal_data_i[13]^ internal_data_i[14] ^ internal_data_i[15]  ^ internal_data_i[16] ^ internal_data_i[17]^ internal_data_i[18] ^ internal_data_i[19] ^ internal_data_i[20]^ internal_data_i[21]^ internal_data_i[22] ^ internal_data_i[23] ^ internal_data_i[24] ^ internal_data_i[25] : 1'b0;
    assign parity_bits[5] = operate_i ? internal_data_i[31] ^ internal_data_i[32] ^ internal_data_i[33] ^ internal_data_i[34] ^ internal_data_i[35] ^ internal_data_i[36] ^ internal_data_i[37] : 1'b0;
    //assign parity_bits[5] = operate_i ? parity_bits_i[5] ^ internal_data_i[26] ^ internal_data_i[27]^ internal_data_i[28] ^ internal_data_i[29]  ^ internal_data_i[30] ^ internal_data_i[31] : 1'b0;
    assign parity_bits[6] = operate_i ? internal_data_i[0] ^ internal_data_i[1] ^ internal_data_i[3] ^ internal_data_i[7] ^ internal_data_i[15] ^ internal_data_i[31] ^ internal_data_i[38] ^ internal_data_i[2] ^ internal_data_i[4] ^ internal_data_i[5] ^ internal_data_i[6] ^ internal_data_i[8] ^ internal_data_i[9] ^ internal_data_i[10] ^ internal_data_i[11] ^ internal_data_i[12] ^ internal_data_i[13] ^ internal_data_i[14] ^ internal_data_i[16] ^ internal_data_i[17] ^ internal_data_i[18] ^ internal_data_i[19] ^ internal_data_i[20] ^ internal_data_i[21] ^ internal_data_i[22] ^ internal_data_i[23] ^ internal_data_i[24] ^ internal_data_i[25] ^ internal_data_i[26] ^ internal_data_i[27] ^ internal_data_i[28] ^ internal_data_i[29] ^ internal_data_i[30] ^ internal_data_i[32] ^ internal_data_i[33] ^ internal_data_i[34] ^ internal_data_i[35] ^ internal_data_i[36] ^ internal_data_i[37] : 1'b0;      
    //assign parity_bits[6] = operate_i ? parity_bits_i[0] ^ parity_bits_i[1] ^ parity_bits_i[2] ^ parity_bits_i[3] ^ parity_bits_i[4] ^ parity_bits_i[5] ^ parity_bits_i[6] ^                  internal_data_i[0] ^internal_data_i[1] ^ internal_data_i[2] ^ internal_data_i[3] ^ internal_data_i[4]^ internal_data_i[5]   ^ internal_data_i[6]^ internal_data_i[7]^ internal_data_i[8]^ internal_data_i[9]^ internal_data_i[10]         ^ internal_data_i[11]^ internal_data_i[12]^ internal_data_i[13]^ internal_data_i[14]^ internal_data_i[15]^ internal_data_i[16]^ internal_data_i[17]^ internal_data_i[18]        ^ internal_data_i[19]^ internal_data_i[20]^ internal_data_i[21]^ internal_data_i[22]^ internal_data_i[23]^ internal_data_i[24]^ internal_data_i[25]^ internal_data_i[26]^ internal_data_i[27]         ^ internal_data_i[28]^ internal_data_i[29]^ internal_data_i[30]^ internal_data_i[31] : 1'b0;

    //assign data_representation = {internal_data_i[31],internal_data_i[30],internal_data_i[29],internal_data_i[28],internal_data_i[27],internal_data_i[26],parity_bits_i[5],internal_data_i[25],internal_data_i[24],internal_data_i[23],internal_data_i[22],internal_data_i[21],internal_data_i[20],internal_data_i[19],internal_data_i[18],internal_data_i[17],internal_data_i[16],internal_data_i[15],internal_data_i[14],internal_data_i[13],internal_data_i[12],internal_data_i[11],parity_bits_i[4],internal_data_i[10],internal_data_i[9],internal_data_i[8],internal_data_i[7],internal_data_i[6],internal_data_i[5],internal_data_i[4],parity_bits_i[3],internal_data_i[3],internal_data_i[2],internal_data_i[1],parity_bits_i[2],internal_data_i[0], parity_bits_i[1], parity_bits_i[0],1'b0};
    assign data_representation = {internal_data_i, 1'b0};

    always @(*) begin
        if (operate_i == 1'b1 ) begin
            if (operation_type_i[2] == 1'b0 &  operation_type_i[0] == 1'b0) begin
                if (parity_bits == 7'b0000000) begin
                state_of_data = redundat_validation_i; // this if is a ecc standart will put 00 if not will put the result of the miss match
                data_store = {data_representation[38],data_representation[37],data_representation[36],data_representation[35],data_representation[34],data_representation[33],data_representation[31],data_representation[30],data_representation[29],data_representation[28],data_representation[27],data_representation[26],data_representation[25],data_representation[24],data_representation[23],data_representation[22],data_representation[21],data_representation[20],data_representation[19],data_representation[18],data_representation[17],data_representation[15],data_representation[14],data_representation[13],data_representation[12],data_representation[11],data_representation[10],data_representation[9],data_representation[7],data_representation[6],data_representation[5], data_representation[3]};
                end
                else begin
                    if (parity_bits[6] == 1'b0) begin
                        state_of_data = 2'b10;
                        data_store = {data_representation[38],data_representation[37],data_representation[36],data_representation[35],data_representation[34],data_representation[33],data_representation[31],data_representation[30],data_representation[29],data_representation[28],data_representation[27],data_representation[26],data_representation[25],data_representation[24],data_representation[23],data_representation[22],data_representation[21],data_representation[20],data_representation[19],data_representation[18],data_representation[17],data_representation[15],data_representation[14],data_representation[13],data_representation[12],data_representation[11],data_representation[10],data_representation[9],data_representation[7],data_representation[6],data_representation[5], data_representation[3]};
                    end
                    else begin
                        state_of_data[0] = 1'b1;
                        state_of_data[1] = redundat_validation_i[1];
                        correction_stage = data_representation;
                        correction_stage[parity_bits[5:0]] = !data_representation[parity_bits[5:0]];
                        data_store = {correction_stage[38],correction_stage[37],correction_stage[36],correction_stage[35],correction_stage[34],correction_stage[33],correction_stage[31],correction_stage[30],correction_stage[29],correction_stage[28],correction_stage[27],correction_stage[26],correction_stage[25],correction_stage[24],correction_stage[23],correction_stage[22],correction_stage[21],correction_stage[20],correction_stage[19],correction_stage[18],correction_stage[17],correction_stage[15],correction_stage[14],correction_stage[13],correction_stage[12],correction_stage[11],correction_stage[10],correction_stage[9],correction_stage[7],correction_stage[6],correction_stage[5], correction_stage[3]};
                        //data_store = correction_stage ^ internal_data_i;
                        
                    end
                end
            end
            else begin
                state_of_data = redundat_validation_i;
                data_store = internal_data_i[31:0];
            end
            
        end
        else begin
        data_store = {WORD_SIZE {1'b0}}; 
        state_of_data = 2'b00;
        end
        // output the data
        store_data_o = data_store;
        operation_result_o = state_of_data;
    end

    
//***Handcrafted Internal logic*** 
//TODO
endmodule
