`timescale 1ns / 1ps

module alu_tb;

    reg [31:0] A;        
    reg [31:0] B;       
    reg [2:0] ALUControl; 
    wire [31:0] Result;  
    wire Zero;          

    // Instantiate ALU 
    alu alu_uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Zero(Zero)
    );

    initial begin
        $monitor("Time=%0t | A=%d | B=%d | ALUControl=%b | Result=%d | Zero=%b",
                 $time, A, B, ALUControl, Result, Zero);

        A = 32'd0;
        B = 32'd0;
        ALUControl = 3'b000;

        // Add (ALUControl = 010)
        #10;
        A = 32'd10;
        B = 32'd15;
        ALUControl = 3'b010; // Add
        #10;

        // Sub (ALUControl = 110)
        A = 32'd20;
        B = 32'd15;
        ALUControl = 3'b110; // Sub 
        #10;

        // AND (ALUControl = 000)
        A = 32'hFFFF0000;
        B = 32'h0F0F0F0F;
        ALUControl = 3'b000; // AND
        #10;

        // OR (ALUControl = 001)
        A = 32'hFFFF0000;
        B = 32'h0000FFFF;
        ALUControl = 3'b001; // OR
        #10;

        // Set less Than (ALUControl = 111)
        A = 32'd5;
        B = 32'd10;
        ALUControl = 3'b111; // Set Less Than
        #10;

        // Zero flag (Result == 0)
        A = 32'd10;
        B = 32'd10;
        ALUControl = 3'b110; // Sub (10 - 10 = 0)
        #10;

        // Undefined ALUControl
        ALUControl = 3'b011; // Undefined 
        #10;

        $finish;
    end

endmodule
