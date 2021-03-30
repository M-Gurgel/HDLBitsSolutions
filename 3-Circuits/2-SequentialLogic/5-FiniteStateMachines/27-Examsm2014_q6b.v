module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101;
    
    // Y = C, D
    assign Y2 = (y == B) | (y == F) | (y == E & w) | (y == C & w);

endmodule
