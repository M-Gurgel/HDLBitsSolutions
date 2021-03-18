module top_module( 
    input [99:0] in,
    output [99:0] out
);
    integer i;
    wire [99:0]t;
    always @(*)begin
        for (i=0; i < 100; i=i+1)
             t[i] = in[99-i];
    end
    
    assign out = t;
    

endmodule
