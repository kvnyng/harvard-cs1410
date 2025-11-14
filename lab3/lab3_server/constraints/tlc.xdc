# Traffic Light Controller Timing Constraints
# Created to address synthesis timing warnings

# Primary Clock Constraints
create_clock -period 10.000 -name clk [get_ports clk]
create_clock -period 1000.000 -name clk_slow [get_ports clk_slow]

# Input Delay Constraints
set_input_delay -clock clk -max 2.0 [get_ports rst]
set_input_delay -clock clk -max 2.0 [get_ports click_rst]
set_input_delay -clock clk -max 2.0 [get_ports car_ns]
set_input_delay -clock clk -max 2.0 [get_ports car_ew]
set_input_delay -clock clk -max 2.0 [get_ports timer_out]

# Output Delay Constraints
set_output_delay -clock clk -max 2.0 [get_ports light_ns]
set_output_delay -clock clk -max 2.0 [get_ports light_ew]
set_output_delay -clock clk -max 2.0 [get_ports ped_sigs]
set_output_delay -clock clk -max 2.0 [get_ports timer_init]
set_output_delay -clock clk -max 2.0 [get_ports timer_load]
set_output_delay -clock clk -max 2.0 [get_ports timer_en]

# Clock Domain Crossing Constraints
set_clock_groups -asynchronous -group [get_clocks clk] -group [get_clocks clk_slow]

# Multicycle Path Constraints
set_multicycle_path -setup 2 -from [get_clocks clk] -to [get_clocks clk_slow]
set_multicycle_path -hold 1 -from [get_clocks clk] -to [get_clocks clk_slow]

# False Path Constraints
set_false_path -from [get_ports rst]
set_false_path -from [get_ports click_rst]

# Max Delay Constraints for Critical Paths
set_max_delay -from [get_clocks clk] -to [get_ports light_ns] 8.0
set_max_delay -from [get_clocks clk] -to [get_ports light_ew] 8.0
set_max_delay -from [get_clocks clk] -to [get_ports ped_sigs] 8.0

