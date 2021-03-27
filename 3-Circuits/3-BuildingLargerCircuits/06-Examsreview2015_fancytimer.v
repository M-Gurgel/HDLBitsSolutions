module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
	parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, COUNT=8, WAIT=9;

    reg [3:0] state, next_state, cB;
    
    reg [9:0] q;
    wire shift_ena, count_ena;

    always @(posedge clk) begin
        if(reset)
            state <= S;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            S: next_state = data ? S1 : S;
            S1: next_state = data ? S11 : S;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? B0 : S;
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = COUNT;
            COUNT: next_state = (count == 0 & q == 999) ? WAIT : COUNT;
            WAIT: next_state = ack ? S : WAIT;
            default: next_state = S;
        endcase
    end
    
    shiftcount sc1 (clk, shift_ena, count_ena, data, count);
    count1k c1 (clk, ~counting, q);
    
    always @(posedge clk) begin
        if(reset)
            cB <= 0;
        else
            case(state)
                B0: cB <= {cB[2:0], data};
                B1: cB <= {cB[2:0], data};
                B2: cB <= {cB[2:0], data};
                B3: cB <= {cB[2:0], data};
            endcase
    end
    
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
    assign count_ena = counting & (q == 999);
    
    assign counting = state == COUNT;
    assign done = state == WAIT;

endmodule

// 1K Counting Module
// review2015 count1k
module count1k (
    input clk,
    input reset,
    output [9:0] q);
    
    always @ (posedge clk) begin
        if (reset)
    		q = 0;
    	else
            q = q + 1;
        
        if (q == 1000)
            q = 0;
    end
endmodule

// shiftcount module
// review2015 shiftcount
module shiftcount (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

    always @ (posedge clk) begin
        if (shift_ena) begin
            q = q << 1;
            q[0] = data;
        end
        else if(count_ena)
            q = q - 1;
    end
    
endmodule
