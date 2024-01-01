`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 09:25:29 PM
// Design Name: 
// Module Name: rangecalculator
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

module rangecalculator(
    input logic [9:0] X,Y, tX, tY,
    output logic [11:0] Dis    // 1023 * 1023 * 2 = 2093058, which can be represented using 21 bits
    );
    logic[9:0] DisX, DisY, outX, outY;
    logic sameside;
    assign DisX = X - tX;
    assign DisY = Y - tY;
    always_comb
    begin
    if (tY <= 239 && Y >= 360)
        sameside = 0;
    else if (tY >= 240 && Y <= 120)
        sameside = 0;
    else
        sameside = 1;
    if (DisX[9])
        outX = ~DisX + 1;
    else
        outX = DisX;
    if (DisY[9])
        outY = ~DisY + 1;
    else
        outY = DisY;
    end
    always_comb
    if (tY == 0 || sameside == 0)
        Dis = 12'b011111111111;
    else
        Dis = {2'b0 + outX} + {2'b0 + outY};
endmodule
