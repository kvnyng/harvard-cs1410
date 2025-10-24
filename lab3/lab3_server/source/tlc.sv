`timescale 1ns / 1ps
`include "tlc.svh"

module tlc
    (
        input logic clk, clk_slow,
        input logic rst, car_ns, car_ew, click_rst,
        input logic [4:0] timer_out,
        output logic [4:0] timer_init,
        output logic [1:0] light_ns, light_ew,
		output logic [3:0] ped_sigs,
        output logic timer_load, timer_en
    );

    // State variables to track current state
    logic [1:0] car_state, car_state_next;
    logic [1:0] ped_state, ped_state_next;
    logic [1:0] direction, direction_next;
    logic timer_loaded, timer_loaded_next;

    logic reset_road, reset_road_next;
    logic click_rst_prev;
    logic force_timer_load;

    // synchronous logic (update the state on clock edge)
    always_ff @(posedge clk) begin
        if (rst) begin
            car_state <= `LIGHT_RED;
            ped_state <= `PED_RED;
            direction <= `DIR_START;
            timer_loaded <= 0;
            click_rst_prev <= 0;
            reset_road <= 0;
            force_timer_load <= 1;
        end
        else begin
            // Always update click_rst_prev to avoid timing issues
            click_rst_prev <= click_rst;
            
            // Single assignment to force_timer_load to prevent multiple drivers
            // Make reset edge-triggered to avoid hanging on button press
            if (click_rst && !click_rst_prev) begin
                // Reset button pressed (edge detected) - go to initial state immediately
                car_state <= `LIGHT_RED;
                ped_state <= `PED_RED;
                direction <= `DIR_START;
                timer_loaded <= 0;
                // Also reset the road signal to ensure clean state
                reset_road <= 0;
            end
            else if (clk_slow) begin
                // Normal state transition
                car_state <= car_state_next;
                ped_state <= ped_state_next;
                direction <= direction_next;
                timer_loaded <= timer_loaded_next;
                reset_road <= reset_road_next;
            end
            
            // Single assignment for force_timer_load to prevent multiple drivers
            // Set force_timer_load on reset, clear it on the next clock cycle
            if (rst || (click_rst && !click_rst_prev)) begin
                force_timer_load <= 1'b1;
            end
            else begin
                // Clear force_timer_load on any clock cycle after reset
                force_timer_load <= 1'b0;
            end
        end
    end

    // combinational logic (determine what the next state is)
	always_comb begin
		// Default values
		car_state_next = car_state;
		ped_state_next = ped_state;
		direction_next = direction;
		timer_loaded_next = timer_loaded;
		timer_load = 0;
		timer_en = 0;
		timer_init = 0;
		light_ns = `LIGHT_RED;
		light_ew = `LIGHT_RED;
		ped_sigs = `PED_NS_AMBER_EW_AMBER;
		
		// State machine based on transition table
		case ({car_state, ped_state, direction})
			// Initial state: LIGHT_RED, PED_RED, DIR_START
			{`LIGHT_RED, `PED_RED, `DIR_START}: begin
				// Always set timer_init to 5 for initial state
				timer_init = 5;
				
				if (!timer_loaded || force_timer_load) begin
					timer_load = 1;
					timer_loaded_next = 1;
					// Note: force_timer_load is cleared in synchronous block
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_GREEN;
					ped_state_next = `PED_WHITE;
					direction_next = `DIR_NS;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_RED;
				light_ew = `LIGHT_RED;
				ped_sigs = `PED_NS_AMBER_EW_AMBER;
			end
			
			// Green phase: LIGHT_GREEN, PED_WHITE, DIR_NS or DIR_EW
			{`LIGHT_GREEN, `PED_WHITE, `DIR_NS}, {`LIGHT_GREEN, `PED_WHITE, `DIR_EW}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					// Use direction to determine which sensor to check
					// Check for cross-traffic sensor (opposite direction)
					if ((direction == `DIR_NS && car_ew) || (direction == `DIR_EW && car_ns)) begin
						timer_init = 15; // Shortened phase if cross-traffic sensor active
					end else begin
						timer_init = 24; // Full phase if no cross-traffic sensor
					end
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					ped_state_next = `PED_ORANGE;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				// Set lights based on direction
				if (direction == `DIR_NS) begin
					light_ns = `LIGHT_GREEN;
					light_ew = `LIGHT_RED;
					ped_sigs = `PED_NS_WHITE_EW_AMBER;
				end else begin
					light_ns = `LIGHT_RED;
					light_ew = `LIGHT_GREEN;
					ped_sigs = `PED_NS_AMBER_EW_WHITE;
				end
			end
			
			// NS Pedestrian clearance: LIGHT_GREEN, PED_ORANGE, DIR_NS
			{`LIGHT_GREEN, `PED_ORANGE, `DIR_NS}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 6; // Load 6 seconds for pedestrian clearance
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_YELLOW;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_GREEN;
				light_ew = `LIGHT_RED;
				// Make NS orange flash at 1Hz - bit 2 flashes with clk_slow
				ped_sigs = {1'b0, clk_slow, 1'b0, 1'b0}; // NS orange (bit 2) flashes, EW amber (bit 0) off
			end
			
			// NS Car yellow: LIGHT_YELLOW, PED_ORANGE, DIR_NS
			{`LIGHT_YELLOW, `PED_ORANGE, `DIR_NS}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 4; // Load 4 seconds for car yellow
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					ped_state_next = `PED_AMBER;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_YELLOW;
				light_ew = `LIGHT_RED;
				// Make NS orange flash at 1Hz - bit 2 flashes with clk_slow
				ped_sigs = {1'b0, clk_slow, 1'b0, 1'b0}; // NS orange (bit 2) flashes, EW amber (bit 0) off
			end
			
			// NS Pedestrian red: LIGHT_YELLOW, PED_AMBER, DIR_NS
			{`LIGHT_YELLOW, `PED_AMBER, `DIR_NS}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 1; // Load 1 second for pedestrian red
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_RED;
					ped_state_next = `PED_RED;
					direction_next = `DIR_BOTH;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_YELLOW;
				light_ew = `LIGHT_RED;
				ped_sigs = `PED_NS_AMBER_EW_AMBER;
			end
			
			// All red clearance: LIGHT_RED, PED_RED, DIR_BOTH
			{`LIGHT_RED, `PED_RED, `DIR_BOTH}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 2; // Load 2 seconds for all red clearance
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_GREEN;
					ped_state_next = `PED_WHITE;
					direction_next = `DIR_EW;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_RED;
				light_ew = `LIGHT_RED;
				ped_sigs = `PED_NS_AMBER_EW_AMBER;
			end
			
			// EW Pedestrian clearance: LIGHT_GREEN, PED_ORANGE, DIR_EW
			{`LIGHT_GREEN, `PED_ORANGE, `DIR_EW}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 6; // Load 6 seconds for pedestrian clearance
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_YELLOW;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_RED;
				light_ew = `LIGHT_GREEN;
				// Make EW orange flash at 1Hz - bit 0 flashes with clk_slow
				ped_sigs = {1'b0, 1'b0, 1'b0, clk_slow}; // NS amber (bit 2) off, EW orange (bit 0) flashes
			end
			
			// EW Car yellow: LIGHT_YELLOW, PED_ORANGE, DIR_EW
			{`LIGHT_YELLOW, `PED_ORANGE, `DIR_EW}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 4; // Load 4 seconds for car yellow
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					ped_state_next = `PED_AMBER;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_RED;
				light_ew = `LIGHT_YELLOW;
				// Make EW orange flash at 1Hz - bit 0 flashes with clk_slow
				ped_sigs = {1'b0, 1'b0, 1'b0, clk_slow}; // NS amber (bit 2) off, EW orange (bit 0) flashes
			end
			
			// EW Pedestrian red: LIGHT_YELLOW, PED_AMBER, DIR_EW
			{`LIGHT_YELLOW, `PED_AMBER, `DIR_EW}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 1; // Load 1 second for pedestrian red
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_RED;
					ped_state_next = `PED_RED;
					direction_next = `DIR_EW;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_RED;
				light_ew = `LIGHT_YELLOW;
				ped_sigs = `PED_NS_AMBER_EW_AMBER;
			end
			
			// Final transition back to NS: LIGHT_RED, PED_RED, DIR_EW
			{`LIGHT_RED, `PED_RED, `DIR_EW}: begin
				if (!timer_loaded) begin
					timer_load = 1;
					timer_init = 2; // Load 2 seconds for transition back to NS
					timer_loaded_next = 1;
				end else if (timer_out == 0) begin
					car_state_next = `LIGHT_GREEN;
					ped_state_next = `PED_WHITE;
					direction_next = `DIR_NS;
					timer_loaded_next = 0;
				end else begin
					timer_en = 1;
				end
				light_ns = `LIGHT_RED;
				light_ew = `LIGHT_RED;
				ped_sigs = `PED_NS_AMBER_EW_AMBER;
			end
			
			default: begin
				// Default to initial state
				car_state_next = `LIGHT_RED;
				ped_state_next = `PED_RED;
				direction_next = `DIR_START;
				timer_loaded_next = 0;
			end
		endcase
	end
		
endmodule