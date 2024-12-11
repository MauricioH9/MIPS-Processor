`timescale 1ns / 1ps

module WRITE_BACK(
    input wire [31:0] ReadData,     // Data from memory
    input wire [31:0] ALUResult,    // Data from ALU
    input wire MemToReg,            // Control signal
    output wire [31:0] WriteData    // Data to write to the register file
);

    // Instantiate mux from I_FETCH
    mux mux_WB (
        .a(ALUResult),   // ALU result
        .b(ReadData),    // Data read from memory
        .sel(MemToReg),  // MemToReg control signal
        .y(WriteData)    // Output write data
    );

endmodule
