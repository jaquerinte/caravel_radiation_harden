# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_proj_example


set ::env(VERILOG_FILES) "\
	$script_dir/../../caravel/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_proj_example.v \
	$script_dir/../../verilog/rtl/ecc_registers/register_file.v \
	$script_dir/../../verilog/rtl/ecc_registers/register_data.v \
	$script_dir/../../verilog/rtl/ecc_registers/data_verificator.v \
	$script_dir/../../verilog/rtl/ecc_registers/decoder_output.v \
	$script_dir/../../verilog/rtl/ecc_registers/parity_calculator.v \
	$script_dir/../../verilog/rtl/ecc_registers/state_counters.v"


set ::env(CLOCK_PORT) ""
set ::env(CLOCK_NET) "register_file.clk_i"
set ::env(CLOCK_PERIOD) "10"



set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 1490 1490"
set ::env(DESIGN_IS_CORE) 0

# You can draw more power domains if you need to 
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PL_BASIC_PLACEMENT) 0
# closser to 0 less compact closer to 1 more compact
set ::env(PL_TARGET_DENSITY) 0.45



# Maximum layer used for routing is metal 4.
# This is because this macro will be inserted in a top level (user_project_wrapper) 
# where the PDN is planned on metal 5. So, to avoid having shorts between routes
# in this macro and the top level metal 5 stripes, we have to restrict routes to metal4.  
# 
# set ::env(GLB_RT_MAXLAYER) 5

set ::env(RT_MAX_LAYER) {met4}



set ::env(DIODE_INSERTION_STRATEGY) 4 
# If you're going to use multiple power domains, then disable cvc run.
set ::env(RUN_CVC) 1


set ::env(ROUTING_CORES) 24