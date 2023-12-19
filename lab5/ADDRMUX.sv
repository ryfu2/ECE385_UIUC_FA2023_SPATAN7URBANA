`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 09:28:35 PM
// Design Name: 
// Module Name: ADDRMUX
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
// This module is the combination of an adder and two Muxes
// 
//////////////////////////////////////////////////////////////////////////////////


module ADDRMUX(
    input logic [15:0] PC, SR1OUT, 
    input logic [15:0] IR,
    input logic ADDR1MUX,
    input logic [1:0]ADDR2MUX,
    output logic [15:0] ADDR
    );
    logic [15:0] desiredADDR1, desiredADDR2, desiredoutput;
    always_comb
    begin
        if (ADDR2MUX == 2'b00)
            desiredADDR2 = 16'b0;
        else if (ADDR2MUX == 2'b01)
            desiredADDR2 = {{10{IR[5]}}, IR[5:0]};
        else if (ADDR2MUX == 2'b10)
            desiredADDR2 = {{7{IR[8]}}, IR[8:0]};
        else if (ADDR2MUX == 2'b11)
            desiredADDR2 = {{5{IR[10]}}, IR[10:0]};
        else 
            desiredADDR2 = IR;
        if (ADDR1MUX == 1'b1)
            desiredADDR1 = SR1OUT;
        else if (ADDR1MUX == 1'b0)
            desiredADDR1 = PC;
        else
            desiredADDR1 = IR;
    end
    assign desiredoutput = desiredADDR1 + desiredADDR2;
    assign ADDR = desiredoutput;
endmodule
