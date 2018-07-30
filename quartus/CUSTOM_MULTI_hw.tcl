# TCL File Generated by Component Editor 15.0
# Mon Jul 16 13:32:23 BRT 2018
# DO NOT MODIFY


# 
# CUSTOM_MULTI "CUSTOM_MULTI" v1.0
#  2018.07.16.13:32:23
# custom multiplication
# 

# 
# request TCL package from ACDS 15.0
# 
package require -exact qsys 15.0


# 
# module CUSTOM_MULTI
# 
set_module_property DESCRIPTION "custom multiplication"
set_module_property NAME CUSTOM_MULTI
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME CUSTOM_MULTI
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL custom_multiply
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file custom_multiply_constant.v VERILOG PATH ../custom_multiply_constant.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock ""
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave dataa writebyteenable_n Input 32
add_interface_port nios_custom_instruction_slave datab writebyteenable_n Input 32
add_interface_port nios_custom_instruction_slave result readdata Output 32


# 
# connection point custom_multiply
# 
add_interface custom_multiply nios_custom_instruction end
set_interface_property custom_multiply clockCycle 0
set_interface_property custom_multiply operands 2
set_interface_property custom_multiply ENABLED true
set_interface_property custom_multiply EXPORT_OF ""
set_interface_property custom_multiply PORT_NAME_MAP ""
set_interface_property custom_multiply CMSIS_SVD_VARIABLES ""
set_interface_property custom_multiply SVD_ADDRESS_GROUP ""

add_interface_port custom_multiply clock reset_n Input 1

