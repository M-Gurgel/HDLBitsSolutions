module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
	reg state, next_state;
    parameter A=0, B=1;
    
    always @(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = B;
        endcase
    end
    
    reg[1:0] c, cw ;
    
    always @(posedge clk) begin
        if(reset) begin
            c <= 2;
        	cw <= 0;
        end
        else if (state == B) begin
            if(state == B & c == 2) begin
                c <= 0;
                cw <= w;
            end
            else begin
                c <= c + 1;
                cw <= cw + w;
            end
        end
    end

    assign z = (state == B & c == 2 & cw == 2);

endmodule
