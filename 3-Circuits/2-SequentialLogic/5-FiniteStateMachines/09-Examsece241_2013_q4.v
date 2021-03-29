module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [1:0] state, next_state;
    
    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11; 
    
    always@(*) begin
        next_state = A;
        case(s)
            3'b000: next_state = A;
            3'b001: next_state = B;
            3'b011: next_state = C;
            3'b111: next_state = D;
            default: next_state = A;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next_state;
    end
    
    always@(posedge clk) begin
        if(reset)
            dfr <= 1;
    	else
            if(next_state > state)
                dfr <= 0;
            else if(next_state < state)
                dfr <= 1;
    end
    
    
    assign fr3 = (state == A);
    assign fr2 = (state == B) | fr3;
    assign fr1 = (state != D);
    

endmodule
