`timescale 1ns / 1ps

module incr_tb();
    
    wire [31:0] test_out;
    
    reg [31:0] test_a;
    
    incr incr_uut(
        .out(test_out),
        .a(test_a)
    );
    
    initial begin
        test_a = 4;
        #10
        test_a = 30;
        #10
        test_a = 20;
        $finish;
    end

endmodule