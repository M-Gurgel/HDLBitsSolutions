module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @ (*)
        if(in) 
            case(state)
                A: next_state = B;
                B: next_state = B;
                C: next_state = D;
                D: next_state = B;
            endcase
        else 
            case(state)
                A: next_state = A;
                B: next_state = C;
                C: next_state = A;
                D: next_state = C;
            endcase
    
    // Output logic:  out = f(state) for a Moore state machine
    always @ (*)
        case(state)
            D: out = 1;
            default: out = 0;
        endcase

endmodule
