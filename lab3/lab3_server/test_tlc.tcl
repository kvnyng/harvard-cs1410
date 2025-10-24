read_verilog source/tlc.svh source/tlc.sv source/timer.sv source/clk_divider.sv
synth_design -top tlc -part xc7a75tcsg324-1
report_drc
