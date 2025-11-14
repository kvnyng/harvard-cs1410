# TCL script to fix blk_mem_gen_0 IP configuration
# Run this in Vivado TCL console: source fix_blk_mem_gen_0.tcl

# Check if IP is already loaded in the project
set ip_inst [get_ips -quiet blk_mem_gen_0]
if {[llength $ip_inst] == 0} {
    # IP not loaded, try to find and read the file
    set ip_files [get_files -quiet *blk_mem_gen_0.xci]
    if {[llength $ip_files] > 0} {
        set ip_file [lindex $ip_files 0]
        puts "Reading IP file: $ip_file"
        read_ip $ip_file
    } else {
        # Try constructing path from project directory
        set proj_dir [get_property DIRECTORY [current_project]]
        set ip_file "$proj_dir/project_1.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci"
        if {[file exists $ip_file]} {
            puts "Reading IP file: $ip_file"
            read_ip $ip_file
        } else {
            puts "ERROR: Could not find blk_mem_gen_0.xci"
            puts "Tried: $ip_file"
            return
        }
    }
} else {
    puts "IP blk_mem_gen_0 is already loaded"
}

# Update IP properties to match cpu_top.sv requirements:
# - Dual-port RAM (Port A and Port B)
# - 32-bit data width
# - 2048 words depth (11-bit address)
# Note: Write_Depth is shared between both ports in dual-port RAM
set_property -dict [list \
    CONFIG.Memory_Type {True_Dual_Port_RAM} \
    CONFIG.Write_Width_A {32} \
    CONFIG.Write_Depth_A {2048} \
    CONFIG.Read_Width_A {32} \
    CONFIG.Write_Width_B {32} \
    CONFIG.Read_Width_B {32} \
    CONFIG.Enable_A {Always_Enabled} \
    CONFIG.Enable_B {Always_Enabled} \
    CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
    CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
    CONFIG.Use_Byte_Write_Enable {false} \
] [get_ips blk_mem_gen_0]

# Generate the IP with updated configuration
generate_target {all} [get_ips blk_mem_gen_0]

puts "blk_mem_gen_0 IP configuration updated and regenerated successfully!"

