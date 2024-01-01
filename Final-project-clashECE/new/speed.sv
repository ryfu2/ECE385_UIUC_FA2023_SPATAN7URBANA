`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 08:44:54 PM
// Design Name: 
// Module Name: speed
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


module speed(
    input logic enable,
    input logic clk,
    input logic [2:0] rate,
    output logic on
    );
    logic[5:0] increment, threshold;
    assign threshold = 6 / rate;
    always_ff @ (posedge clk)
    begin
    if (~enable)
    begin
        increment <= 0;
        on <= 0;
    end
    else
    begin
        if (increment <= threshold - 1)
        begin
            increment <= increment + 1;
            on <= 0;
        end
        else
        begin
            increment <= 0;
            on <= 1;
        end
    end
    end
endmodule
