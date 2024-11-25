`timescale 1ns / 1ps

module alu_control(
    input [1:0] ALUOp,        
    input [5:0] Function,     
    output reg [2:0] ALUControl 
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b010;     // Load/Store (Add)
            2'b01: ALUControl = 3'b110;     // Branch (Sub)
            2'b10: begin                    // R-type instructions
                case (Function)
                    6'b100000: ALUControl = 3'b010; // Add
                    6'b100010: ALUControl = 3'b110; // Sub
                    6'b100100: ALUControl = 3'b000; // AND
                    6'b100101: ALUControl = 3'b001; // OR
                    6'b101010: ALUControl = 3'b111; // Set Less Than 
                    default:   ALUControl = 3'b000; // Undefined
                endcase
            end
            default: ALUControl = 3'b000; // Undefined
        endcase
    end

endmodule
