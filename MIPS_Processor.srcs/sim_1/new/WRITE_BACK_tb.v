`timescale 1ns / 1ps

module WRITE_BACK_tb;

    reg [31:0] ReadData_tb;    
    reg [31:0] ALUResult_tb;    
    reg MemToReg_tb;           
    wire [31:0] WriteData_tb;   
  
    // Instantiate WRITE_BACK 
    WRITE_BACK WRITE_BACK_uut (
        .ReadData(ReadData_tb),
        .ALUResult(ALUResult_tb),
        .MemToReg(MemToReg_tb),
        .WriteData(WriteData_tb)
    );

    initial begin
      
        $monitor("Time=%0t | ReadData=%h | ALUResult=%h | MemToReg=%b | WriteData=%h",
                 $time, ReadData_tb, ALUResult_tb, MemToReg_tb, WriteData_tb);

        // Test case 1: MemToReg = 0, select ALUResult
        ReadData_tb = 32'hDEADBEEF;
        ALUResult_tb = 32'h12345678;
        MemToReg_tb = 0;
        #10;

        // Test case 2: MemToReg = 1, select ReadData
        ReadData_tb = 32'hA5A5A5A5;
        ALUResult_tb = 32'h87654321;
        MemToReg_tb = 1;
        #10;

        // Test case 3: Random values, MemToReg = 0
        ReadData_tb = 32'hFFFFFFFF;
        ALUResult_tb = 32'h00000001;
        MemToReg_tb = 0;
        #10;

        // Test case 4: Random values, MemToReg = 1
        ReadData_tb = 32'h0000FFFF;
        ALUResult_tb = 32'hFFFF0000;
        MemToReg_tb = 1;
        #10;

        $finish;
    end

endmodule
