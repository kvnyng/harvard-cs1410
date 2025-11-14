#!/usr/bin/env python3
"""
Generate PNG visualization of VCD waveform
Focuses on key signals: PC, instruction_reg, RegWrite, register writes
"""

import re
import sys
from collections import defaultdict

def parse_vcd_simple(filename):
    """Simple VCD parser to extract key signal values"""
    signals = defaultdict(list)
    signal_codes = {}
    current_time = 0
    
    with open(filename, 'r') as f:
        content = f.read()
    
    # Find signal definitions
    var_pattern = r'\$var\s+\w+\s+(\d+)\s+(\S+)\s+(\S+)\s+\[.*?\]\s+\$end'
    for match in re.finditer(var_pattern, content):
        width = int(match.group(1))
        code = match.group(2)
        name = match.group(3)
        signal_codes[code] = (name, width)
    
    # Also find simple signal definitions without [bits]
    var_pattern2 = r'\$var\s+\w+\s+(\d+)\s+(\S+)\s+(\S+)\s+\$end'
    for match in re.finditer(var_pattern2, content):
        width = int(match.group(1))
        code = match.group(2)
        name = match.group(3)
        if code not in signal_codes:
            signal_codes[code] = (name, width)
    
    # Parse value changes
    lines = content.split('\n')
    for line in lines:
        line = line.strip()
        if line.startswith('#'):
            current_time = int(line[1:])
        elif line.startswith('b'):
            # Binary value: b<value> <code>
            match = re.match(r'b([01x]+)\s+(\S+)', line)
            if match:
                value = match.group(1)
                code = match.group(2)
                if code in signal_codes:
                    name, width = signal_codes[code]
                    signals[name].append((current_time, value))
        elif line and line[0] in '01x' and len(line.split()) == 2:
            # Single bit value
            parts = line.split()
            if len(parts) == 2:
                value = parts[0]
                code = parts[1]
                if code in signal_codes:
                    name, width = signal_codes[code]
                    signals[name].append((current_time, value))
    
    return signals, signal_codes

def binary_to_int(binary_str):
    """Convert binary string to integer"""
    if 'x' in binary_str:
        return None
    try:
        return int(binary_str, 2)
    except:
        return None

def find_signal(signals, pattern):
    """Find signal by pattern matching"""
    for name in signals.keys():
        if pattern.lower() in name.lower():
            return name
    return None

