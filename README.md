# **Space Shuttle**

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

## **Authors**
- Ivan Rodriguez-Ferrandez (UPC-BSC)
- Alvaro Jover-Alvarez (UPC-BSC)
- Leonidas Kosmidis (BSC-UPC)


![](readme_data/space_shuttle_patch_crop.png)

### **Main Version of the chip: 2.0V EXTENDED**  

<br/>

## **Change Log**

- Version 2.0V Extended:
  - Added support for the wishbone interface to access all of the internal register data.
  - Added the PMU to have counters for write operations.
  - Added the PMU counters for writes, reads, uncorrected errors and corrected errors for each of the 32 registers.
  - Added duplicate PMU for have a copy of the values.
  
- Version 2.0V:
  - Added support for shadow registers (duplication).
  - Added support for ECC shadow registers (duplication with ECC).
  - Added the possibility to store a value without any protection.
  
- Version 1.5V:
  - Bug fix wishbone interface counters.
  
- Version 1.4V:
  - Added storage in triplets (data triplication).
  
- Version 1.3V:
  - Increase from 8 registers to 32 registers.
  - Bug fix  in the wishbone interface to correct access the internal register 31.

- Version 1.2V: 
  - Bug fix for the ECC generator.

- Version 1.1V:
  - Bug fix for the ECC parity detector.

- Version 1.0V:
  - Implemented ECC registers for 8 registers.

## **Description**

The main goal of this project is to design open source radiation harden techniques. For now the space industry is a very close source and restricted IP industry.  But from ESA and his partners there is increasing interest in open source software and hardware for space use. So the main goal of the project is to implement some radiation harden features and test them under radiation to see how this techniques behave. Due to the nature of this project that is using a node that is close to the nodes use in this industry we will be easy to compare to current solutions.

In detail this project aims to test different techniques for error detection and correction in registers. In this case is implemented a 32 bit register file that we be use at the same time (with some limitations) with the different techniques selected.
This techniques are:
- ECC: ECC with 1 bit correction and 2 bit correction
  
- Triple Redundancy: The input value is triplicated in the register file
  
- Shadow Register: The input value has a copy in the register file
  
- ECC Shadow Register: The input value has a copy in the register file with ECC protection of 1 bit correction and 2 bit correction.

## **How To Use The Chip**
This is a full example of how to use the chip in the context of caravel. For this example we will write a value to the register 1 and then we will read that value from the register file. This is also the first test of the chip. 

```C++

void main()
{
  /* Set up the housekeeping SPI to be connected internally so	*/
  /* that external pin changes don't affect it.			*/

  reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
                                // connect to housekeeping SPI
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
  // test code
  // clk and reset
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // add data to register 1
  reg_la0_data = (1 << 2| 2 & 0x3); 
  reg_la1_data = 200;
  // clk
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // read value to register 1
  reg_la0_data = (1 << 2| 1 & 0x3);
  // clk
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // value is the GPIO [35:20]
  reg_mprj_datal = 0xAB410000;
	print("\n");
	print("Monitor: Test 1 Passed\n\n");
	reg_mprj_datal = 0xAB510000;
}
``` 




