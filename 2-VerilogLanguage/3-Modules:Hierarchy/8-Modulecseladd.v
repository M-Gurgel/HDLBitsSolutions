module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] a2out, a3out;
    wire cout;
    add16 a1 (a[15:0], b[15:0], 0, sum[15:0], cout);
    add16 a2 (a[31:16], b[31:16], 0, a2out);
    add16 a3 (a[31:16], b[31:16], 1, a3out);
    
    always @(*) begin
        case(cout)
            0 : sum[31:16] <= a2out;
            1 : sum[31:16] <= a3out;
        endcase
    end
	
endmodule
