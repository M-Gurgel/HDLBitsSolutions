module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    
	wire [7:0] q;
    
    always @ (posedge clk) // delay a cycle
        q = in;
        
    always @ (posedge clk)
        anyedge = ~(in ^ ~q);

endmodule
