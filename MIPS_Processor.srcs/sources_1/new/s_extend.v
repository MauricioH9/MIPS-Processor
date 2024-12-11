`timescale 1ns / 1ps

module s_extend(
    input wire [15:0] immediate,    // 16-bit immediate input
    output wire [31:0] sign_extended // 32-bit sign-extended output
);
    // Sign extension logic
    assign sign_extended = {{16{immediate[15]}}, immediate};

endmodule
