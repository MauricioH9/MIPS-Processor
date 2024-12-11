`timescale 1ns / 1ps

module branch(
    
    input wire a,
    input wire b,
    output wire y
    );
    
    assign y = a & b; //AND Gate
endmodule