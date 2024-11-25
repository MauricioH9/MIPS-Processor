module if_id(
    input wire clk,
    input wire reset,            
    input wire [31:0] instr,
    input wire [31:0] npc,
    output reg [31:0] instrout,
    output reg [31:0] npcout
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instrout <= 32'b0;
            npcout <= 32'b0;
        end else begin
            instrout <= instr;
            npcout <= npc;
        end
    end
endmodule
