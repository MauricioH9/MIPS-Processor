`timescale 1ns / 1ps

module adder_tb;

    reg [31:0] A;     
    reg [31:0] B;     
    wire [31:0] Sum;  

    // Instantiate adder 
    adder adder_uut (
        .A(A),
        .B(B),
        .Sum(Sum)
    );

    initial begin
        $monitor("A=%d | B=%d | Sum=%d", A, B, Sum);

        // 0 + 0
        A = 32'd0; B = 32'd0; #10;

        // 10 _+ 20 
        A = 32'd10; B = 32'd20; #10;

        // -15 + 30
        A = -32'd15; B = 32'd30; #10;

        //  Max Positive + Min Negative
        A = 32'h7FFFFFFF; B = 32'h80000000; #10;

        // random + random
        A = 32'h12345678; B = 32'h87654321; #10;

        $finish;
    end

endmodule
