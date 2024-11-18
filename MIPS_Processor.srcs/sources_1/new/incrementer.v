`timescale 1ns / 1ps

module incrementer(
    input [31:0] PC,
    output [31:0] Next_PC
    );
    
    assign Next_PC = PC + 1; // for word adressable
    
endmodule