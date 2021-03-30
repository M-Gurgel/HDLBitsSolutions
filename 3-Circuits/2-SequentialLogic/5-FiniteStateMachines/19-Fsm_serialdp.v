module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
        // Use FSM from Fsm_serial
    localparam  IDLE=0, START=1, B1=2, B2=3, B3=4, B4=5, B5=6, 
    			B6=7, B7=8, B8=9, B9=10, STOP=11, ERROR=12;
    
    reg [3:0] state, next_state;
    //added
    reg check, start;
    wire oddB;
    
    parity par(clk, reset | start, in, oddB);
   
    always @(posedge clk) begin
        if(reset)
            state <= IDLE;
        else begin
            state <= next_state;
            check <= oddB;
        end
    end

    always @(*) begin
        start = 0;
        case(state)
            IDLE: begin next_state = in ? IDLE: START; start=1;end
            START: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = B4;
            B4: next_state = B5;
            B5: next_state = B6;
            B6: next_state = B7;
            B7: next_state = B8;
            B8: next_state = B9;
            B9: next_state = in ? STOP : ERROR;
            STOP: begin next_state = in ? IDLE : START; start=1;end
            ERROR: next_state = in ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
        
    end

    // New: Datapath to latch input bits.
    reg [7:0] data;
    
    always @(posedge clk) begin
        if(next_state >= IDLE && next_state < B9)
            data <= {in, data[7:1]};
    end
    
    assign out_byte = data; 
    assign done = (state == STOP) & check;
    
endmodule
