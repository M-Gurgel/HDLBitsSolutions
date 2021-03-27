module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
	);

    wire [3:0] count;
    
    always @ (posedge clk) begin
        if(reset) begin
            start_shifting = 0;
            count = 0; // prevent wrong match on if below
        end
    	else
            count = {count[2:0], data};
        
        if (count == 4'b1101)
            start_shifting = 1;
    end
    
endmodule
