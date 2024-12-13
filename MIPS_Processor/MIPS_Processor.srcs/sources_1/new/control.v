`timescale 1ns / 1ps

module control(
    input [5:0] opcode,
    output reg [8:0] control_bits
 );

    always @(*) begin
        case (opcode)
            6'b000000: control_bits = 9'b110000010; // r-type
            6'b100011: control_bits = 9'b000101011; // load word
            6'b101011: control_bits = 9'b000100100; // store word
            
            6'b000100: control_bits = 9'b000000101; // branch
            default: control_bits = 9'b000000000; // nop
        endcase
    end

endmodule
