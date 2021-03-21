module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [2:0] t;
    
    bcd_fadd a1 (a[3:0], b[3:0], cin, t[0], sum[3:0]);
    bcd_fadd a2 (a[7:4], b[7:4], t[0], t[1], sum[7:4]);
    bcd_fadd a3 (a[11:8], b[11:8], t[1], t[2], sum[11:8]);
    bcd_fadd a4 (a[15:12], b[15:12], t[2], cout, sum[15:12]);

endmodule
