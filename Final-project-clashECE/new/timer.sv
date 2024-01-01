`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 01:47:47 AM
// Design Name: 
// Module Name: timer
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


module timer(
    input logic background,
    input logic clk,
    input logic reset,
    output logic[5:0] second,
    output logic[1:0] minute,
    output logic to
        );
    logic [7:0] timerout;
    logic [5:0] increment;
    
    always_ff @ (posedge clk)
    begin
    if (reset || ~background)
        begin
        increment <= 0;
        timerout <= 8'd180;
        end
    if (increment <= 60)
        increment <= increment + 1;
    else
        begin
        increment <= 0;
        if (timerout != 0)
        timerout <= timerout - 1;
        end
    end
    always_comb
    begin
    if (timerout >= 1)
    to = 0;
    else
    to = 1;
    end
    
    assign minute = timerout / 60;
    assign second = timerout % 60;
endmodule
