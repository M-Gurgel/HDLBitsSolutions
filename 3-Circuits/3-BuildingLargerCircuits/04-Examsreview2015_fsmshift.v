module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    wire [1:0] count;
    
    always @ (posedge clk) begin
        if(reset) begin
            shift_ena <= 1;
            count <= 0;
        end
        else if(shift_ena == 1)
            count <= count + 1;
        if(count == 3)
            shift_ena <= 0;
    end
    

endmodule
