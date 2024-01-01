`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 05:17:02 AM
// Design Name: 
// Module Name: Elixir
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


module Elixir(
    input logic background,
    input logic reset,
    input logic clk,
    input logic [4:0] elixirin,
    input logic [9:0] drawX, drawY,
    output logic [4:0] elixirout,
    output logic elixiron
    );
    logic [4:0] elixirdecrement;
    
    logic [9:0] newelixir;
    logic [5:0] increment;
    always_ff @ (posedge clk)
    begin
    if (reset | ~background)
    begin
        newelixir <= 15;
        increment <= 0;
        elixirdecrement <= 0;
    end
    else
    begin
        if (increment <= 59)
            increment <= increment + 1;
        else
        begin
            increment <= 0;
            if (newelixir <= 29)
            begin
                newelixir <= newelixir + 1 - elixirdecrement;
                elixirdecrement <= 0;
            end
            else
            begin
                newelixir <= newelixir - elixirdecrement;
                elixirdecrement <= 0;
            end
        end
    end
    if (elixirin != 0)
        elixirdecrement <= elixirin;
    end
    assign elixirout = newelixir[4:0] / 3;
    always_comb
    begin
    if (background && drawX <= 630 && drawY <= 347 && drawX >= 620)
        begin
            if (drawY >= 347 - 11*newelixir)
               elixiron = 1; 
            else
               elixiron = 0;
        end
    else
        elixiron = 0; 
    end
endmodule
