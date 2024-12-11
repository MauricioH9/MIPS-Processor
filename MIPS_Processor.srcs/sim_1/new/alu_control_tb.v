`timescale 1ns / 1ps

module alu_control_tb;

    reg [1:0] ALUOp_tb;
    reg [5:0] Function_tb;
    wire [2:0] ALUControl_tb;

    // Instantiate ALU Control 
    alu_control alu_control_uut (
        .ALUOp(ALUOp_tb),
        .Function(Function_tb),
        .ALUControl(ALUControl_tb)
    );

    initial begin
        $monitor ("ALUOp = %b | Function = %b | ALUControl = %b", ALUOp_tb, Function_tb, ALUControl_tb);

        // Load/Store instruction (ALUOp = 00)
        ALUOp_tb = 2'b00; Function_tb = 6'b100000; #10; // Add
        
        // Branch instruction (ALUOp = 01)
        ALUOp_tb = 2'b01; Function_tb = 6'b100000; #10; // Sub

        // R-type (ALUOp = 10)
        ALUOp_tb = 2'b10; Function_tb = 6'b100000; #10; // Add
        ALUOp_tb = 2'b10; Function_tb = 6'b100010; #10; // Sub
        ALUOp_tb = 2'b10; Function_tb = 6'b100100; #10; // AND
        ALUOp_tb = 2'b10; Function_tb = 6'b100101; #10; // OR
        ALUOp_tb = 2'b10; Function_tb = 6'b101010; #10; // sit

        // Undefined ALUOp
        ALUOp_tb = 2'b11; Function_tb = 6'b000000; #10;

        $finish;
    end
endmodule

