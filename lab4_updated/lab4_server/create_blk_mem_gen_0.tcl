# TCL script to create blk_mem_gen_0 IP with correct configuration
# Run this in Vivado TCL console: source create_blk_mem_gen_0.tcl

# Remove existing IP if it exists
set existing_ip_files [get_files -quiet {*/blk_mem_gen_0.xci}]
if {[llength $existing_ip_files] > 0} {
    puts "Removing existing blk_mem_gen_0 IP..."
    remove_files $existing_ip_files
}

# Create new Block Memory Generator IP
puts "Creating new blk_mem_gen_0 IP..."
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_0

# Configure IP for dual-port RAM matching cpu_top.sv EXACT requirements:
# - True Dual Port RAM (Port A and Port B)
# - 32-bit data width
# - 2048 words depth (11-bit address, so addra/addrb are [10:0])
# - Independent clocks (clka and clkb)
# - Enable pins (ena and enb) - MUST be Use_ENA_Pin/Use_ENB_Pin, NOT Always_Enabled
# - Write enable pins (wea and web)
set_property -dict [list \
    CONFIG.Memory_Type {True_Dual_Port_RAM} \
    CONFIG.Write_Width_A {32} \
    CONFIG.Write_Depth_A {2048} \
    CONFIG.Read_Width_A {32} \
    CONFIG.Write_Width_B {32} \
    CONFIG.Read_Width_B {32} \
    CONFIG.Enable_A {Use_ENA_Pin} \
    CONFIG.Enable_B {Use_ENB_Pin} \
    CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
    CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
    CONFIG.Use_Byte_Write_Enable {false} \
    CONFIG.Operating_Mode_A {WRITE_FIRST} \
    CONFIG.Operating_Mode_B {WRITE_FIRST} \
    CONFIG.Assume_Synchronous_Clk {false} \
    CONFIG.Use_RSTA_Pin {false} \
    CONFIG.Use_RSTB_Pin {false} \
    CONFIG.Load_Init_File {false} \
] [get_ips blk_mem_gen_0]

# Verify configuration was applied
set mem_type [get_property CONFIG.Memory_Type [get_ips blk_mem_gen_0]]
if {$mem_type != "True_Dual_Port_RAM"} {
    puts "ERROR: Memory_Type is still $mem_type, not True_Dual_Port_RAM!"
    puts "Attempting to set it directly..."
    set_property CONFIG.Memory_Type {True_Dual_Port_RAM} [get_ips blk_mem_gen_0]
    set mem_type [get_property CONFIG.Memory_Type [get_ips blk_mem_gen_0]]
    puts "Memory_Type is now: $mem_type"
}

# Generate all IP targets (synthesis, simulation, etc.)
puts "Generating IP outputs..."
generate_target {all} [get_ips blk_mem_gen_0]

# Final verification
set mem_type [get_property CONFIG.Memory_Type [get_ips blk_mem_gen_0]]
set width_a [get_property CONFIG.Write_Width_A [get_ips blk_mem_gen_0]]
set depth_a [get_property CONFIG.Write_Depth_A [get_ips blk_mem_gen_0]]
set enable_a [get_property CONFIG.Enable_A [get_ips blk_mem_gen_0]]
set enable_b [get_property CONFIG.Enable_B [get_ips blk_mem_gen_0]]

puts ""
puts "blk_mem_gen_0 IP created and configured successfully!"
puts "Final configuration:"
puts "  Memory Type: $mem_type"
puts "  Write Width A: $width_a"
puts "  Write Depth A: $depth_a"
puts "  Enable A: $enable_a (ena port will be created)"
puts "  Enable B: $enable_b (enb port will be created)"
puts "  Memory configuration: True Dual Port RAM, 32-bit x 2048 words"
puts "  Ports: clka, ena, wea, addra[10:0], dina[31:0], douta[31:0]"
puts "         clkb, enb, web, addrb[10:0], dinb[31:0], doutb[31:0]"
