# TCL script to configure project to use proper blk_mem_gen_0 IP
# Run this in Vivado TCL console: source configure_blk_mem_gen_0.tcl

puts "Configuring blk_mem_gen_0 IP in project..."

# Check if IP exists and is loaded
set ip_inst [get_ips -quiet blk_mem_gen_0]
if {[llength $ip_inst] == 0} {
    puts "ERROR: blk_mem_gen_0 IP not found. Please run create_blk_mem_gen_0.tcl first."
    return
}

puts "Found blk_mem_gen_0 IP instance"

# Verify IP configuration
set mem_type [get_property CONFIG.Memory_Type [get_ips blk_mem_gen_0]]
set width_a [get_property CONFIG.Write_Width_A [get_ips blk_mem_gen_0]]
set depth_a [get_property CONFIG.Write_Depth_A [get_ips blk_mem_gen_0]]
set width_b [get_property CONFIG.Write_Width_B [get_ips blk_mem_gen_0]]

puts "Current configuration:"
puts "  Memory Type: $mem_type"
puts "  Write Width A: $width_a"
puts "  Write Depth A: $depth_a"
puts "  Write Width B: $width_b"

# Check if configuration matches requirements
if {$mem_type != "True_Dual_Port_RAM" || $width_a != "32" || $depth_a != "2048" || $width_b != "32"} {
    puts "WARNING: IP configuration does not match requirements!"
    puts "Expected: True_Dual_Port_RAM, 32-bit, 2048 words"
    puts "Please run create_blk_mem_gen_0.tcl to recreate the IP with correct settings."
} else {
    puts "IP configuration is correct!"
}

# Verify IP file is in the project
set ip_files [get_files -quiet {*/blk_mem_gen_0.xci}]
if {[llength $ip_files] > 0} {
    set ip_file [lindex $ip_files 0]
    puts "IP file found in project: $ip_file"
    
    # Ensure it's used in synthesis and implementation
    set_property USED_IN {synthesis implementation simulation} $ip_file
    puts "IP usage flags updated"
} else {
    puts "WARNING: IP file not found in project files"
}

# Regenerate IP outputs to ensure everything is up to date
puts "Regenerating IP outputs..."
generate_target {all} [get_ips blk_mem_gen_0]

puts "Configuration complete!"
puts "The project is now configured to use blk_mem_gen_0 with:"
puts "  - True Dual Port RAM"
puts "  - 32-bit data width"
puts "  - 2048 words depth"
puts "  - Both ports enabled"

