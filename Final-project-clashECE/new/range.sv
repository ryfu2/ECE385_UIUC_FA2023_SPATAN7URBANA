`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 09:14:39 PM
// Design Name: 
// Module Name: range
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


module range(
    input logic Clk, reset,
    input logic [9:0] X,Y,
    input logic [9:0] andX, andY,
    input logic [9:0] orX, orY,
    input logic [9:0] notX, notY,
    input logic [9:0] nerdX, nerdY,
    input logic [9:0] zuofuX, zuofuY,
    input logic [9:0] towerlX, towerlY,
    input logic [9:0] towerrX, towerrY,
    output logic [9:0] targetX, targetY,
    output logic [2:0] index
    );
    logic[11:0] disand, disor, disnot, disnerd, diszuofu, distl, distr;
    rangecalculator rangeand (.X, .Y, .tX(andX), .tY(andY), .Dis(disand));
    rangecalculator rangeor (.X, .Y, .tX(orX), .tY(orY), .Dis(disor));
    rangecalculator rangenot (.X, .Y, .tX(notX), .tY(notY), .Dis(disnot));
    rangecalculator rangenerd (.X, .Y, .tX(nerdX), .tY(nerdY), .Dis(disnerd));
    rangecalculator rangetl (.X, .Y, .tX(towerlX), .tY(towerlY), .Dis(distl));
    rangecalculator rangetr (.X, .Y, .tX(towerrX), .tY(towerrY), .Dis(distr));
    rangecalculator rangezuofu (.X, .Y, .tX(zuofuX), .tY(zuofuY), .Dis(diszuofu));
    
    //Find the minimum distance
    logic [11:0] min0, min1, min2, min3, min4, min5;
    always_ff @ (posedge Clk)
    begin
        if (reset)
            min0 <= 0;
        if (disand < disor)
            min0 <= disand;
        else
            min0 <= disor;
        if (disnot < min0)
            min1 <= disnot;
        else
            min1 <= min0;
        if (disnerd < min1)
            min2 <= disnerd;
        else 
            min2 <= min1;
        if (distl < min2)
            min3 <= distl;
        else 
            min3 <= min2;
        if (distr < min3)
            min4 <= distr;
        else
            min4 <= min3;
        if (diszuofu < min4)
            min5 <= diszuofu;
        else 
            min5 <= min4;
    end
    
    //Map back the X / Y coordinates
    always_comb
        if (min5 == disand)
        begin
            targetX = andX;
            targetY = andY;
            index = 3'd3;
        end
        else if (min5 == disor)
        begin
            targetX = orX;
            targetY = orY;
            index = 3'd4;
        end
        else if (min5 == disnot)
        begin
            targetX = notX;
            targetY = notY;
            index = 3'd5;
        end
        else if (min5 == diszuofu)
        begin
            targetX = zuofuX;
            targetY = zuofuY;
            index = 3'd7;
        end
        else if (min5 == distl)
        begin
            targetX = towerlX;
            targetY = towerlY;
            index = 3'd2;
        end
        else if (min5 == distr)
        begin
            targetX = towerrX;
            targetY = towerrY;
            index = 3'd1;
        end
        else if (min5 == disnerd)
        begin
            targetX = nerdX;
            targetY = nerdY;
            index = 3'd6;
        end
        else
        begin
            targetX = 0;
            targetY = 0;
            index = 0;
        end
endmodule
