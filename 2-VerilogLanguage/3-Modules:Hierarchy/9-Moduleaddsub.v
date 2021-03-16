module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout;
    wire [31:0] bin;
    assign bin = {32{sub}} ^ b;
    add16 a1(a[15:0], bin[15:0] , sub, sum[15:0], cout);
    add16 a2(a[31:16], bin[31:16] , cout, sum[31:16]);
endmodule
