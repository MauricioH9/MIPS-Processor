`timescale 1ns / 1ps

module mux_32bit_tb();
    // Inputs
    reg [31:0] a, b;
    reg sel;

    // Outputs
    wire [31:0] y;

    // Instantiate mux_32bit
    mux_32bit mux_32bit_uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Monitor signal changes
        $monitor("At t = %0d: sel = %b, a = %h, b = %h, y = %h", $time, sel, a, b, y);

        //sel = 0, y should equal a
        a = 32'hAAAAAAAA;
        b = 32'h55555555;
        sel = 1'b0; 
        #10;

        // sel = 1, y should equal b
        sel = 1'b1;
        #10;

        // Change `a` while sel = 0
        sel = 1'b0;
        a = 32'h00000000;
        #10;

        // Change `b` while sel = 1
        sel = 1'b1;
        b = 32'hFFFFFFFF;
        #10;

        // Both inputs change, sel = 1
        a = 32'hA5A5A5A5;
        b = 32'hDDDDDDDD;
        sel = 1'b1;
        #10;

        // Invalid `sel` value (1'bx)
        sel = 1'bx;
        #10;

        $finish; 
    end
endmodule
