`timescale 1ns / 1ps

module control_tb;
    reg [5:0] opcode;              
    wire [3:0] controlEX;         
    wire [2:0] controlMEM;       
    wire [1:0] controlWB;         

    // Instantiate the control module
    control control_uut (
        .opcode(opcode),
        .controlEX(controlEX),
        .controlMEM(controlMEM),
        .controlWB(controlWB)
    );

    initial begin
        $display("Time\tOpcode\t\tcontrolEX\tcontrolMEM\tcontrolWB");

        // Test Case 1: R-type instruction (opcode 0)
        opcode = 6'b000000;  // R-type
        #10;
        $display("%0d\t%b\t%b\t%b\t%b", $time, opcode, controlEX, controlMEM, controlWB);

        // Test Case 2: lw (opcode 35)
        opcode = 6'b100011;  // lw
        #10;
        $display("%0d\t%b\t%b\t%b\t%b", $time, opcode, controlEX, controlMEM, controlWB);

        // Test Case 3: sw (opcode 43)
        opcode = 6'b101011;  // sw
        #10;
        $display("%0d\t%b\t%b\t%b\t%b", $time, opcode, controlEX, controlMEM, controlWB);

        // Test Case 4: beq (opcode 4)
        opcode = 6'b000100;  // beq
        #10;
        $display("%0d\t%b\t%b\t%b\t%b", $time, opcode, controlEX, controlMEM, controlWB);

        // Test Case 5: Unsupported opcode
        opcode = 6'b111111;  // Unsupported
        #10;
        $display("%0d\t%b\t%b\t%b\t%b", $time, opcode, controlEX, controlMEM, controlWB);

        $stop;
    end
endmodule
