module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
	parameter S0=0, S1=1, S2=2, S3=3, S4=4;
    reg [2:0] state, next_state;
    
    always @(*) begin
        case(y )
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
            default: next_state = S0;
        endcase
    end
    
    assign z = y == S3 | y == S4;
    assign Y0 = next_state == S1 | next_state == S3;

    // Alternative
    // assign Y0 = x&y == 0 | ~x & y == 1 | x & y == 2 | ~x & y == 3 | ~x & y == 4;
	// assign z = y == S3 | y == S4;
    
endmodule
