module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
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
        

    // New: Datapath to store incoming bytes.
    reg[7:0] d1,d2,d3;
    always @(posedge clk) begin
        if(reset) begin
            d1 <= 0;
            d2 <= 0;
            d3 <= 0;
        end
        else
            case(next_state)
                B1: d1 <= in;
                B2: d2 <= in;
                B3: d3 <= in;
            endcase
    end
    assign out_bytes = {d1,d2,d3};
    
endmodule
