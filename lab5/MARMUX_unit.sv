`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 10:43:49 PM
// Design Name: 
// Module Name: MARMUX_unit
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


module MARMUX_unit(
    input logic MARMUX,
    input logic[15:0] IR, ADDR,
    output logic[15:0] MARADDER
    );
    logic [15:0] IRzext, desiredoutput;
    assign IRzext= {8'b00000000, IR[7:0]};
    always_comb
    begin
        if (MARMUX == 1'b1) 
            desiredoutput = IRzext;
        else 
            desiredoutput = ADDR;
    end
    assign MARADDER = desiredoutput;
endmodule
