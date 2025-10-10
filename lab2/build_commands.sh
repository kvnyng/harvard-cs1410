# Primitives32 Build commands
xvlog -sv source/primitives32.sv tb/primitives32_tb.sv
xelab primitives32_tb -s primitives32_tb_sim -debug typical
xsim primitives32_tb_sim -R

# Mux Build commands
xvlog -sv source/mux.sv tb/mux_tb.sv
xelab mux_tb -s mux_tb_sim -debug typical
xsim mux_tb_sim -R

xvlog -sv source/adder.sv tb/full_adder_tb.sv tb/rca32_tb.sv
xelab full_adder_tb -s full_adder_tb_sim -debug typical
xsim full_adder_tb_sim -R

# ALU Build commands
xvlog -sv source/alu.sv tb/alu_tb.sv
xelab alu_tb -s alu_tb_sim -debug typical
xsim alu_tb_sim -R