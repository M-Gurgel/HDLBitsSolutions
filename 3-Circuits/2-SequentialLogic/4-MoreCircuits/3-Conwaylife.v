module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q );
    
    integer count;
    reg [255:0] next;
    
    always @ (posedge clk) begin
        if (load)
            q <= data;
        else begin
            for(int i = 0; i < 256; i++) begin
                if(i == 0) begin
                    count = q[15] + q[1];
                    count += q[255] + q[240] + q[241];
                    count += q[31] + q[16] + q[17];
                end
                else if(i == 15) begin
                    count = q[14] + q[0];
                    count += q[255] + q[254] + q[240];
                    count += q[16] + q[30] + q[31];
                end
                else if(i == 240) begin
                    count = q[255] + q[241];
                    count += q[224] + q[225] + q[239];
                    count += q[0] + q[1] + q[15];
                end
                else if(i == 255) begin
                    count = q[240] + q[254];
                    count += q[238] + q[239] + q[224];
                    count += q[0] + q[15] + q[14];
                end
                else if(i%16 == 0) begin
                    count = q[i+1] + q[i+15];
                    count += q[i-16] + q[i-15] + q[i-1];
                    count += q[i+16] + q[i+17] + q[i+31];
                end
                else if(i%16 == 15) begin
                    count = q[i-1] + q[i-15];
                    count += q[i-16] + q[i-17] + q[i-31];
                    count += q[i+1] + q[i+15] + q[i+16];
                end
                else if(i > 0 && i < 15) begin
                    count = q[i-1] + q[i+1];
                    count += q[i+15] + q[i+16] + q[i+17];
                    count += q[i+239] + q[i+240] + q[i+241];
                end
                else if(i > 240 && i < 255) begin
                    count = q[i-1] + q[i+1];
                    count += q[i-16] + q[i-17] + q[i-15];
                    count += q[i-239] + q[i-240] + q[i-241];
                end
                else begin
                    count = q[i-1] + q[i+1];
                    count += q[i-17] + q[i-16] + q[i-15];
                    count += q[i+17] + q[i+16] + q[i+15];
                end

                case(count)
                    2: next[i] = q[i];
                    3: next[i] = 1;
                    default: next[i] = 0;
                endcase
            end
            q = next;
        end
    end

endmodule
