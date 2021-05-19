# **Space Shuttle**

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

## **Authors**
- Ivan Rodriguez Ferrandez (BSC-UPC)
- Alvaro Jover-Alvarez (BSC-UPC)
- Leonidas Kosmidis (BSC-UPC)
## **Description**
The idea of this project is to design open source radiation harden techniques. For now the space industry is a very close source and restricted IP industry.  But from ESA and his partners there is increasing interest in open source software and hardware for space use. So the main goal of the project is to implement some radiation harden features and test them under radiation to see how this techniques behave. Due to the nature of this project that is using a node that is close to the nodes use in this industry we will be easy to compare to current solutions.

One of the first things implemented is a 32 bit register file that has ECC implementation. In this case is implemented 1 bit correction and 2 bit detention.

## **ECC Implementation**
For the   of the code we use [Hamming code](https://en.wikipedia.org/wiki/Hamming_code#:~:text=In%20computer%20science%20and%20telecommunication,without%20detection%20of%20uncorrected%20errors.) for the implementation or the parity bits and correction.
In this particularly case is implemented with 6 bits inside of the register (positions 1,2,4,8,16,32) and a extra bit at the last position of the 2 bit error detection.
## **Block Description**
The main code part is in the ecc_registers folder inside of the rtl folder. The user_proj.v contains only the connections to connect the project wrapper with the register file. The module works in a black box manner, the values are inserted to the module and you can ask for a value inside of the memory and the output is the value requested with a status signal that tells if the value is correct without modifications, the value has been corrected or if the value data is invalid. Is important to notice that if more that two bits are flip in the register value the system can not reliable determine if the value is incorrect.

The module is implemented with 32 bit word size and 8 registers. The counters are 32 bit counters.


## Module Ports:
- **Input Ports**
  -  clk_i: Clock signal for the module.
  
  -  rst_i: Reset signal for the module, this signal clears all of the values for the internal register values and all of the counters.
  
  - data_to_register_i [31:0]: The 32 bit input value that will be store in the register file.

  - register_i [2:0]: Signal to select the register that the operation will be perform.

  - wregister_i: Signal to indicate that the operation that you want is to write the input data to a register.
  
  - rregister_i: Signal to indicate that the operation that you want is to read from the register file.
- **Output Ports**
  - store_data_o [31:0]: The 32 bit value that was store in the register file

  - operation:result_o [1:0]. This is a two bit output that indicates the sate of the data.  
    - **00**: Indicates that the data was in a correct state.
    - **01**: Indicates that the data output is correct but was a bit flip.
    - **10**: Indicates that the data is incorrect and was two bit flip.
    - **11**: Not defined state

Also some extra ports can be use in the case to add connection to a [wishbone bus](https://en.wikipedia.org/wiki/Wishbone_(computer_bus)). For the current version the whisbone is only connected to the 32 bit counter that counts the number of 1 bit flip that have happened.
## Module Extra Ports:
- **Input Ports**
  - valid_i: Union of the clk and the strobe values for the whisbone bus
  - wstrb_i [3:0]: Whisbone Strobe.
  - wdata_i [31:0]: Whisbone data input. 
- **Output Ports**
  - ready_o. Whisbone ack.
  - rdata_o [31:0]: Whisbone data output.

## Caravel Connections
The module is connected to the [caravel](https://github.com/efabless/caravel) project so in this section we will define how is connected to the processor in order to interact with it.

Caravel offers multiple way to interact with the user project inside of it. This ways are GPIO ports, logic analyzer probes, and the whisbone interconnection, user maskable interrupt signals. 

### **GPIO Connections**
- GPIO pins [19:0] are not been use.
- GPIO pins [35:20] are connected to store_data_o [15:0].
- GPIO pins [37:36] are connected to operation:result_o [1:0].
  
### **Logic Analyzer Probes**
- Input probes: 
  - la_data_in [0]       ⟶ rregister_i.
  - la_data_in [1]       ⟶ wregister_i.
  - la_data_in [4:2]     ⟶ register_i [2:0].
  - la_data_in [31:5]    ⟶ Not connected.
  - la_data_in [63:32]   ⟶ data_to_register_i [31:0].
  - la_data_in [64]      ⟶ clk_i.
  - la_data_in [65]      ⟶ rst_i.
  - la_data_in [127:66]  ⟶ Not connected.
  
- Output probes:
  - la_data_out [92:0]  ⟶ Not connected.
  - la_data_in [94:93]  ⟶ operation:result_o [1:0].
  - la_data_in [127:95] ⟶ store_data_o [31:0].

### **Whisbone Connection**

The whisbone connection is 1 to 1 with the user project wrapper. 

### **User Maskable Interrupt Signals**

This signals are not connected. 


## **Modules Description**
The ecc registers module is compose of a set of multiple sub-modules. The following image is a representation of the modules and how each one of them interconnect.

![](readme_data/output-crop.jpg)
<div align="center"> Block diagram of the implemented verilog. </div>

### **Module list**
- Parity calculator. This module takes the input data and calculate the parity bits that will be store in the registers.
- Register data. This module contains all of the registers and stores the data with the parity bits.
- Data verificator. This modules takes the input value form the Register data and the parity bits and verifies and corrects (if needed) the value.
- decoder_output. This module is a skeleton module that servers only to get the signals to the top module.
- state counters. This module contains all of the counters that keep track of the number of reads, number of 1 bit flip occurrences and number of 2 bit flip occurrences.
