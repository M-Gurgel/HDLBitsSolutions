module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
);
    localparam  IDLE=0, START=1, B1=2, B2=3, B3=4, B4=5, 
    			B5=6, B6=7, B7=8, B8=9, STOP=10, ERROR=11;
    
    reg [3:0] state, next_state;

    
    always @(posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            IDLE: next_state = in ? IDLE: START;
            START: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = B4;
            B4: next_state = B5;
            B5: next_state = B6;
            B6: next_state = B7;
            B7: next_state = B8;
            B8: next_state = in ? STOP : ERROR;
            STOP: next_state = in ? IDLE : START;
            ERROR: next_state = in ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end
    
    //output
    assign done = (state == STOP);
    
endmodule
