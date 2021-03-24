module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    
        always @(posedge clk) begin
            if(ena)
            	ss = ss + 1;
            if (ss[3:0] == 10) begin
                ss[3:0] = 0;
                ss[7:4] = ss[7:4] + 1;
            end
            if (ss[7:4] == 6) begin
                ss[7:4] = 0;
                mm[3:0] = mm + 1;
            end
            if(mm[3:0] == 10) begin
                mm[3:0] = 0;
                mm[7:4] = mm[7:4] + 1;
            end
            if(mm[7:4] == 6) begin
                mm[7:4] = 0;
                hh[3:0] = hh + 1;
                if ((hh[7:4] == 1) & (hh[3:0] == 2))
                    pm = ~pm;
            end
            if(hh[3:0] == 10) begin
                hh[3:0] = 0;
                hh[7:4] = 1;
            end

            if ((hh[7:4] == 1) & (hh[3:0] == 3)) begin
                hh[3:0] = 1;
                hh[7:4] = 0;
            end

            if(reset) begin
                ss = 0;
                mm = 0;
                hh = 8'h12; // this needs fix, using the lower bytes
            end
   		end            
    
endmodule


