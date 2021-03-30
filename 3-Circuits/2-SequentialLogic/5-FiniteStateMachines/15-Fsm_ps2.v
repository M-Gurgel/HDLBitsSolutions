module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    localparam IDLE=0, B1=1, B2=2, B3=3;
    reg[1:0] state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            IDLE: next_state = in[3] ? B1:IDLE;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = in[3] ? B1:IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end
 
    // Output logic
    assign done = (state == B3);
        
endmodule
