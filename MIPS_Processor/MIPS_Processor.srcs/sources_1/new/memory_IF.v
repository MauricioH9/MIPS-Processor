`timescale 1ns / 1ps

module memory(
    input clk,
    input wire [31:0] addr,
    output reg [31:0] data
    );
    
    reg [31:0] MEM[0:127];
    integer i;
    initial begin
        $readmemb("risc.mem", MEM);
        for (i = 0; i < 24; i = i + 1)
           $display(MEM[i]);
    end

    
    always @ (posedge clk) begin
        data <= MEM[addr];
    end 
endmodule