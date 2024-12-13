`timescale 1ns / 1ps

module s_extend_tb;

    reg [15:0] test_a;
    
    wire [31:0] test_y;
    
    s_extend sign1(
        .a(test_a),
        .y(test_y)
    );
    
    initial begin
        test_a = -15;
        #20
        test_a = 20;
        #20
        test_a = 30;
        #20
        test_a = 0;
        #20
        $finish;
    end    

endmodule