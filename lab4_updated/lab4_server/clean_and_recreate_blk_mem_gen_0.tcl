# TCL script to completely clean and recreate blk_mem_gen_0 IP
# Run this in Vivado TCL console: source clean_and_recreate_blk_mem_gen_0.tcl

puts "Cleaning up all blk_mem_gen_0 IP instances and files..."

# Remove all IP instances
set ip_instances [get_ips -quiet blk_mem_gen_0*]
if {[llength $ip_instances] > 0} {
    puts "Removing IP instances: $ip_instances"
    foreach ip $ip_instances {
        remove_files [get_files -quiet -of_objects [get_ips $ip]]
    }
}

# Remove all IP files
set ip_files [get_files -quiet {*/blk_mem_gen_0*.xci}]
if {[llength $ip_files] > 0} {
    puts "Removing IP files: $ip_files"
    remove_files $ip_files
}

# Remove generated IP directories
set ip_dirs [glob -nocomplain -type d "project_1.gen/sources_1/ip/blk_mem_gen_0*"]
if {[llength $ip_dirs] > 0} {
    puts "Found generated IP directories (will be cleaned on next generation)"
}

puts "Cleanup complete. Creating new blk_mem_gen_0 IP..."

# Create new Block Memory Generator IP
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_0

# Configure IP for dual-port RAM matching cpu_top.sv EXACT requirements:
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

# Generate all IP targets
puts "Generating IP outputs..."
generate_target {all} [get_ips blk_mem_gen_0]

# Verify configuration
set mem_type [get_property CONFIG.Memory_Type [get_ips blk_mem_gen_0]]
set width_a [get_property CONFIG.Write_Width_A [get_ips blk_mem_gen_0]]
set depth_a [get_property CONFIG.Write_Depth_A [get_ips blk_mem_gen_0]]

puts ""
puts "blk_mem_gen_0 IP created successfully!"
puts "Configuration: $mem_type, ${width_a}-bit x ${depth_a} words"

