module top_module ();
    
    reg clk,reset,t,out;
    
    initial begin
        clk = 0;
        reset = 0;
        t = 0;
        
        #10;
        #10 reset = 1;
        #10 reset = 0;
        #10 t = 1;
        #10 t = 0;
        #20;
        
        
    end
    
    always #5 clk = ~clk;
    
    tff tff_1(
        .clk(clk), .reset(reset), .t(t), .q(out)
    );

endmodule
