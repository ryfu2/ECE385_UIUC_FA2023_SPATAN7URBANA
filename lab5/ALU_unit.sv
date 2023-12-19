`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 07:02:30 PM
// Design Name: 
// Module Name: ALU_unit
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


module ALU_unit(
    input logic SR2MUX,
    input logic[1:0] ALUK,
    input logic[4:0] IR,
    input logic[15:0] SR1OUT, SR2OUT,
    output logic[15:0] ALUOUT
    );
    logic [15:0] SEXTIR, desiredSR2, desiredSR1;
    logic [15:0] desiredALUOUT;
    assign SEXTIR = {{11{IR[4]}}, IR};
    assign desiredSR1 = SR1OUT;
    always_comb
    begin
        if (SR2MUX)
            desiredSR2 = SEXTIR;
        else
            desiredSR2 = SR2OUT;
        unique case(ALUK)
            2'b00: desiredALUOUT = desiredSR2 + desiredSR1;
            2'b01: desiredALUOUT = desiredSR2 & desiredSR1;
            2'b10: desiredALUOUT = ~desiredSR1; 
            2'b11: desiredALUOUT = desiredSR1;
        endcase
    end
    assign ALUOUT = desiredALUOUT;
endmodule
