`timescale 1ns / 1ps

module mux_5bit_tb;

    reg [4:0] a;      
    reg [4:0] b;     
    reg sel;          
    wire [4:0] y;    

    // Instantiate  5-bit mux 
    mux_5bit mux_5bit_uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $monitor("a=%b | b=%b | sel=%b | y=%b", a, b, sel, y);

        // sel = 0, output = a
        a = 5'b00001; b = 5'b11110; sel = 0; #10;

        // sel = 1, output = b
        a = 5'b10101; b = 5'b01010; sel = 1; #10;

        // sel = 0, output = a
        a = 5'b11111; b = 5'b00000; sel = 0; #10;

        // sel = 1, output = b
        a = 5'b10001; b = 5'b01110; sel = 1; #10;

        $finish;
    end

endmodule
