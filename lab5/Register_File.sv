`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 06:11:43 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input logic Clk, Reset, LD_REG,
    input logic[15:0] BUS,
    input logic[2:0] DR, SR2IN, SR1IN,
    output logic[15:0] SR2OUTPUT, SR1OUTPUT
    );
    logic[15:0] desiredSR1, desiredSR2;
    logic [2:0] loadR, SR1select, SR2select;
    logic[7:0][15:0] Regs;  //"A 2-D Array of Registers"
    always_ff @(posedge Clk)
    begin
        if (Reset)
        begin
            Regs[0] = 16'h0000;
            Regs[1] = 16'h0000;
            Regs[2] = 16'h0000;
            Regs[3] = 16'h0000;
            Regs[4] = 16'h0000;
            Regs[5] = 16'h0000;
            Regs[6] = 16'h0000;
            Regs[7] = 16'h0000;
        end
        if (LD_REG)
        begin
            unique case(DR)
                3'b000: Regs[0] = BUS;
                3'b001: Regs[1] = BUS;
                3'b010: Regs[2] = BUS;
                3'b011: Regs[3] = BUS;
                3'b100: Regs[4] = BUS;
                3'b101: Regs[5] = BUS;
                3'b110: Regs[6] = BUS;
                3'b111: Regs[7] = BUS;
            endcase
        end
    end
    always_comb
    begin
        unique case(SR1IN)
            3'b000: desiredSR1 = Regs[0];
            3'b001: desiredSR1 = Regs[1];
            3'b010: desiredSR1 = Regs[2];
            3'b011: desiredSR1 = Regs[3];              
            3'b100: desiredSR1 = Regs[4];
            3'b101: desiredSR1 = Regs[5];
            3'b110: desiredSR1 = Regs[6];
            3'b111: desiredSR1 = Regs[7];
        endcase
        unique case(SR2IN)
            3'b000: desiredSR2 = Regs[0];
            3'b001: desiredSR2 = Regs[1];
            3'b010: desiredSR2 = Regs[2];
            3'b011: desiredSR2 = Regs[3];              
            3'b100: desiredSR2 = Regs[4];
            3'b101: desiredSR2 = Regs[5];
            3'b110: desiredSR2 = Regs[6];
            3'b111: desiredSR2 = Regs[7];
        endcase
        SR1OUTPUT = desiredSR1;
        SR2OUTPUT = desiredSR2;
    end
endmodule
