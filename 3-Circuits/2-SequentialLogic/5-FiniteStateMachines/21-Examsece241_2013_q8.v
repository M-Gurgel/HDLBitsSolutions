module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z );
    
    parameter S0=0, S1=1, S2=2;
    reg [1:0] state, next_state;
    
    always @(posedge clk, negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else
            state <= next_state;
    end
    
    always@(*) begin
        case(state)
            S0: next_state = x ?S1:S0;
            S1: next_state = x ?S1:S2;
            S2: next_state = x ?S1:S0;
        endcase
    end
    
    assign z = (state == S2) && x;    

endmodule
