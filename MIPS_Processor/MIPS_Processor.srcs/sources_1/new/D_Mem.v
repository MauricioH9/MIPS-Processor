`timescale 1ns / 1ps

module d_mem(
    input clk, rst,
    input wire mem_write, mem_read,
    input wire [31:0] write_dat, addr,
    output reg [31:0] read_dat
    );
    
    // 256 32-bit Words
    reg [31:0] mem [0:255];
    integer i;
    
    // Memory Read
    always @(posedge clk) begin
        if(mem_read) begin
            read_dat = mem[addr[7:0]];
        end else begin
            read_dat = 32'b0;
        end
   end 
   
    // Memory Write
    always @(posedge clk) begin
        if(rst) begin
            for(i = 0; i < 256; i = i + 1)
                mem[i] <= 32'b0;
        end
        else if(mem_write) begin
            mem[addr[7:0]] <= write_dat;
        end
    end
    
    initial begin
        $readmemb("data.mem", mem);
        for (i = 0; i < 6; i = i + 1)
            $display(mem[i]);
    end
    
endmodule