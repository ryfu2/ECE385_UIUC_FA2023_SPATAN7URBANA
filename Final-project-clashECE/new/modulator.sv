`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 11:47:45 PM
// Design Name: 
// Module Name: modulator
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


module modulator(
    input logic Clk,
    input logic reset,
    input logic [31:0] Sound,
    output logic readready,
    output logic [4:0]desiredsound
    );
    int i;
    always_ff @ (posedge Clk)
    begin
        if (reset)
        begin
            i <= 0;
            readready <= 1;
            desiredsound <= 0;
        end
        if (i == 0)
        begin
            i <= i + 1;
            desiredsound <= Sound[29:25];
            readready <= 0;
        end
        else if (i == 1)
        begin
            i <= i + 1;
            desiredsound <= Sound[24:20]; 
            readready <= 0;
        end
        else if (i == 2)
        begin
            i <= i + 1;
            desiredsound <= Sound[19:16]; 
            readready <= 0;
        end
        else if (i == 3)
        begin
            i <= i + 1;
            desiredsound <= Sound[15:11]; 
            readready <= 0;
        end 
        else if (i == 4)
        begin
            i <= i + 1;
            desiredsound <= Sound[10:5]; 
            readready <= 1;
        end
        else if (i == 5)
        begin
            i <= 0;
            desiredsound <= Sound[4:0]; 
            readready <= 0;
        end
    end
endmodule
