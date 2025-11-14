#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/software/xilinx-tools-2022/Vivado/2022.2/ids_lite/ISE/bin/lin64:/software/xilinx-tools-2022/Vivado/2022.2/bin
else
  PATH=/software/xilinx-tools-2022/Vivado/2022.2/ids_lite/ISE/bin/lin64:/software/xilinx-tools-2022/Vivado/2022.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/khyang/harvard/cs1410_lab/lab4_updated/lab4_server/project_1.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log cpu_top.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source cpu_top.tcl -notrace


