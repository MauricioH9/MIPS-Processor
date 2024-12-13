`timescale 1ns / 1ps

module mux_32bit_tb();

    wire [31:0] test_y;
    
    reg [31:0] test_a, test_b;
    reg test_sel;
    
    mux mux_uut(
        .a(test_a),
        .b(test_b),
        .y(test_y),
        .sel(test_sel)
    );
    
    initial begin
        test_a = 32'hAAAAAAAA;
        test_b = 32'h99999999;
        test_sel = 1'b1;
        #10
        test_a = 32'h00000000;
        test_b = 32'hFFFFFFFF;
        #10
        test_sel = 1'b0;
        #10
        test_a = 32'h33333333;
        test_b = 32'h00000000;
        $finish;
    end
    
    always @(test_a or test_b or test_sel)
        #1 $display("At t = %0d test_sel = %b test_a = &h test_b = %h test_y = %h",
            $time, test_sel, test_a, test_b, test_y);

endmodule
