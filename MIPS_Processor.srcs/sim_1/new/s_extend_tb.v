`timescale 1ns / 1ps

module s_extend_tb;

    reg [15:0] immediate;
    wire [31:0] sign_extended;

    // Instantiate  s_extend module
    s_extend s_extend_uut (
        .immediate(immediate),
        .sign_extended(sign_extended)
    );

    initial begin
        $display("Time\tImmediate\t\tSign Extended");

        // Test Case 1: Positive immediate value
        immediate = 16'h1234; // +4660
        #10;
        $display("%0d\t%h\t\t%h", $time, immediate, sign_extended);

        // Test Case 2: Negative immediate value
        immediate = 16'hF234; // -3564 (2's complement)
        #10;
        $display("%0d\t%h\t\t%h", $time, immediate, sign_extended);

        // Test Case 3: Zero
        immediate = 16'h0000; // 0
        #10;
        $display("%0d\t%h\t\t%h", $time, immediate, sign_extended);

        // Test Case 4: Maximum positive value
        immediate = 16'h7FFF; // +32767
        #10;
        $display("%0d\t%h\t\t%h", $time, immediate, sign_extended);

        // Test Case 5: Maximum negative value
        immediate = 16'h8000; // -32768
        #10;
        $display("%0d\t%h\t\t%h", $time, immediate, sign_extended);

        $stop;
    end
endmodule
