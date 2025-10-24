read_verilog source/tlc.svh source/tlc.sv source/timer.sv source/clk_divider.sv source/tlc_top.sv
synth_design -top tlc_top -part xc7a75tcsg324-1
report_drc
