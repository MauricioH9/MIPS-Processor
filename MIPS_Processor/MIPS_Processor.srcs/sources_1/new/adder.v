`timescale 1ns / 1ps

module adder(
    input [31:0] add_in1, add_in2,
    output [31:0] add_out
    );
    
    assign add_out = add_in1 + add_in2;
    
endmodule