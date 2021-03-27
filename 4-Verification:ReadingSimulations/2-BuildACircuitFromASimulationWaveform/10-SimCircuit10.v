module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always @(*) begin
        if(state)
            q = a ~^ b;
        else
            q = a ^ b;
    end
    
    always @(posedge clk) begin
        if(a & b)
       		state <= 1;
        else if (~a & ~b)
            state <= 0;
	end

endmodule
