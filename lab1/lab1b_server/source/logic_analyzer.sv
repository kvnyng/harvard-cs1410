module logic_analyzer
    #(
        parameter ENTRY_LENGTH = 16,
        parameter NUM_ENTRY = 15,
        parameter NUM_BUF_STAGES = 16
    )
    (
        input wire                      clk,
        input wire                      nrst,
        input wire                      trig_begin,
        output wire                     trig_end,
        output wire [ENTRY_LENGTH-1:0]  shift_out [NUM_ENTRY-1:0]
    );

    //
    // Declarations
    //
    
    localparam              s_idle=0, s_active=1;
    reg                     state;
    reg [4:0]               cnt; 
    reg                     cnt_flag; // Triggers end of measurement
    reg                     trig_begin_d1;
    reg                     trig_begin_d2;
    wire [31:0]             buf_wire;
    reg [ENTRY_LENGTH-1:0]  buf_reg;
    reg [ENTRY_LENGTH-1:0]  shift_reg [NUM_ENTRY-1:0]; // first 32b are "packed" snapshots which get shifted along the second 32b dimension

    //
    // Combinational Logic
    //

    assign buf_wire[0] = trig_begin_d2; // launch the buffer chain
    assign shift_out = shift_reg; // output from shift register
    assign trig_end = cnt_flag; // output trigger

    // Buffer cascade using custom bufslow module
    genvar i;
    generate 
        for (i=0; i<NUM_ENTRY; i=i+1) begin 
            (* DONT_TOUCH = "TRUE" *) bufslow #(.NUM_BUF_STAGES(NUM_BUF_STAGES)) la_buf_inst (.b(buf_wire[i+1]), .a(buf_wire[i]));
        end
    endgenerate
  
    // 
    // Sequential Logic 
    //
    
    always@(posedge clk or negedge nrst) begin 
        // RESET branch
        if(nrst == 0) begin
            state <= s_idle;
            trig_begin_d1 <= 0;
            trig_begin_d2 <= 0;
            buf_reg <= 0;
            cnt_flag <= 0;
            cnt <= 0;
            for (int i=0; i<NUM_ENTRY; i=i+1) begin
                shift_reg[i] <= 0;
            end
        end else begin
            // State machine branch
            case(state)
                s_idle: begin
                    // Reset the count
                    cnt <= 0;
                    cnt_flag <= 0;

                    // Synchronize the input
                    trig_begin_d1 <= trig_begin;
                    trig_begin_d2 <= trig_begin_d1;

                    // Check for state transition
                    if (trig_begin_d1 == 1'b1) begin 
                        state <= s_active;
                    end
                end

                s_active: begin
                    // Keep assigning trig_begin_d2 so it doesn't hold at 1
                    trig_begin_d2 <= trig_begin_d1;

                    // Load flops with input val + every bufslow output
                    buf_reg <= buf_wire;
    
                    // Shift the banked bits into a shift register
                    for (int j=NUM_ENTRY; j>0; j=j-1) begin
                        shift_reg[j] <= shift_reg[j-1];
                    end
                    shift_reg[0] <= buf_reg;
                    
                    // Check for state change (when cnt = NUM_ENTRY)
                    if(cnt == 4'b1111) begin
                        cnt_flag <= 1;
                        state <= s_idle;
                    end else begin
                        cnt_flag <= 0;
                        cnt <= cnt + 1;
                    end
                end
            endcase
        end
    end
endmodule
