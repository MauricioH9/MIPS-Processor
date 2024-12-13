`timescale 1ns / 1ps

module adder_tb;

    reg [31:0] test_in1, test_in2;
    wire [31:0] test_out;
    
    adder adder_uut(
        .add_in1(test_in1),
        .add_in2(test_in2),
        .add_out(test_out)
    );
    
    initial begin
        test_in1 = 32'h00000000;
        test_in2 = 32'h00000000;
        #10
        test_in1 = 32'h000000A4;
        test_in2 = 32'h0000002F;
        #10
        test_in1 = 32'h00000007;
        #10
        $finish;
    end

endmodule