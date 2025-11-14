#!/usr/bin/env python3
"""
Analyze VCD waveform file to understand CPU execution
Focus on PC progression, instruction fetching, and register writes
"""

import re
import sys
from collections import defaultdict

def parse_vcd(filename):
    """Parse VCD file and extract signal values"""
    signals = {}
    signal_names = {}
    timescale = None
    
    with open(filename, 'r') as f:
        lines = f.readlines()
    
    # Find signal definitions
    current_scope = []
    for line in lines:
        line = line.strip()
        if line.startswith('$timescale'):
            match = re.search(r'\$timescale\s+(\d+)\s+(\w+)', line)
            if match:
                timescale = (int(match.group(1)), match.group(2))
        elif line.startswith('$scope'):
            match = re.search(r'\$scope\s+(\w+)\s+(\S+)', line)
            if match:
                current_scope.append(match.group(2))
        elif line.startswith('$upscope'):
            if current_scope:
                current_scope.pop()
        elif line.startswith('$var'):
            # $var wire 32 ! dbg_PC cpu_rtype_sequential_tb $end
            match = re.search(r'\$var\s+\w+\s+(\d+)\s+(\S+)\s+(\S+)', line)
            if match:
                width = int(match.group(1))
                code = match.group(2)
                name = match.group(3)
                full_name = '.'.join(current_scope + [name])
                signal_names[code] = full_name
                signals[full_name] = []
    
    # Parse value changes
    current_time = 0
    for line in lines:
        line = line.strip()
        if line.startswith('#'):
            current_time = int(line[1:])
        elif line and not line.startswith('$'):
            # Value change: b1 0 ! or r12345678 abc
            if line[0] == 'b':
                # Binary value
                match = re.match(r'b([01x]+)\s+(\S+)', line)
                if match:
                    value = match.group(1)
                    code = match.group(2)
                    if code in signal_names:
                        signals[signal_names[code]].append((current_time, value))
            elif line[0] in '01x':
                # Single bit
                match = re.match(r'([01x])\s+(\S+)', line)
                if match:
                    value = match.group(1)
                    code = match.group(2)
                    if code in signal_names:
                        signals[signal_names[code]].append((current_time, value))
            elif line[0] == 'r':
                # Real value (hex)
                match = re.match(r'r([0-9a-fA-F]+)\s+(\S+)', line)
                if match:
                    value = match.group(1)
                    code = match.group(2)
                    if code in signal_names:
                        signals[signal_names[code]].append((current_time, value))
    
    return signals, signal_names, timescale

def hex_to_int(hex_str):
    """Convert hex string to integer"""
    try:
        return int(hex_str, 16)
    except:
        return None

