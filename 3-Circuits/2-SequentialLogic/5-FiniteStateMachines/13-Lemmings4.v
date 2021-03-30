module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );
    
	parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3, DIG_L=4, DIG_R=5, SPLAT=6;
    reg [2:0] state, next_state;
    integer count;

    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
        	state <= next_state;
    end
    
    always @(*) begin
        case(state)
            LEFT: begin
                if(~ground)
                    next_state = FALL_L;
                else if(dig)
                    next_state = DIG_L;
                else if(bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if(~ground)
                    next_state = FALL_R;
                else if(dig)
                    next_state = DIG_R;
                else if(bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_L: begin
            	if(~ground)
                    next_state = FALL_L;
                else if(count > 20)
                    next_state = SPLAT;
                else
                    next_state = LEFT;
            end
            FALL_R: begin
            	if(~ground)
                    next_state = FALL_R;
                else if(count > 20)
                    next_state = SPLAT;
                else
                    next_state = RIGHT;
            end
            DIG_L: next_state = ground ? DIG_L : FALL_L;
            DIG_R: next_state = ground ? DIG_R : FALL_R;
            SPLAT: next_state = SPLAT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset)
            count = 0;
        else if (~ground)
            count = count + 1;
        else
            count = 0;
    end
    
    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L) | (state == FALL_R);
    assign digging = (state == DIG_L) | (state == DIG_R);

endmodule
