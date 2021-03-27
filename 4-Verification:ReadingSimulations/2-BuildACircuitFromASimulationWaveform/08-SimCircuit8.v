module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    always @ (*)
        if (clock)
            p = a;
    	else
            p = p;
    
    always @ (negedge clock)
        if (a)
            q = 1;
    	else
            q = 0;

endmodule
