module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg[1:0] state, next_state;
    parameter A=0, B=1, C=2;
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= A;
        else 
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? C : B;
            C: next_state = x ? C : B;
            default: next_state = A;
        endcase
    end
    
    assign z = (state == B);

endmodule
