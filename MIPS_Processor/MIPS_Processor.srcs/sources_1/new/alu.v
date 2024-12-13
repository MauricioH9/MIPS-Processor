`timescale 1ns / 1ps

module alu(
    input [2:0] alu_control,
    input [31:0] in1, in2,
    output zero,
    output reg [31:0] result
    );
    
    always @(*) begin
        case(alu_control)
            3'b010: result = in1 + in2; // Add
            3'b110: result = in1 - in2; // Subtract
            3'b000: result = in1 & in2; // And
            3'b001: result = in1 | in2; // Or
            3'b111: result = (in1 < in2) ? 32'b1 : 32'b0; // Set less than
            default: result = 32'b0;
        endcase
    end
    
    assign zero = (result == 32'b0);
    
endmodule