def generate_text_waveform(signals, max_time=3000):
    """Generate ASCII waveform representation"""
    output = []
    output.append("=" * 80)
    output.append("WAVEFORM ANALYSIS - Key Signals")
    output.append("=" * 80)
    output.append("")
    
    # Find key signals
    pc_sig = find_signal(signals, 'dbg_PC')
    inst_reg_sig = find_signal(signals, 'instruction_reg')
    regwrite_sig = find_signal(signals, 'RegWrite')
    w_addr_sig = find_signal(signals, 'w_addr')
    w_data_sig = find_signal(signals, 'w_data')
    
    if pc_sig:
        output.append(f"PC Signal: {pc_sig}")
        pc_values = signals[pc_sig]
        output.append(f"  Total updates: {len(pc_values)}")
        if pc_values:
            output.append(f"  First value at time {pc_values[0][0]}: {pc_values[0][1]}")
            output.append(f"  Last value at time {pc_values[-1][0]}: {pc_values[-1][1]}")
        output.append("")
    
    if inst_reg_sig:
        output.append(f"Instruction Register: {inst_reg_sig}")
        inst_values = signals[inst_reg_sig]
        output.append(f"  Total updates: {len(inst_values)}")
        output.append("")
    
    if regwrite_sig:
        output.append(f"RegWrite Signal: {regwrite_sig}")
        rw_values = signals[regwrite_sig]
        write_times = [t for t, v in rw_values if v == '1']
        output.append(f"  Total RegWrite assertions: {len(write_times)}")
        if write_times:
            output.append(f"  First write at time: {min(write_times)}")
            output.append(f"  Last write at time: {max(write_times)}")
        output.append("")
    
    # Sample PC progression
    if pc_sig:
        output.append("PC Progression (sample):")
        pc_values = signals[pc_sig]
        sample_times = [0, 100, 200, 276, 300, 400, 500]
        for sample_time in sample_times:
            # Find closest PC value
            closest = None
            min_diff = float('inf')
            for time, value in pc_values:
                if abs(time - sample_time) < min_diff:
                    min_diff = abs(time - sample_time)
                    closest = (time, value)
            if closest:
                pc_int = binary_to_int(closest[1])
                if pc_int:
                    output.append(f"  Time {closest[0]}: PC = 0x{pc_int:08X}")
        output.append("")
    
    return '\n'.join(output)

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 generate_waveform_png.py <vcd_file>")
        sys.exit(1)
    
    vcd_file = sys.argv[1]
    print(f"Parsing VCD file: {vcd_file}")
    
    try:
        signals, signal_codes = parse_vcd_simple(vcd_file)
        print(f"Found {len(signals)} signals")
        print(f"Found {len(signal_codes)} signal codes")
        
        # Generate text output
        text_output = generate_text_waveform(signals)
        print(text_output)
        
        # Try to create a simple visualization
        try:
            import matplotlib.pyplot as plt
            import matplotlib.patches as mpatches
            from matplotlib import rcParams
            
            print("\nGenerating PNG visualization...")
            
            # Find key signals
            pc_sig = find_signal(signals, 'dbg_PC')
            regwrite_sig = find_signal(signals, 'RegWrite')
            w_addr_sig = find_signal(signals, 'w_addr')
            
            fig, axes = plt.subplots(3, 1, figsize=(16, 10))
            fig.suptitle('CPU Waveform Analysis - Key Signals', fontsize=16, fontweight='bold')
            
            # Plot 1: PC progression
            if pc_sig:
                ax1 = axes[0]
                pc_values = signals[pc_sig]
                times = [t for t, _ in pc_values]
                values = [binary_to_int(v) for _, v in pc_values]
                valid_times = [t for t, v in zip(times, values) if v is not None]
                valid_values = [v for v in values if v is not None]
                
                ax1.plot(valid_times, valid_values, 'b-', linewidth=2, label='PC')
                ax1.axhline(y=0x0040003C, color='g', linestyle='--', alpha=0.5, label='Additional Tests Start')
                ax1.axhline(y=0x004000C4, color='r', linestyle='--', alpha=0.5, label='Additional Tests End')
                ax1.set_xlabel('Time (ps)', fontsize=12)
                ax1.set_ylabel('PC Value (hex)', fontsize=12)
                ax1.set_title('Program Counter (PC) Progression', fontsize=14, fontweight='bold')
                ax1.legend()
                ax1.grid(True, alpha=0.3)
                ax1.set_yscale('log')
                ax1.yaxis.set_major_formatter(plt.FuncFormatter(lambda x, p: f'0x{int(x):08X}'))
            
            # Plot 2: RegWrite signal
            if regwrite_sig:
                ax2 = axes[1]
                rw_values = signals[regwrite_sig]
                times = [t for t, _ in rw_values]
                values = [1 if v == '1' else 0 for _, v in rw_values]
                
                ax2.plot(times, values, 'r-', linewidth=2, drawstyle='steps-post', label='RegWrite')
                ax2.set_xlabel('Time (ps)', fontsize=12)
                ax2.set_ylabel('RegWrite', fontsize=12)
                ax2.set_title('Register Write Enable Signal', fontsize=14, fontweight='bold')
                ax2.set_ylim(-0.1, 1.1)
                ax2.set_yticks([0, 1])
                ax2.set_yticklabels(['0', '1'])
                ax2.legend()
                ax2.grid(True, alpha=0.3)
            
            # Plot 3: Write addresses
            if w_addr_sig:
                ax3 = axes[2]
                w_addr_values = signals[w_addr_sig]
                times = [t for t, _ in w_addr_values]
                values = [binary_to_int(v) for _, v in w_addr_values]
                valid_times = [t for t, v in zip(times, values) if v is not None]
                valid_values = [v for v in values if v is not None]
                
                ax3.scatter(valid_times, valid_values, c='green', s=50, alpha=0.6, label='Write Address')
                ax3.axhline(y=18, color='orange', linestyle='--', alpha=0.5, label='Additional Tests Start ($18)')
                ax3.axhline(y=29, color='purple', linestyle='--', alpha=0.5, label='Additional Tests End ($29)')
                ax3.set_xlabel('Time (ps)', fontsize=12)
                ax3.set_ylabel('Register Number', fontsize=12)
                ax3.set_title('Register Write Addresses', fontsize=14, fontweight='bold')
                ax3.legend()
                ax3.grid(True, alpha=0.3)
                ax3.set_ylim(-1, 32)
            
            plt.tight_layout()
            output_file = 'waveform_analysis.png'
            plt.savefig(output_file, dpi=150, bbox_inches='tight')
            print(f"✓ PNG saved to: {output_file}")
            
        except ImportError:
            print("matplotlib not available, skipping PNG generation")
            print("Install with: pip install matplotlib")
        except Exception as e:
            print(f"Error generating PNG: {e}")
            import traceback
            traceback.print_exc()
            
    except Exception as e:
        print(f"Error parsing VCD: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == '__main__':
    main()