def analyze_cpu_execution(signals):
    """Analyze CPU execution from signals"""
    print("=== CPU Execution Analysis ===\n")
    
    # Find key signals
    pc_signal = None
    instruction_reg_signal = None
    regwrite_signal = None
    w_addr_signal = None
    w_data_signal = None
    
    for sig_name in signals.keys():
        if 'dbg_PC' in sig_name:
            pc_signal = sig_name
        elif 'instruction_reg' in sig_name.lower() or 'dbg_instruction_reg' in sig_name:
            instruction_reg_signal = sig_name
        elif 'dbg_RegWrite' in sig_name:
            regwrite_signal = sig_name
        elif 'dbg_reg_file_w_addr' in sig_name:
            w_addr_signal = sig_name
        elif 'dbg_reg_file_w_data' in sig_name:
            w_data_signal = sig_name
    
    print(f"Found signals:")
    print(f"  PC: {pc_signal}")
    print(f"  Instruction Reg: {instruction_reg_signal}")
    print(f"  RegWrite: {regwrite_signal}")
    print(f"  Write Addr: {w_addr_signal}")
    print(f"  Write Data: {w_data_signal}")
    print()
    
    # Analyze PC progression
    if pc_signal and pc_signal in signals:
        print("=== PC Progression ===")
        pc_values = signals[pc_signal]
        print(f"Total PC updates: {len(pc_values)}")
        
        # Group by instruction addresses
        instruction_addresses = defaultdict(list)
        for time, value in pc_values:
            if value and value != 'x':
                pc_int = hex_to_int(value)
                if pc_int:
                    # Round to instruction boundary (divisible by 4)
                    if pc_int >= 0x00400000:
                        inst_addr = (pc_int // 4) * 4
                        instruction_addresses[inst_addr].append((time, pc_int))
        
        print(f"\nUnique instruction addresses executed: {len(instruction_addresses)}")
        sorted_addrs = sorted(instruction_addresses.keys())
        print(f"Address range: 0x{sorted_addrs[0]:08X} to 0x{sorted_addrs[-1]:08X}")
        
        # Check if additional test addresses were reached
        additional_test_addrs = [0x0040003C, 0x00400040, 0x00400044, 0x00400048, 
                                 0x0040004C, 0x00400050, 0x00400054, 0x00400058,
                                 0x0040005C, 0x00400060, 0x00400064, 0x00400068,
                                 0x0040006C, 0x00400070, 0x00400074, 0x00400078,
                                 0x0040007C, 0x00400080, 0x00400084, 0x00400088,
                                 0x0040008C, 0x00400090, 0x00400094, 0x00400098,
                                 0x0040009C, 0x004000A0, 0x004000A4, 0x004000A8,
                                 0x004000AC, 0x004000B0, 0x004000B4, 0x004000B8,
                                 0x004000BC, 0x004000C0]
        
        print(f"\nAdditional test instruction addresses (0x0040003C - 0x004000C0):")
        found = 0
        for addr in additional_test_addrs:
            if addr in instruction_addresses:
                found += 1
                times = [t for t, _ in instruction_addresses[addr]]
                print(f"  ✓ 0x{addr:08X} executed at times: {min(times)}-{max(times)}")
        print(f"Found {found}/{len(additional_test_addrs)} additional test addresses")
        print()
    
    # Analyze register writes
    if regwrite_signal and regwrite_signal in signals:
        print("=== Register Writes Analysis ===")
        regwrite_values = signals[regwrite_signal]
        w_addr_values = signals[w_addr_signal] if w_addr_signal and w_addr_signal in signals else []
        w_data_values = signals[w_data_signal] if w_data_signal and w_data_signal in signals else []
        
        # Find times when RegWrite is asserted
        write_times = []
        for time, value in regwrite_values:
            if value == '1':
                write_times.append(time)
        
        print(f"Total RegWrite assertions: {len(write_times)}")
        
        # Match with write addresses and data
        writes_by_reg = defaultdict(list)
        for write_time in write_times:
            # Find closest w_addr and w_data
            closest_addr = None
            closest_data = None
            min_addr_diff = float('inf')
            min_data_diff = float('inf')
            
            for time, value in w_addr_values:
                if abs(time - write_time) < min_addr_diff:
                    min_addr_diff = abs(time - write_time)
                    closest_addr = value
            
            for time, value in w_data_values:
                if abs(time - write_time) < min_data_diff:
                    min_data_diff = abs(time - write_time)
                    closest_data = value
            
            if closest_addr and closest_addr != 'x':
                reg_num = hex_to_int(closest_addr)
                if reg_num is not None:
                    writes_by_reg[reg_num].append((write_time, closest_data))
        
        print(f"\nRegister writes by register number:")
        for reg_num in sorted(writes_by_reg.keys()):
            writes = writes_by_reg[reg_num]
            print(f"  Register ${reg_num}: {len(writes)} writes")
            for time, data in writes[:3]:  # Show first 3
                data_int = hex_to_int(data) if data and data != 'x' else None
                if data_int is not None:
                    print(f"    Time {time}: 0x{data_int:08X} ({data_int})")
                else:
                    print(f"    Time {time}: {data}")
            if len(writes) > 3:
                print(f"    ... and {len(writes) - 3} more")
        
        # Check for writes to additional test registers ($18-$29)
        print(f"\nWrites to additional test registers ($18-$29):")
        found_additional = False
        for reg_num in range(18, 30):
            if reg_num in writes_by_reg:
                found_additional = True
                writes = writes_by_reg[reg_num]
                print(f"  Register ${reg_num}: {len(writes)} writes")
                for time, data in writes:
                    data_int = hex_to_int(data) if data and data != 'x' else None
                    if data_int is not None:
                        print(f"    Time {time}: 0x{data_int:08X} ({data_int})")
        
        if not found_additional:
            print("  ⚠ No writes found to registers $18-$29!")
        print()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python3 analyze_waveform.py <vcd_file>")
        sys.exit(1)
    
    vcd_file = sys.argv[1]
    print(f"Analyzing waveform file: {vcd_file}\n")
    
    try:
        signals, signal_names, timescale = parse_vcd(vcd_file)
        print(f"Parsed {len(signals)} signals")
        if timescale:
            print(f"Timescale: {timescale[0]} {timescale[1]}")
        print()
        
        analyze_cpu_execution(signals)
        
    except Exception as e:
        print(f"Error analyzing waveform: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

