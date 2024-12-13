`timescale 1ns / 1ps

`timescale 1ns / 1ps

module mux_tb;

    // Inputs
    reg [31:0] a;
    reg [31:0] b;
    reg sel;

    // Outputs
    wire [31:0] y;

    // Instantiate the Unit Under Test (UUT)
    mux mux_uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Initialize inputs
        a = 32'h00000000;
        b = 32'hFFFFFFFF;
        sel = 0;

        // Monitor outputs
        $monitor("Time=%0t | a=%h | b=%h | sel=%b | y=%h", $time, a, b, sel, y);

        // Test Case 1: sel = 0 (choose input a)
        #10 sel = 0;
        #10 a = 32'h12345678;
        
        // Test Case 2: sel = 1 (choose input b)
        #10 sel = 1;
        #10 b = 32'h87654321;

        // Test Case 3: Switch back to input a
        #10 sel = 0;

        // Test Case 4: Edge case with all zeros
        #10 a = 32'h00000000;
            b = 32'h00000000;

        // Test Case 5: Edge case with all ones
        #10 a = 32'hFFFFFFFF;
            b = 32'hFFFFFFFF;

        #10 $stop; // End simulation
    end

endmodule
