module top_module (
    input clk,
    input j,
    input k,
    output Q);
    
    always@(posedge clk)
        if (j&k)
            Q = ~Q;
   		else if (j)
        	Q = 1;
    	else if (k)
        	Q = 0;
    	else
        	Q = Q;

endmodule
