module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0, B=1, C=2, D=3, E=4, F=5;
    parameter G1=6, G0=7, FO=8;
    
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(~resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: next_state = FO;
            B: next_state = x ? C : B;
            C: next_state = x ? C : D;
            D: next_state = x ? E : B;
            E: next_state = y ? G1 : F;
            F: next_state = y ? G1 : G0;
            G1: next_state = G1;
            G0: next_state = G0;
            FO: next_state = B;
            default: next_state = A;
        endcase
    end
    
    assign f = (state == FO);
    assign g = (state == G1) | (state == E) | (state == F);

endmodule
