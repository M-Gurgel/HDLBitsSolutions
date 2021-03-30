module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg state, next_state;
    parameter A = 0;
    parameter B = 1;
    
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        state <= areset ? A : next_state;
    end
    
    assign z = (state == A) ? x : ~x;
        
endmodule
