module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cm, cout;
    
    add16 a1( a[15:0] , b[15:0], 0, sum[15:0] , cm);
    add16 a2( a[31:16] , b[31:16] , cm, sum[31:16] , cout);
endmodule
