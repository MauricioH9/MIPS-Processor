`timescale 1ns / 1ps

module alu(
    input wire [31:0] A, B,            
    input wire [2:0] ALUControl,    
    output reg [31:0] Result,       
    output wire Zero                
);

    // Zero flag logic
    assign Zero = (Result == 32'b0) ? 1'b1 : 1'b0;

    // ALU operation
    always @(*) begin
        case (ALUControl)
            3'b010: Result = A + B;                     // Add
            3'b110: Result = A - B;                     // Sub
            3'b000: Result = A & B;                     // AND
            3'b001: Result = A | B;                     // OR
            3'b111: Result = (A < B) ? 32'b1 : 32'b0;   //Set Less Than
            default: Result = 32'b0;                    // Undefined 
        endcase
    end

endmodule
