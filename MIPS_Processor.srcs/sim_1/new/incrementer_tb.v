`timescale 1ns / 1ps

module incrementer_tb();
    
    wire [31:0] Next_PC;
    reg  [31:0] PC;

    incrementer incrementer_uut (
    .PC(PC), 
    .Next_PC(Next_PC)
    );

     initial begin
        // Test case 1: Check initial value
        PC = 32'd0;
        #10;
        $display("PC = %d, Next_PC = %d", PC, Next_PC);

        // Test case 2: Check increment by 1
        PC = 32'd5;
        #10;
        $display("PC = %d, Next_PC = %d", PC, Next_PC);

        // Test case 3: Check increment for larger value
        PC = 32'd100;
        #10;
        $display("PC = %d, Next_PC = %d", PC, Next_PC);

        // Test case 4: Check increment for maximum value (overflow scenario)
        PC = 32'hFFFFFFFF;
        #10;
        $display("PC = %h, Next_PC = %h", PC, Next_PC);

        $stop;
    end
endmodule