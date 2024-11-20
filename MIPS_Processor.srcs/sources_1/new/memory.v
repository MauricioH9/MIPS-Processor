`timescale 1ns / 1ps

module memory(
    input clk,
    output reg [31:0] data, 
    input wire [31:0] addr
    );
    
    reg [31:0] MEM[0:127]; // 128 words of 32-bit memory
    
    initial begin
    
        MEM[0]  <= 'h0000_0000;
        MEM[1]  <= 'h1000_0011;
        MEM[2]  <= 'h2000_0022;
        MEM[3]  <= 'h3000_0033;
        MEM[4]  <= 'h4000_0044;
        MEM[5]  <= 'h5000_0055;
        MEM[6]  <= 'h6000_0066;
        MEM[7]  <= 'h7000_0077;
        MEM[8]  <= 'h8000_0088;
        MEM[9]  <= 'h9000_0099;
        MEM[10] <= 'hA000_00AA;
        MEM[11] <= 'hB000_00BB;
        MEM[12] <= 'hC000_00CC;
        MEM[13] <= 'hD000_00DD;
        MEM[14] <= 'hE000_00EE;
        MEM[15] <= 'hF000_00FF;
    end
    
// Read memory on clock edge
    always @(posedge clk) begin
        if (addr < 128)          // Check for valid address
            data <= MEM[addr];   // Fetch data from memory
        else
            data <= 32'h00000000; // Default for out-of-bounds address
    end    
endmodule