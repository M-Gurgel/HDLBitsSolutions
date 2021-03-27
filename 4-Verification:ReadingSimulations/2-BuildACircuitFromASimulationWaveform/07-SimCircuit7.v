module top_module (
    input clk,
    input a,
    output q );

    always @(posedge clk)
        if(a)
            q = 0;
    	else
            q = 1;
    
endmodule
