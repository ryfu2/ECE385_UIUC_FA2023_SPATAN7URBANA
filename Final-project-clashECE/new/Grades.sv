`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2023 07:55:48 PM
// Design Name: 
// Module Name: Grades
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
module Grade(
    input logic vga_clk,
    input logic [9:0] DrawX, DrawY,
    input logic background,
    input logic gameoverour,
    input logic gameoveroth,
    input logic gameover, timeout,
    input logic [2:0]grade,
    output logic timeleft,
    output logic grades,
    output logic ratings
    );
    logic [10:0] desired_addr, sprite_elixir_addr, sprite_column_addr, sprite_unit_addr, sprite_tenth_addr, sprite_minute_addr;
    logic [7:0] desireddata;
    logic [2:0]desiredgrade;
    logic [11:0] gradesprite, offset;
    font_rom font(.addr(desired_addr), .data(desireddata));
    always_ff @(posedge vga_clk)
    begin
        if (~background)
            desiredgrade <= 3;
        if (!gameover && !timeout)
            desiredgrade <= grade;
        else if (gameoverour && !timeout)
            desiredgrade <= 0;
        else if (gameoveroth && !timeout)
            desiredgrade <= 6;
    end
    always_comb
    begin
    case (desiredgrade)
        0: begin
        gradesprite = 11'h46;
        offset = 11'h20;
        end
        1: begin
        gradesprite = 11'h44;
        offset = 11'h20;
        end
        2: begin
        gradesprite = 11'h43;
        offset = 11'h20;
        end
        3: begin
        gradesprite = 11'h42;
        offset = 11'h20;
        end
        4: begin
        gradesprite = 11'h41;
        offset = 11'h2D;
        end
        5: begin
        gradesprite = 11'h41;
        offset = 11'h20;
        end
        6: begin
        gradesprite = 11'h41;
        offset = 11'h2B;
        end
        default:
        begin
        gradesprite = 11'h20;
        offset = 11'h20;
        end
    endcase
    if (background && DrawX >= 16 && DrawX <= 31 && DrawY >= 24 &&  DrawY <= 95)
       begin
            if (DrawY <= 55 && DrawY >= 48)
                desired_addr = DrawX - 16 + 16*(11'h4C);
            else if (DrawY <= 47 && DrawY >= 40)
                desired_addr = DrawX - 16 + 16*(11'h45);
            else if (DrawY <= 39 && DrawY >= 32)
                desired_addr = DrawX - 16 + 16*(11'h46);
            else if (DrawY <= 31 && DrawY >= 24)
                desired_addr = DrawX - 16 + 16*(11'h54);
            else if (DrawY >= 56 && DrawY <= 63)
                desired_addr = DrawX - 16 + 16*(11'h20);
            else if (DrawY >= 64 && DrawY <= 71)
                desired_addr = DrawX - 16 + 16*(11'h45);
            else if (DrawY >= 72 && DrawY <= 79)
                desired_addr = DrawX - 16 + 16*(11'h4D);
            else if (DrawY >= 80 && DrawY <= 87)
                desired_addr = DrawX - 16 + 16*(11'h49);
            else if (DrawY >= 88 && DrawY <= 95)
                desired_addr = DrawX - 16 + 16*(11'h54);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                timeleft = 1;
                ratings = 0;
                grades = 0;
            end
            else
            begin
                timeleft = 0;
                grades = 0;
                ratings = 0;
            end
        end
    else if (background && DrawX >= 304 && DrawX <= 319 && DrawY >= 168 && DrawY <= 271)
       begin
            if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 304 + 16*offset;
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 304 + 16*gradesprite;
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 304 + 16*(11'h3A);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 304 + 16*(11'h45);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 304 + 16*(11'h44);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 304 + 16*(11'h41);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 304 + 16*(11'h52);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 304 + 16*(11'h47);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 304 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 304 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 304 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 304 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 304 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                grades = 1;
                timeleft = 0;
                ratings = 0;
            end
            else
            begin
                grades = 0;
                timeleft = 0;
                ratings = 0;
            end
    end
    else if (background && (desiredgrade == 3) && DrawX >= 320 && DrawX <= 335 && DrawY >= 136 && DrawY <= 271)
       begin
            if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h53);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h42);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
    else if (background && (desiredgrade == 0) && DrawX >= 320 && DrawX <= 335 && DrawY >= 88 && DrawY <= 271)
       begin
            if (DrawY >= 88 && DrawY <= 95)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 96 && DrawY <= 103)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 104 && DrawY <= 111)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 112 && DrawY <= 119)
                desired_addr = DrawX - 320 + 16*(11'h43);
            else if (DrawY >= 120 && DrawY <= 127)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 128 && DrawY <= 135)
                desired_addr = DrawX - 320 + 16*(11'h46);
            else if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h4D);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
    else if (background && (desiredgrade == 2) && DrawX >= 320 && DrawX <= 335 && DrawY >= 88 && DrawY <= 271)
       begin
            if (DrawY >= 88 && DrawY <= 95)
                desired_addr = DrawX - 320 + 16*(11'h44);
            else if (DrawY >= 96 && DrawY <= 103)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 104 && DrawY <= 111)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 112 && DrawY <= 119)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 120 && DrawY <= 127)
                desired_addr = DrawX - 320 + 16*(11'h4C);
            else if (DrawY >= 128 && DrawY <= 135)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h50);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h43);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
    else if (background && (desiredgrade == 1) && DrawX >= 320 && DrawX <= 335 && DrawY >= 112 && DrawY <= 271)
       begin
            if (DrawY >= 112 && DrawY <= 119)
                desired_addr = DrawX - 320 + 16*(11'h44);
            else if (DrawY >= 120 && DrawY <= 127)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 128 && DrawY <= 135)
                desired_addr = DrawX - 320 + 16*(11'h4C);
            else if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h42);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h53);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h44);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
    else if (background && (desiredgrade == 5) && DrawX >= 320 && DrawX <= 335 && DrawY >= 120 && DrawY <= 271)
       begin
            if (DrawY >= 120 && DrawY <= 127)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 128 && DrawY <= 135)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h56);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
    else if (background && (desiredgrade == 4) && DrawX >= 320 && DrawX <= 335 && DrawY >= 88 && DrawY <= 271)
       begin
            if (DrawY >= 88 && DrawY <= 95)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 96 && DrawY <= 103)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 104 && DrawY <= 111)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 112 && DrawY <= 119)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 120 && DrawY <= 127)
                desired_addr = DrawX - 320 + 16*(11'h45);
            else if (DrawY >= 128 && DrawY <= 135)
                desired_addr = DrawX - 320 + 16*(11'h50);
            else if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h4D);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h43);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
        else if (background && (desiredgrade == 6) && DrawX >= 320 && DrawX <= 335 && DrawY >= 136 && DrawY <= 271)
       begin
            if (DrawY >= 136 && DrawY <= 143)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 144 && DrawY <= 151)
                desired_addr = DrawX - 320 + 16*(11'h46);
            else if (DrawY >= 152 && DrawY <= 159)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 160 && DrawY <= 167)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 168 && DrawY <= 175)
                desired_addr = DrawX - 320 + 16*(11'h5A);
            else if (DrawY >= 176 && DrawY <= 183)
                desired_addr = DrawX - 320 + 16*(11'h3A);
            else if (DrawY >= 184 && DrawY <= 191)
                desired_addr = DrawX - 320 + 16*(11'h47);
            else if (DrawY >= 192 && DrawY <= 199)
                desired_addr = DrawX - 320 + 16*(11'h4E);
            else if (DrawY >= 200 && DrawY <= 207)
                desired_addr = DrawX - 320 + 16*(11'h49);
            else if (DrawY >= 208 && DrawY <= 215)
                desired_addr = DrawX - 320 + 16*(11'h54);
            else if (DrawY >= 216 && DrawY <= 223)
                desired_addr = DrawX - 320 + 16*(11'h41);
            else if (DrawY >= 224 && DrawY <= 231)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 232 && DrawY <= 239)
                desired_addr = DrawX - 320 + 16*(11'h20);
            else if (DrawY >= 240 && DrawY <= 247)
                desired_addr = DrawX - 320 + 16*(11'h52);
            else if (DrawY >= 248 && DrawY <= 255)
                desired_addr = DrawX - 320 + 16*(11'h55);
            else if (DrawY >= 256 && DrawY <= 263)
                desired_addr = DrawX - 320 + 16*(11'h4F);
            else if (DrawY >= 264 && DrawY <= 271)
                desired_addr = DrawX - 320 + 16*(11'h59);
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                ratings = 1;
                timeleft = 0;
                grades = 0;
            end
            else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
            end
        end
    else
            begin
                ratings = 0;
                timeleft = 0;
                grades = 0;
                desired_addr = 0;
            end
    end
endmodule
