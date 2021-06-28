`default_nettype none
//-----------------------------------------------------
// Project Name : a.out
// Function     : Main processor 
// Description  : This is the main processor
// Coder        : Jaquer AND VORIXO

//***Headers***

//***Module***


module register_file #(
        parameter integer WORD_SIZE = 32,
        parameter integer REGISTERS = 32,
        parameter integer REGDIRSIZE = 5,
        parameter integer ECCBITS = 7,
        parameter integer WHISBONE_ADR = 32,
        parameter integer VERIFICATION_PINS = 2,
        parameter integer COUNTERSIZE = 32
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
        // whishbone interface
        input wire valid_i,
        input wire [3:0] wstrb_i,
        input wire [WORD_SIZE - 1 : 0] wdata_i,
        input wire [WHISBONE_ADR - 1 : 0] wbs_adr_i,
        input wire wbs_we_i,
        // end whishbone interface
        input  wire [2 : 0] operation_type_i,
        input  wire [WORD_SIZE - 1 : 0] data_to_register_i ,
        input  wire [REGDIRSIZE - 1 : 0] register_i ,
        input  wire wregister_i ,
        input  wire rregister_i ,
        output wire [WORD_SIZE - 1 : 0] store_data_o ,
        output wire [VERIFICATION_PINS - 1 : 0] operation_result_o, 
        // whishbone interface
        output wire ready_o,
        output wire operational_o,
        output wire [WORD_SIZE - 1 : 0] rdata_o
        // end whishbone interface
    );

//***Internal logic generated by compiler***  
    wire [WORD_SIZE + ECCBITS- 1 : 0] data_to_register_PCW_RD; // wiring between data_to_register_o of module PCW and data_to_register_i of module RD
    wire [WORD_SIZE + ECCBITS - 1 : 0] store_data_RD_DV; // wiring between store_data_o of module RD and internal_data_i of module DV
    wire [VERIFICATION_PINS - 1 : 0] redunancy_output_DV_PMU; 
    wire [VERIFICATION_PINS - 1 : 0] operation_result_DV_PMU; // wiring between operation_result_o of module DV and operation_result_i of module PMU
    wire ready_pmu; // wire to connect to the PMU
    wire ready_pmu_backup; // wire to connect to the PMU
    wire ready_register;// wire to connecto to the register data
    wire [WORD_SIZE - 1 : 0] rdata_register; // wire that carries the data form de register data
    wire [WORD_SIZE - 1 : 0] rdata_pmu; // wire that carries the data form de pmu 
    wire [WORD_SIZE - 1 : 0] rdata_pmu_backup; // wire that carries the data form de pmu backup
    wire [WORD_SIZE - 1 : 0] store_data_DV_DO; // wiring between store_data_o of module DV and store_data_i of module DO

    assign ready_o = ready_pmu | ready_register | ready_pmu_backup;
    assign rdata_o = ready_pmu ? rdata_pmu : ready_pmu_backup ? rdata_pmu_backup : rdata_register;

    parity_calculator #(
        .WORD_SIZE (WORD_SIZE),
        .ECCBITS (ECCBITS)
    )
    inst_PCW(
        `ifdef USE_POWER_PINS
        .vdda1(vdda1),	// User area 1 3.3V power
        .vdda2(vdda2),	// User area 2 3.3V power
        .vssa1(vssa1),	// User area 1 analog ground
        .vssa2(vssa2),	// User area 2 analog ground
        .vccd1(vccd1),	// User area 1 1.8V power
        .vccd2(vccd2),	// User area 2 1.8V power
        .vssd1(vssd1),	// User area 1 digital ground
        .vssd2(vssd2),	// User area 2 digital ground
        `endif
        .data_to_register_i       (data_to_register_i ),
        .operate_i                (wregister_i ),
        .operation_type_i         (operation_type_i),
        .data_to_register_o       (data_to_register_PCW_RD)
    );

    register_data #(
        .WORD_SIZE (WORD_SIZE),
        .REGISTERS (REGISTERS),
        .REGDIRSIZE (REGDIRSIZE),
        .ECCBITS (ECCBITS),
        .WHISBONE_ADR (WHISBONE_ADR),
        .ADDRBASE (20'h3010_0)

    )
    inst_RD(
        `ifdef USE_POWER_PINS
        .vdda1(vdda1),	// User area 1 3.3V power
        .vdda2(vdda2),	// User area 2 3.3V power
        .vssa1(vssa1),	// User area 1 analog ground
        .vssa2(vssa2),	// User area 2 analog ground
        .vccd1(vccd1),	// User area 1 1.8V power
        .vccd2(vccd2),	// User area 2 1.8V power
        .vssd1(vssd1),	// User area 1 digital ground
        .vssd2(vssd2),	// User area 2 digital ground
        `endif
        .clk_i                     (clk_i ),
        .rst_i                     (rst_i ),
        .data_to_register_i        (data_to_register_PCW_RD),
        .register_i                (register_i ),
        .wregister_i               (wregister_i ),
        .rregister_i               (rregister_i ),
        .operation_type_i          (operation_type_i),
        .valid_i                   (valid_i),
        .wstrb_i                   (wstrb_i),
        .wbs_we_i                  (wbs_we_i),
        .wdata_i                   (wdata_i),
        .wbs_adr_i                 (wbs_adr_i),
        .store_data_o              (store_data_RD_DV),
        .operational_o             (operational_o),
        .ready_o                   (ready_register),
        .rdata_o                   (rdata_register),
        .redundat_validation_o (redunancy_output_DV_PMU)
    );

    data_verificator #(
        .WORD_SIZE (WORD_SIZE),
        .ECCBITS (ECCBITS),
        .VERIFICATION_PINS (VERIFICATION_PINS)
    )
    inst_DV(
        `ifdef USE_POWER_PINS
        .vdda1(vdda1),	// User area 1 3.3V power
        .vdda2(vdda2),	// User area 2 3.3V power
        .vssa1(vssa1),	// User area 1 analog ground
        .vssa2(vssa2),	// User area 2 analog ground
        .vccd1(vccd1),	// User area 1 1.8V power
        .vccd2(vccd2),	// User area 2 1.8V power
        .vssd1(vssd1),	// User area 1 digital ground
        .vssd2(vssd2),	// User area 2 digital ground
        `endif
        .internal_data_i          (store_data_RD_DV),
        .operate_i                (rregister_i ),
        .redundat_validation_i (redunancy_output_DV_PMU),
        .operation_type_i         (operation_type_i),
        .operation_result_o       (operation_result_DV_PMU),
        .store_data_o             (store_data_DV_DO)
    );

    decoder_output #(
        .WORD_SIZE (WORD_SIZE)
    )
    inst_DO(
        `ifdef USE_POWER_PINS
        .vdda1(vdda1),	// User area 1 3.3V power
        .vdda2(vdda2),	// User area 2 3.3V power
        .vssa1(vssa1),	// User area 1 analog ground
        .vssa2(vssa2),	// User area 2 analog ground
        .vccd1(vccd1),	// User area 1 1.8V power
        .vccd2(vccd2),	// User area 2 1.8V power
        .vssd1(vssd1),	// User area 1 digital ground
        .vssd2(vssd2),	// User area 2 digital ground
        `endif
        .operation_result_i       (operation_result_DV_PMU),
        .store_data_i             (store_data_DV_DO),
        .operation_result_o       (operation_result_o ),
        .store_data_o             (store_data_o )
    );

    state_counters #(
        .WORD_SIZE (WORD_SIZE),
        .VERIFICATION_PINS (VERIFICATION_PINS),
        .WHISBONE_ADR (WHISBONE_ADR),
        .REGDIRSIZE (REGDIRSIZE),
        .COUNTERSIZE (COUNTERSIZE),
        .REGISTERS (REGISTERS),
        .ADDRBASE (20'h3000_0)
    )
    inst_PMU(
        `ifdef USE_POWER_PINS
        .vdda1(vdda1),	// User area 1 3.3V power
        .vdda2(vdda2),	// User area 2 3.3V power
        .vssa1(vssa1),	// User area 1 analog ground
        .vssa2(vssa2),	// User area 2 analog ground
        .vccd1(vccd1),	// User area 1 1.8V power
        .vccd2(vccd2),	// User area 2 1.8V power
        .vssd1(vssd1),	// User area 1 digital ground
        .vssd2(vssd2),	// User area 2 digital ground
        `endif
        .clk_i                    (clk_i ),
        .rst_i                    (rst_i ),
        .register_i               (register_i ),
        .wregister_i              (wregister_i ),
        .rregister_i              (rregister_i ),
        .valid_i                  (valid_i),
        .wstrb_i                  (wstrb_i),
        .wdata_i                  (wdata_i),
        .wbs_we_i                 (wbs_we_i),
        .wbs_adr_i                (wbs_adr_i),
        .operation_result_i       (operation_result_DV_PMU),
        .ready_o                  (ready_pmu),
        .rdata_o                  (rdata_pmu)
    );

    state_counters #(
        .WORD_SIZE (WORD_SIZE),
        .VERIFICATION_PINS (VERIFICATION_PINS),
        .WHISBONE_ADR (WHISBONE_ADR),
        .COUNTERSIZE (COUNTERSIZE),
        .REGDIRSIZE (REGDIRSIZE),
        .REGISTERS (REGISTERS),
        .ADDRBASE (20'h3001_0)
    )
    inst_PMUBACKUP(
        `ifdef USE_POWER_PINS
        .vdda1(vdda1),	// User area 1 3.3V power
        .vdda2(vdda2),	// User area 2 3.3V power
        .vssa1(vssa1),	// User area 1 analog ground
        .vssa2(vssa2),	// User area 2 analog ground
        .vccd1(vccd1),	// User area 1 1.8V power
        .vccd2(vccd2),	// User area 2 1.8V power
        .vssd1(vssd1),	// User area 1 digital ground
        .vssd2(vssd2),	// User area 2 digital ground
        `endif
        .clk_i                    (clk_i ),
        .rst_i                    (rst_i ),
        .register_i               (register_i ),
        .wregister_i              (wregister_i ),
        .rregister_i              (rregister_i ),
        .valid_i                  (valid_i),
        .wstrb_i                  (wstrb_i),
        .wdata_i                  (wdata_i),
        .wbs_we_i                 (wbs_we_i),
        .wbs_adr_i                (wbs_adr_i),
        .operation_result_i       (operation_result_DV_PMU),
        .ready_o                  (ready_pmu_backup),
        .rdata_o                  (rdata_pmu_backup)
    );


//***Handcrafted Internal logic*** 
//TODO
endmodule
