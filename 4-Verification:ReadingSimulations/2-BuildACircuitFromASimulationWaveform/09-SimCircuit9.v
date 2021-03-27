module top_module (
    input clk,
    input a,
    output [3:0] q );
    
    always @(posedge clk) begin
        if (~a)
        	q = q + 1;
    	else
            q = 4;
        if (q >= 7)
            q = 0;
     end

endmodule
