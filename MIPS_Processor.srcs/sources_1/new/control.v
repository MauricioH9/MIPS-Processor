`timescale 1ns / 1ps

module control(
    input wire [5:0] opcode,
    
    output reg [3:0] controlEX,     // [RegDst, ALUOp[1:0], ALUSrc]
    output reg [2:0] controlMEM,   // [Branch, MemRead, MemWrite]
    output reg [1:0] controlWB     // [RegWrite, MemToReg]
);

    // Define opcodes 
    parameter R_TYPE = 6'b000000;
    parameter LW     = 6'b100011;
    parameter SW     = 6'b101011;
    parameter BEQ    = 6'b000100;

    always @(opcode) begin
        case (opcode)
            R_TYPE: begin // R-type instruction
                controlEX   = 4'b1100; // RegDst = 1, ALUOp = 10, ALUSrc = 0
                controlMEM  = 3'b000;  // Branch = 0, MemRead = 0, MemWrite = 0
                controlWB   = 2'b10;   // RegWrite = 1, MemToReg = 0
            end
            LW: begin // Load Word
                controlEX   = 4'b0001; // RegDst = 0, ALUOp = 00 (add), ALUSrc = 1
                controlMEM  = 3'b010;  // Branch = 0, MemRead = 1, MemWrite = 0
                controlWB   = 2'b11;   // RegWrite = 1, MemToReg = 1
            end
            SW: begin // Store Word
                controlEX   = 4'b0001; // RegDst = 0, ALUOp = 00 (add), ALUSrc = 1
                controlMEM  = 3'b001;  // Branch = 0, MemRead = 0, MemWrite = 1
                controlWB   = 2'b00;   // RegWrite = 0, MemToReg = 0
            end
            BEQ: begin // Branch Equal
                controlEX   = 4'b0010; // RegDst = 0, ALUOp = 01 (subtract), ALUSrc = 0
                controlMEM  = 3'b100;  // Branch = 1, MemRead = 0, MemWrite = 0
                controlWB   = 2'b00;   // RegWrite = 0, MemToReg = 0
            end
            default: begin // Unsupported opcodes
                controlEX   = 4'b0000;
                controlMEM  = 3'b000;
                controlWB   = 2'b00;
            end
        endcase
    end
endmodule
