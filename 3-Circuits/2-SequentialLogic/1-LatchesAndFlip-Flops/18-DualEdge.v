module top_module (
    input clk,
    input d,
    output q
);
    wire qu;
    wire qd;
    
    always @ (posedge clk) 
        qu = d;
    
    always @ (negedge clk) 
        qd = d;

    assign q = clk ? qu : qd;

endmodule
