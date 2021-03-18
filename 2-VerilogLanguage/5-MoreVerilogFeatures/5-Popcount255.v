module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    integer i,j;
    
    always @(*) begin
        j = 0;
        for (i = 0; i < 255; i = i + 1)
            j = j + (in[i] & 1);
    end

    assign out = j;
    
endmodule
