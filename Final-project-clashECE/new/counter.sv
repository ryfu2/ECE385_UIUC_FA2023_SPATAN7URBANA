`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 11:48:11 PM
// Design Name: 
// Module Name: counter
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


module ffokcounter(
    input logic Clk,
    input logic reset,
    input logic [4:0] Sound,
    output logic clk_44khz, SPK, clk_88khz
    );
    logic[4:0] dsound;
    always_comb
    begin
        if (Sound >= 28)
            dsound = 0;
        else
            dsound = Sound;
    end
    logic [12:0] i;
    always_ff @ (posedge Clk)
    begin
    if (reset)
    begin
        i <= 0;
        clk_44khz <= 0;
        SPK <= 0;
        clk_88khz <= 0;
    end
    if (i <= 6250)
        i <= i + 1;
    else
    begin
        i <= 0;
        clk_44khz <= ~clk_44khz;
        clk_88khz <= ~clk_88khz;
    end
    if (i == 556)
    begin
        clk_88khz <= ~clk_88khz;
    end
    if (i <= dsound && i != 0)
        SPK <= 1;
    else 
        SPK <= 0;
    end
endmodule