## **ECC Implementation**
For the   of the code we use [Hamming code](https://en.wikipedia.org/wiki/Hamming_code#:~:text=In%20computer%20science%20and%20telecommunication,without%20detection%20of%20uncorrected%20errors.) for the implementation or the parity bits and correction.
In this particularly case is implemented with 6 bits inside of the register (positions 1,2,4,8,16,32) and a extra bit at the last position of the 2 bit error detection.

## **Triple Redundancy Implementation**
The triple redundancy is implemented using the same registers that are been use for the ECC memory. The main issue of using this is the reduction in the space available for registers. But triple redundancy and standard ECC register can be use at the same time. Maintaining the consistency and witch registers are use and is witch mode each register is bee use is a job of the user. 

In the chip can be at maximum of 8 triple redundancy registers and 8 ECC registers can be use at the same time. 

The registers that can be use for triple redundancy are:
- 00
- 04
- 08
- 12
- 16
- 20
- 24
- 28
  
When one of this triple redundancy only a set of registers for ECC can be use. The registers that can be use when one of triple redundancy is use is:
- 00 ⟶ ECC register available 3
- 04 ⟶ ECC register available 7
- 08 ⟶ ECC register available 11
- 12 ⟶ ECC register available 15
- 16 ⟶ ECC register available 19
- 20 ⟶ ECC register available 23
- 24 ⟶ ECC register available 27
- 28 ⟶ ECC register available 31

## **Shadow Register Implementation**
The shadow register is implemented by only using the first 4 bits of register address for accessing the first 16 registers for store operations. The last bit of the address is use internally to store the value in a second register. So for example you store a value in the register 0 the shadow copy will be stored in the register 16. For this method only error detection is possible.

## **ECC Shadow Register Implementation**
The ECC shadow register is implemented in a similar way of the shadow register but the values are store with the parity bits. In this case first the value is compare with the shadow register and second the not shadowed register is send to the parity verification to check the ECC value is correct, the output will be if the values has been corrected and/or was a mismatch between the values.


## **No Protection Implementation**
For this mode the data value is store with out any protection in the register file. 


## **Block Description**
The main code part is in the ecc_registers folder inside of the rtl folder. The user_proj.v contains only the connections to connect the project wrapper with the register file. The module works in a black box manner, the values are inserted to the module and you can ask for a value inside of the memory and the output is the value requested with a status signal that tells if the value is correct without modifications, the value has been corrected or if the value data is invalid. Is important to notice that if more that two bits are flip in the register value the system can not reliable determine if the value is incorrect.

The module is implemented with 32 bit word size and 32 registers. The counters are 32 bit counters.


## Module Ports:
- **Input Ports**
  -  clk_i: Clock signal for the module.
  
  -  rst_i: Reset signal for the module, this signal clears all of the values for the internal register values and all of the counters.
  
  - data_to_register_i [31:0]: The 32 bit input value that will be store in the register file.

  - register_i [2:0]: Signal to select the register that the operation will be perform.

  - wregister_i: Signal to indicate that the operation that you want is to write the input data to a register.
  
  - rregister_i: Signal to indicate that the operation that you want is to read from the register file.
  
  - operation_type_i [3:0]:This is a three bit signal that indicates what type of operation will apply to the data. This is use in conjunction with the  wregister_i and rregister_i for writing and reading. The possible values are:
    - **000**: Indicates that the data will be stored using ECC.
    - **001**: Indicates that the data will be stored using triple redundancy.
    - **010**: Indicates that the data will be stored using ECC shadow registers.
    - **011**: Indicates that the data will be stored using shadow registers.
    - **100**: Indicates that the data will be stored without using any protection method.
- **Output Ports**
  - store_data_o [31:0]: The 32 bit value that was store in the register file

  - operation_result_o [1:0]. This is a two bit output that indicates the sate of the data.  
    - **00**: Indicates that the data was in a correct state.
    - **01**: Indicates that the data output is correct but was a bit flip.
    - **10**: Indicates that the data is incorrect and was two bit flip.
    - **11**: Not defined state
  - operational_o. Signal that indicates if the system is ready to accept petitions  for reading or writing. 

Also some extra ports can be use in the case to add connection to a [wishbone bus](https://en.wikipedia.org/wiki/Wishbone_(computer_bus)). For the current version the wishbone is only connected to the 32 bit counter that counts the number of 1 bit flip that have happened.
## Module Extra Ports:
- **Input Ports**
  - valid_i: Union of the clk and the strobe values for the wishbone bus
  - wstrb_i [3:0]: Wishbone strobe.
  - wdata_i [31:0]: Wishbone data input.
  - wbs_adr_i [31:0]: Wishbone address.   
- **Output Ports**
  - ready_o. Wishbone ack.
  - rdata_o [31:0]: Wishbone data output.

## Caravel Connections
The module is connected to the [caravel](https://github.com/efabless/caravel) project so in this section we will define how is connected to the processor in order to interact with it.

Caravel offers multiple way to interact with the user project inside of it. This ways are GPIO ports, logic analyzer probes, and the Wishbone interconnection, user maskable interrupt signals. 

### **GPIO Connections**
- GPIO pins [19:0] are not been use.
- GPIO pins [35:20] are connected to store_data_o [15:0].
- GPIO pins [37:36] are connected to operation:result_o [1:0].
  
### **Logic Analyzer Probes**
- Input probes: 
  - la_data_in [0]       ⟶ rregister_i.
  - la_data_in [1]       ⟶ wregister_i.
  - la_data_in [2]       ⟶ operation_type_i .
  - la_data_in [7:3]     ⟶ register_i [4:0].
  - la_data_in [31:8]    ⟶ Not connected.
  - la_data_in [63:32]   ⟶ data_to_register_i [31:0].
  - la_data_in [64]      ⟶ clk_i.
  - la_data_in [65]      ⟶ rst_i.
  - la_data_in [127:66]  ⟶ Not connected.
  
- Output probes:
  - la_data_out [92:0]  ⟶ Not connected.
  - la_data_in [94:93]  ⟶ operation:result_o [1:0].
  - la_data_in [127:95] ⟶ store_data_o [31:0].

### **Wishbone Connection**

The wishbone connection is 1 to 1 with the user project wrapper. 

### **User Maskable Interrupt Signals**

This signals are not connected. 


## **Modules Description**
The ecc registers module is compose of a set of multiple sub-modules. The following image is a representation of the modules and how each one of them interconnect.

![](readme_data/output-crop.jpg)
<div align="center"> Block diagram of the implemented verilog. </div>

### **Module List**
- Parity calculator. This module takes the input data and calculate the parity bits that will be store in the registers.
- Register data. This module contains all of the registers and stores the data with the parity bits.
- Data verificator. This modules takes the input value form the Register data and the parity bits and verifies and corrects (if needed) the value.
- decoder_output. This module is a skeleton module that servers only to get the signals to the top module.
- state counters (PMU). This module contains all of the counters that keep track of the number of reads, number of 1 bit flip occurrences and number of 2 bit flip occurrences.

## **Wishbone Description**
In this chip is implemented the wishbone to access the 32 bit counters and also to access the internal registers  in order to modify the first 32 bits for testing of the ECC capabilities.

The chip have to modes, operation mode where it performs the register file operations or in wishbone operation. The both modes are independent and can not be operated at the same time.

 ### **Address Space**

Each of the possible accesses of the wishbone has a predefined address to access. Following the design of caravel the first address is the 0x3000_0000. All of the possible address that are defined are configure to be read from or write to the wishbone interface.
Regarding the PMU, now that you can access a counter per each of the registers. So the base address of the PMU points to the reads form the register 0, the following address point to writes, corrected errors, uncorrected errors. So each set of counters are separate by 4 address. so  hereinafter this is  the list of implemented addresses for the chip.

- 0x3000_0000: Base address of the PMU-1.
  - 0x3000_0200: Max address of the PMU-1.
- 0x3000_1000: PMU-1 Total values counters.
  - 0x3000_1000: total reads.
  - 0x3000_1004: total writes.
  - 0x3000_1008: total corrected errors.
  - 0x3000_100C: total uncorrected errors.
- 0x3001_0000: Base address of the PMU2
  - 0x3001_0200: Max address of the PMU2.
- 0x3001_1000: PMU2 total
  - 0x3001_1000: total reads.
  - 0x3001_1004: total writes.
  - 0x3001_1008: total corrected errors.
  - 0x3001_100C: total uncorrected errors.
- 0x3010_0000: Internal register file register 0.
  - 0x3010_007F: Internal register file register register 31,

 ### **Software Example**

 This example is base in that this chip is connected to the caravel project. The main idea of the use of the wishbone interface is that you are performing operations and then you stop doing operations and you change the chip to wishbone access. In the following example I will show how to access the performance counter that counts the number of reads.

First we define the address that will be use for the access of counter in this case is the reads so we use the address 0x30000004.
```C++
#define reg_wb_counter (*(volatile unint32_t*)0x30000004)
``` 

Second we operate the chip in a normal condition adding a value toa register and reading for it. 
```C++
//##############################################
//# Caravel GPIO configurations
//##############################################

//##############################################
// la probes configurations
//##############################################
// clk and reset
reg_la2_data = 0x00000001;
reg_la2_data = 0x00000000;
// add data to register 1
reg_la0_data = (1 << 2| 2 & 0x3); 
reg_la1_data = 200;
// clk
reg_la2_data = 0x00000001;
reg_la2_data = 0x00000000;
// read value to register 1
reg_la0_data = (1 << 2| 1 & 0x3);
// clk
reg_la2_data = 0x00000001;
reg_la2_data = 0x00000000;
// value is the GPIO [35:20]
``` 
When we want to access the performance counter we start the switching to wishbone mode. First to tell the chip to stop operating this is achieve putting the rregister_i and wregister_i to 0.

```C++
// clk
reg_la2_data = 0x00000001;
reg_la2_data = 0x00000000;
// clear lines
reg_la0_data = 0x00000000;
reg_la1_data = 0x00000000;
// clk
reg_la2_data = 0x00000001;
reg_la2_data = 0x00000000;
``` 

Then we need to deactivate the manual clock to switch the the wishbone clock. We doing that by deactivating the LA probes that access the clk and reset. 
```C++
// deactivate internal clk
reg_la2_oenb = 0xFFFFFFF;
``` 
Now we can check the value accessing to the defined variable.

```C++
// deactivate internal clk
 print (reg_wb_counter);
``` 
Now is the full example code

```C++
#define reg_wb_counter (*(volatile unint32_t*)0x30000000)

void main()
{
  //##############################################
  //# Caravel GPIO configurations
  //##############################################

  //##############################################
  // la probes configurations
  //##############################################

  // clk and reset
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // add data to register 1
  reg_la0_data = (1 << 2| 2 & 0x3); 
  reg_la1_data = 200;
  // clk
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // read value to register 1
  reg_la0_data = (1 << 2| 1 & 0x3);
  // clk
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // value is the GPIO [35:20]

  // clk
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;
  // clear lines
  reg_la0_data = 0x00000000;
  reg_la1_data = 0x00000000;
  // clk
  reg_la2_data = 0x00000001;
  reg_la2_data = 0x00000000;

  // deactivate internal clk
  reg_la2_oenb = 0xFFFFFFF;

  print (reg_wb_counter);

}
``` 

## **Available Tests**

For this project there is a set of test in order to verify the functionality described. The test are the following.

- la_test1: This test is the basic test, write a value with ECC to a register and then reads that value from the memory.

- la_test2: This test, writes and reads all of the 32 registers of chip using ECC.

- la_test3: This test, writes and reads from one of the triple redundancy registers.

- la_test4: This test, writes in a triple redundant register and modify two of the copies of the data stored to test that the error state is detected.

- la_test5: This test writes and reads from one of the shadow registers.

- la_test6: This test, writes and reads all of the 16 registers using shadow registers.

- la_test7: This test, writes in a register using a shadow register and modify the shadow register to verify that the error is detected.

- la_test8: This test writes and reads from one of the ECC shadow registers.

- la_test9: This test, writes and reads all of the 16 registers using ECC shadow registers.

- la_test10: This test, writes in a register using a ECC shadow register and modify the shadow register to verify that the error is detected.

- la_test11: This test writes and reads from one register without using  any protection.

- wb_test1: This test uses the wishbone interface to modify one bit of an internal register in order to test the ECC functionality.

- wb_test2: This test uses the wishbone interface to modify one bit of an internal register and also makes some reads in oder to check the performance counters.

- wb_test3: This test uses the wishbone interface to modify one value  of an internal triple redundant register and also makes a red to check that the output value is correct and the corrected stage is detected.

- wb_test4: This test uses the wishbone interface to add a value per each of the 32 registers and then using the chip we read the 32 values. This is for testing the proper access of all of the registers.

- wb_test5: This test is similar to the wb_test2 but verifies that the PMU-1 and PMU-2 have the same values for the total reads and corrected errors.

- wb_test6. Using the base of the wb_test2 this test try's to access a non valid address the expected result is that the program finish without problems and without halting the processors. 

- wb_test7. Using as a base the la_test2, we write to all of the registers and we read all of them and we check some of the  individual counters to check that  the number of reads correctly as well the total reads and writes form the PMU-1 and PMU-2.
