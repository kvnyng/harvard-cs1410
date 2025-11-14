#!/usr/bin/env python3
"""
Create a simple waveform visualization from testbench output data
Since we have the register write log, we can visualize that
"""

import sys
import re
import os

def extract_register_writes_from_output():
    """Extract register write information from testbench output"""
    # Based on the testbench output we saw earlier
    writes = [
        (11, 3, "0x00000003"),
        (15, 4, "0x0000000a"),
        (19, 5, "0xffffffff"),
        (23, 1, "0x0000000a"),
        (27, 6, "0x00000005"),
        (31, 7, "0x00000001"),
        (35, 8, "0x00000007"),
        (39, 9, "0x00000006"),
        (43, 10, "0xfffffff8"),
        (47, 11, "0x00000001"),
        (51, 12, "0x00000000"),
        (55, 13, "0x00000014"),
        (59, 14, "0x00000005"),
        (63, 15, "0xffffffff"),
        (67, 3, "0x00000000"),
        (71, 12, "0x00000000"),
        (75, 11, "0x00000001"),
        (79, 2, "0x00000014"),
        (83, 2, "0x00000005"),
    ]
    return writes

def create_ascii_waveform():
    """Create ASCII art waveform"""
    writes = extract_register_writes_from_output()
    
    print("=" * 80)
    print("REGISTER WRITE WAVEFORM")
    print("=" * 80)
    print()
    print("Cycle | Reg | Value      | Description")
    print("-" * 80)
    
    for cycle, reg, value in writes:
        desc = f"Write to ${reg}"
        if reg <= 15:
            desc += " (original test)"
        elif reg >= 18:
            desc += " (additional test)"
        print(f"{cycle:5d} | ${reg:2d} | {value:11s} | {desc}")
    
    print()
    print("=" * 80)
    print("OBSERVATIONS:")
    print("=" * 80)
    print("1. All writes are to registers $1-$15 (original tests)")
    print("2. No writes to registers $18-$29 (additional tests)")
    print("3. Last write at cycle 83")
    print("4. PC reached 0x004000C4 at cycle 276, but no additional register writes")
    print()

def create_simple_plot():
    """Create a simple text-based plot"""
    writes = extract_register_writes_from_output()
    
    # Group by register
    reg_writes = {}
    for cycle, reg, value in writes:
        if reg not in reg_writes:
            reg_writes[reg] = []
        reg_writes[reg].append((cycle, value))
    
    print("\n" + "=" * 80)
    print("REGISTER WRITE TIMELINE")
    print("=" * 80)
    print()
    
    # Create timeline
    max_cycle = max([c for c, _, _ in writes])
    timeline_length = min(100, max_cycle)
    
    for reg in sorted(reg_writes.keys()):
        writes_list = reg_writes[reg]
        timeline = [' '] * timeline_length
        for cycle, value in writes_list:
            if cycle < timeline_length:
                timeline[cycle] = '*'
        
        reg_label = f"${reg:2d}"
        if reg >= 18:
            reg_label += " (ADDITIONAL)"
        else:
            reg_label += " (ORIGINAL)"
        
        print(f"{reg_label}: " + ''.join(timeline))
    
    print()
    print("Legend: * = register write")
    print(f"Timeline: 0 to {timeline_length} cycles")
    print()

if __name__ == '__main__':
    create_ascii_waveform()
    create_simple_plot()
    
    # Try to create PNG if matplotlib is available
    try:
        import matplotlib.pyplot as plt
        import matplotlib.patches as mpatches
        
        writes = extract_register_writes_from_output()
        
        fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(14, 10))
        fig.suptitle('CPU Register Write Analysis', fontsize=16, fontweight='bold')
        
        # Plot 1: Register writes over time
        cycles = [c for c, _, _ in writes]
        regs = [r for _, r, _ in writes]
        values = [int(v, 16) if 'x' not in v else 0 for _, _, v in writes]
        
        # Color code by register range
        colors = ['blue' if r <= 15 else 'red' for r in regs]
        labels = ['Original ($1-$15)' if r <= 15 else 'Additional ($18-$29)' for r in regs]
        
        ax1.scatter(cycles, regs, c=colors, s=100, alpha=0.6)
        ax1.axhline(y=17.5, color='gray', linestyle='--', linewidth=2, label='Boundary')
        ax1.set_xlabel('Cycle', fontsize=12, fontweight='bold')
        ax1.set_ylabel('Register Number', fontsize=12, fontweight='bold')
        ax1.set_title('Register Writes Over Time', fontsize=14, fontweight='bold')
        ax1.set_ylim(0, 30)
        ax1.set_xlim(0, max(cycles) + 20)
        ax1.grid(True, alpha=0.3)
        ax1.legend(['Original Tests', 'Additional Tests', 'Boundary'], loc='upper right')
        
        # Add annotations for key points
        for cycle, reg, value in writes:
            if reg <= 15:
                ax1.annotate(f'${reg}', (cycle, reg), fontsize=8, alpha=0.7)
        
        # Plot 2: Write value distribution
        original_values = [v for c, r, v in writes if r <= 15]
        additional_values = [v for c, r, v in writes if r >= 18]
        
        ax2.barh(['Original Tests\n($1-$15)', 'Additional Tests\n($18-$29)'], 
                 [len(original_values), len(additional_values)],
                 color=['blue', 'red'], alpha=0.6)
        ax2.set_xlabel('Number of Writes', fontsize=12, fontweight='bold')
        ax2.set_title('Register Write Count by Test Category', fontsize=14, fontweight='bold')
        ax2.grid(True, alpha=0.3, axis='x')
        
        # Add value labels
        ax2.text(len(original_values), 0, f'{len(original_values)}', 
                va='center', ha='left', fontsize=12, fontweight='bold')
        ax2.text(len(additional_values), 1, f'{len(additional_values)}', 
                va='center', ha='left', fontsize=12, fontweight='bold')
        
        plt.tight_layout()
        output_file = 'waveform_analysis.png'
        plt.savefig(output_file, dpi=150, bbox_inches='tight')
        print(f"\n✓ PNG visualization saved to: {output_file}")
        print(f"  File size: {os.path.getsize(output_file) / 1024:.1f} KB")
        
    except ImportError:
        print("\nNote: matplotlib not available. Install with: pip install matplotlib")
        print("ASCII visualization created above.")
    except Exception as e:
        print(f"\nError creating PNG: {e}")
        import traceback
        traceback.print_exc()

