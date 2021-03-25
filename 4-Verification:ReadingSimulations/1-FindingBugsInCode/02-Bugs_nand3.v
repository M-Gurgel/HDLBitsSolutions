module top_module (input a, input b, input c, output out);//

    //assign out = ~(a&b&c);
    wire t;
    andgate inst1 (t, a, b, c, 1'b1, 1'b1);
    assign out = ~t;

endmodule
