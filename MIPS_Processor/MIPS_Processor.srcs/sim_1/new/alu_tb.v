`timescale 1ns / 1ps

module alu_tb;

    reg [2:0] test_alu_control;
    reg [31:0] test_in1, test_in2;
    
    wire test_zero;
    wire [31:0] test_result;
    
    alu alu_uut(
        .alu_control(test_alu_control),
        .in1(test_in1),
        .in2(test_in2),
        .zero(test_zero),
        .result(test_result)
    );
    
    initial begin
        test_alu_control = 3'b000;
        test_in1 = 32'd40;
        test_in2 = 32'd40;
        #10
        test_in1 = 32'd27;
        test_in2 = 32'd35;
        #10
        test_alu_control = 3'b010;
        #10
        test_alu_control = 3'b110;
        #10
        test_alu_control = 3'b111;
        #10
        test_alu_control = 3'b001;
        #10
        $finish;
    end    

endmodule
