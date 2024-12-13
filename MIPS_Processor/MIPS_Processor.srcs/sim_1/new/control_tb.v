`timescale 1ns / 1ps

module control_tb;
    wire [8:0] test_control;

    reg [5:0] test_opcode;
    
    control control_uut(
        .opcode(test_opcode),
        .control_bits(test_control)
    );
    
    initial begin
        test_opcode = 6'b000000;
        #20
        test_opcode = 6'b100011;
        #20
        test_opcode = 6'b101011;
        #20
        test_opcode = 6'b00100;
        #20
        $finish;
    end

endmodule
