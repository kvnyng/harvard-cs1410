# TCL script to remove all blk_mem_gen_0 IP instances from Vivado
# Run this in Vivado TCL console: source remove_blk_mem_gen_0_from_vivado.tcl

puts "Removing all blk_mem_gen_0 IP instances from Vivado..."

# Find all blk_mem_gen_0 IP instances
set all_ips [get_ips -quiet blk_mem_gen_0*]
if {[llength $all_ips] > 0} {
    puts "Found IP instances: $all_ips"
    foreach ip $all_ips {
        puts "Removing IP instance: $ip"
        set ip_files [get_files -quiet -of_objects [get_ips $ip]]
        if {[llength $ip_files] > 0} {
            remove_files $ip_files
        }
    }
} else {
    puts "No blk_mem_gen_0 IP instances found"
}

# Remove all blk_mem_gen_0 IP files
set all_ip_files [get_files -quiet {*/blk_mem_gen_0*.xci}]
if {[llength $all_ip_files] > 0} {
    puts "Found IP files: $all_ip_files"
    remove_files $all_ip_files
} else {
    puts "No blk_mem_gen_0 IP files found"
}

# Verify blk_mem_gen_1 is present
set blk_mem_gen_1_files [get_files -quiet {*/blk_mem_gen_1*}]
if {[llength $blk_mem_gen_1_files] > 0} {
    puts ""
    puts "blk_mem_gen_1 IP files found:"
    foreach file $blk_mem_gen_1_files {
        puts "  $file"
    }
} else {
    puts ""
    puts "WARNING: No blk_mem_gen_1 IP files found!"
}

puts ""
puts "Cleanup complete!"
puts "All blk_mem_gen_0 references should now be removed from Vivado"


