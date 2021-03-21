module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    wire q[2:0];
    always @ (posedge clk)
        if (L) begin
            q[0] = r_in;
            q[1] = r_in;
            q[2] = r_in;
        end
        else begin
            q[0] = q_in;
            q[1] = q_in;
            q[2] = q_in;
        end
    assign Q = q[2];

endmodule
