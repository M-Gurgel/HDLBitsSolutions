module top_module ( );
    
    reg clk = 0;

    always #5 clk = ~clk;
        
    dut inst_dut(
        .clk(clk)
    );

endmodule
