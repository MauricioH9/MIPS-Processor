`timescale 1ns / 1ps

module incr(
    input [31:0] a,
    output [31:0] out
    );
    
    assign out = a + 1;
    
endmodule