`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2023 09:44:58 PM
// Design Name: 
// Module Name: PC_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_unit(
    input logic Clk, Reset, LD_PC,
    input logic[1:0] PCMUX,
    input logic[15:0] BUS, ADDER, PC_in,SW,
    output logic[15:0] PC
    );
    logic[15:0] desiredPC;
    always_comb
    begin
        unique case(PCMUX)
            2'b00: desiredPC = PC_in + 1'b1;
            2'b01: desiredPC = ADDER;
            2'b10: desiredPC = BUS;
            default: desiredPC = BUS;
        endcase
    end
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            PC <= 16'h0000;
        else if (LD_PC)
            PC <= desiredPC;
    end
endmodule
