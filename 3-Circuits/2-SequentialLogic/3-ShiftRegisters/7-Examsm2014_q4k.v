module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire [2:0]q;
    
    always @ (posedge clk) begin
        if(resetn == 1'b0) begin
            out <= 0;
            q <= 3'b0;
        end
        else begin
            out <= q[2];
            q[2] <= q[1];
            q[1] <= q[0];
            q[0] <= in;
        end
    end

endmodule
