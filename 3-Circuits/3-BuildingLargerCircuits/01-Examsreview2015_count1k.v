module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    always @ (posedge clk) begin
        if (reset)
    		q = 0;
    	else
            q = q + 1;
        
        if (q == 1000)
            q = 0;
    end
    
endmodule
