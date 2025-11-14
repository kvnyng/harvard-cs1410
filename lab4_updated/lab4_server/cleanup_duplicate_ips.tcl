# TCL script to remove duplicate blk_mem_gen_0 IP instances
# Keep only blk_mem_gen_0_5 (the one currently referenced in project)
# Run this in Vivado TCL console: source cleanup_duplicate_ips.tcl

puts "Cleaning up duplicate blk_mem_gen_0 IP instances..."
puts "Keeping only blk_mem_gen_0_5 (the one referenced in project)"

# Find all blk_mem_gen_0 IP instances
set all_ips [get_ips -quiet blk_mem_gen_0*]
puts "Found IP instances: $all_ips"

# Remove all except blk_mem_gen_0_5
foreach ip $all_ips {
    if {$ip != "blk_mem_gen_0_5"} {
        puts "Removing IP instance: $ip"
        set ip_files [get_files -quiet -of_objects [get_ips $ip]]
        if {[llength $ip_files] > 0} {
            remove_files $ip_files
        }
    }
}

# Also remove IP files directly (in case they're not associated with IP instances)
set all_ip_files [get_files -quiet {*/blk_mem_gen_0*.xci}]
foreach ip_file $all_ip_files {
    if {[string match "*blk_mem_gen_0_5*" $ip_file]} {
        puts "Keeping: $ip_file"
    } else {
        puts "Removing IP file: $ip_file"
        remove_files $ip_file
    }
}

puts ""
puts "Cleanup complete!"
puts "Only blk_mem_gen_0_5 remains in the project"
puts ""
puts "Next steps:"
puts "1. Run: reset_run synth_1"
puts "2. Run: reset_run impl_1"
puts "3. Run synthesis again"

