`default_nettype none
//-----------------------------------------------------
// Project Name : a.out
// Function     : Main processor 
// Description  : This is the main processor
// Coder        : Jaquer AND VORIXO

//***Headers***
//***Module***
module decoder_output #(
        parameter integer WORD_SIZE = 32
    )
    (
        input  [1 : 0] operation_result_i ,
        input  [WORD_SIZE - 1 : 0] store_data_i ,
        output [1 : 0] operation_result_o ,
        output [WORD_SIZE - 1 : 0] store_data_o 
    );

//***Internal logic generated by compiler***  
    

//***Dumped Internal logic***
    assign operation_result_o = operation_result_i;
    assign store_data_o = store_data_i;

    
//***Handcrafted Internal logic*** 
//TODO
endmodule