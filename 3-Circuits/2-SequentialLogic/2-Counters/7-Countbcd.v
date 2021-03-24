module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    always @(posedge clk) begin
        if(reset)
        	q = 0;
    	else
            q[3:0] = q + 1;
        
        if(q ==16'b1001_1001_1001_1001)
            ena = 15;
        else if(q[11:0] ==12'b1001_1001_1001)
            ena = 7;
        else if(q[7:0] ==8'b1001_1001)
            ena = 3;
        else if(q[3:0] == 4'b1001)
            ena = 1;
        else
            ena = 0;
        
        if(q[3:0] == 10) begin
            q[3:0] = 0;
            q[7:4] = q[7:4] + 1;
        end
        
        if(q[7:4] == 10) begin
            q[7:4] = 0;
            q[11:8] = q[11:8] + 1;
        end
        
        if(q[11:8] == 10) begin
            q[11:8] = 0;
            q[15:12] = q[15:12] + 1;
        end
        
        if(q[15:12] == 10)
            q = 0;
        
	end

endmodule
