module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    wire [7:0] q;
    
    always @ (posedge clk) // delay a cycle
        q = in;
        
    always @ (posedge clk)
		pedge = in & ~q;

endmodule
