`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 02:22:57 AM
// Design Name: 
// Module Name: numbers
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


module numbers(
    input logic[5:0] second,
    input logic[1:0] minute,
    input logic [4:0] elixir,
    input logic [9:0] DrawX, DrawY,
    input logic background,
    input logic andinstate, orinstate, notinstate, nerdinstate,
    output logic number_on,
    output logic elixirnum,
    output logic and_name_on, or_name_on, not_name_on, nerd_name_on,
    output logic Timeout,
    output logic loading
    );
    logic [3:0] unit, tenth;
    logic [10:0] desired_addr, sprite_elixir_addr, sprite_column_addr, sprite_unit_addr, sprite_tenth_addr, sprite_minute_addr;
    logic [7:0] desireddata;
    logic [9:0] shape_x;
    assign unit = second % 10;
    assign tenth = second / 10;
    assign sprite_unit_addr = unit + 11'h30;
    assign sprite_tenth_addr = tenth + 11'h30;
    assign sprite_minute_addr = minute + 11'h30;
    assign sprite_column_addr = 11'h3A;
    //Elixir addr
    always_comb
    begin
    if (elixir == 10)
        sprite_elixir_addr = 11'h41;
    else
        sprite_elixir_addr = elixir + 11'h30;
    end
    font_rom font(.addr(desired_addr), .data(desireddata));
    
    //Timer Display
    always_comb
    begin
    if (background && DrawX >= 36 && DrawX <= 51 && DrawY >= 24 &&  DrawY <= 55)
       begin
            if (DrawY <= 55 && DrawY >= 48)
                desired_addr = DrawX - 36 + 16*sprite_minute_addr;
            else if (DrawY <= 47 && DrawY >= 40)
                desired_addr = DrawX - 36 + 16*sprite_column_addr;
            else if (DrawY <= 39 && DrawY >= 32)
                desired_addr = DrawX - 36 + 16*sprite_tenth_addr;
            else if (DrawY <= 31 && DrawY >= 24)
                desired_addr = DrawX - 36 + 16*sprite_unit_addr;
            else
                desired_addr = 0;
            if ((desireddata[DrawY[2:0]]))
            begin
                number_on = 1;
                elixirnum = 0;
                and_name_on = 0;
                loading = 0;
                Timeout = 0;
                or_name_on = 0;
                not_name_on = 0;
                nerd_name_on = 0;
            end
            else
            begin
                number_on = 0;
                elixirnum = 0;
                and_name_on = 0;
                loading = 0;
                Timeout = 0;
                or_name_on = 0;
                nerd_name_on = 0;
                not_name_on = 0;
            end
        end
     //Elixir display
        else if (background && DrawX >= 615 && DrawX <= 630 && DrawY >= 336 &&  DrawY <= 343)
            begin
                desired_addr = DrawX - 615 + 16*sprite_elixir_addr;
                if ((desireddata[DrawY[2:0]]))
                begin
                    elixirnum = 1;
                    number_on = 0;
                    and_name_on = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end
                else
                begin
                    elixirnum = 0;
                    number_on = 0;
                    and_name_on = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end
            end
     //Unit name display: AND GATE
       else if (background && andinstate && DrawY >= 200 && DrawY <= 263 && DrawX >= 516 && DrawX <= 531)
           begin
                if (DrawY >= 200 && DrawY <= 207)
                    desired_addr = DrawX - 516 + 16*(11'h45);
                else if (DrawY >= 208 && DrawY <= 215)
                    desired_addr = DrawX - 516 + 16*(11'h54);
                else if (DrawY >= 216 && DrawY <= 223)
                    desired_addr = DrawX - 516 + 16*(11'h41);
                else if (DrawY >= 224 && DrawY <= 231)
                    desired_addr = DrawX - 516 + 16*(11'h47);
                else if (DrawY >= 232 && DrawY <= 239)
                    desired_addr = DrawX - 516 + 16*(11'h20);
                else if (DrawY >= 240 && DrawY <= 247)
                    desired_addr = DrawX - 516 + 16*(11'h44);
                else if (DrawY >= 248 && DrawY <= 255)
                    desired_addr = DrawX - 516 + 16*(11'h4E);
                else if (DrawY >= 256 && DrawY <= 263)
                    desired_addr = DrawX - 516 + 16*(11'h41);
                  
                else 
                    desired_addr = 0;
                if (desireddata[DrawY[2:0]])
                begin
                    and_name_on = 1;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    nerd_name_on = 0;
                    not_name_on = 0;
                end
                else
                begin
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end     
           end
        //Or Gate Display
         else if (background && orinstate && DrawY >= 200 && DrawY <= 255 && DrawX >= 516 && DrawX <= 531)
           begin
                if (DrawY >= 200 && DrawY <= 207)
                    desired_addr = DrawX - 516 + 16*(11'h45);
                else if (DrawY >= 208 && DrawY <= 215)
                    desired_addr = DrawX - 516 + 16*(11'h54);
                else if (DrawY >= 216 && DrawY <= 223)
                    desired_addr = DrawX - 516 + 16*(11'h41);
                else if (DrawY >= 224 && DrawY <= 231)
                    desired_addr = DrawX - 516 + 16*(11'h47);
                else if (DrawY >= 232 && DrawY <= 239)
                    desired_addr = DrawX - 516 + 16*(11'h20);
                else if (DrawY >= 240 && DrawY <= 247)
                    desired_addr = DrawX - 516 + 16*(11'h52);
                else if (DrawY >= 248 && DrawY <= 255)
                    desired_addr = DrawX - 516 + 16*(11'h4F);
                  
                else 
                    desired_addr = 0;
                if (desireddata[DrawY[2:0]])
                begin
                    or_name_on = 1;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    and_name_on = 0;
                    nerd_name_on = 0;
                    not_name_on = 0;
                end
                else
                begin
                    or_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    and_name_on = 0;
                    nerd_name_on = 0;
                    not_name_on = 0;
                end     
           end
        //Not Gate
        else if (background && notinstate && DrawY >= 200 && DrawY <= 263 && DrawX >= 516 && DrawX <= 531)
           begin
                if (DrawY >= 200 && DrawY <= 207)
                    desired_addr = DrawX - 516 + 16*(11'h45);
                else if (DrawY >= 208 && DrawY <= 215)
                    desired_addr = DrawX - 516 + 16*(11'h54);
                else if (DrawY >= 216 && DrawY <= 223)
                    desired_addr = DrawX - 516 + 16*(11'h41);
                else if (DrawY >= 224 && DrawY <= 231)
                    desired_addr = DrawX - 516 + 16*(11'h47);
                else if (DrawY >= 232 && DrawY <= 239)
                    desired_addr = DrawX - 516 + 16*(11'h20);
                else if (DrawY >= 240 && DrawY <= 247)
                    desired_addr = DrawX - 516 + 16*(11'h54);
                else if (DrawY >= 248 && DrawY <= 255)
                    desired_addr = DrawX - 516 + 16*(11'h4F);
                else if (DrawY >= 256 && DrawY <= 263)
                    desired_addr = DrawX - 516 + 16*(11'h4E);
                  
                else 
                    desired_addr = 0;
                if (desireddata[DrawY[2:0]])
                begin
                    not_name_on = 1;
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    nerd_name_on = 0;
                end
                else
                begin
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end     
           end
        //Nerd 
        else if (background && nerdinstate && DrawY >= 216 && DrawY <= 247 && DrawX >= 516 && DrawX <= 531)
           begin
                if (DrawY >= 216 && DrawY <= 223)
                    desired_addr = DrawX - 516 + 16*(11'h44);
                else if (DrawY >= 224 && DrawY <= 231)
                    desired_addr = DrawX - 516 + 16*(11'h52);
                else if (DrawY >= 232 && DrawY <= 239)
                    desired_addr = DrawX - 516 + 16*(11'h45);
                else if (DrawY >= 240 && DrawY <= 247)
                    desired_addr = DrawX - 516 + 16*(11'h4E);
                  
                else 
                    desired_addr = 0;
                if (desireddata[DrawY[2:0]])
                begin
                    nerd_name_on = 1;
                    not_name_on = 0;
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                end
                else
                begin
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    loading = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end     
           end
       else if (!background && DrawY >= 200 && DrawY <= 255 && DrawX >= 280 && DrawX <= 295)
       begin
                if (DrawY >= 200 && DrawY <= 207)
                    desired_addr = DrawX - 280 + 16*(11'h47);
                else if (DrawY >= 208 && DrawY <= 215)
                    desired_addr = DrawX - 280 + 16*(11'h4E);
                else if (DrawY >= 216 && DrawY <= 223)
                    desired_addr = DrawX - 280 + 16*(11'h49);
                else if (DrawY >= 224 && DrawY <= 231)
                    desired_addr = DrawX - 280 + 16*(11'h44);
                else if (DrawY >= 232 && DrawY <= 239)
                    desired_addr = DrawX - 280 + 16*(11'h41);
                else if (DrawY >= 240 && DrawY <= 247)
                    desired_addr = DrawX - 280 + 16*(11'h4F);
                else if (DrawY >= 248 && DrawY <= 255)
                    desired_addr = DrawX - 280 + 16*(11'h4C);
                else 
                    desired_addr = 0;
                if (desireddata[DrawY[2:0]])
                begin
                    loading = 1;
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end
                else
                begin
                    loading = 0;
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    Timeout = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end     
       end
       else if (!(minute || second) && DrawY >= 200 && DrawY <= 263 && DrawX >= 280 && DrawX <= 295)
       begin
                if (DrawY >= 200 && DrawY <= 207)
                    desired_addr = DrawX - 280 + 16*(11'h21);
                else if (DrawY >= 208 && DrawY <= 215)
                    desired_addr = DrawX - 280 + 16*(11'h54);
                else if (DrawY >= 216 && DrawY <= 223)
                    desired_addr = DrawX - 280 + 16*(11'h55);
                else if (DrawY >= 224 && DrawY <= 231)
                    desired_addr = DrawX - 280 + 16*(11'h4F);
                else if (DrawY >= 232 && DrawY <= 239)
                    desired_addr = DrawX - 280 + 16*(11'h45);
                else if (DrawY >= 240 && DrawY <= 247)
                    desired_addr = DrawX - 280 + 16*(11'h4D);
                else if (DrawY >= 248 && DrawY <= 255)
                    desired_addr = DrawX - 280 + 16*(11'h49);
                else if (DrawY >= 255 && DrawY <= 263)
                    desired_addr = DrawX - 280 + 16*(11'h54);
                else 
                    desired_addr = 0;
                if (desireddata[DrawY[2:0]])
                begin
                    Timeout = 1;
                    loading = 0;
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end
                else
                begin
                    Timeout = 0;
                    loading = 0;
                    and_name_on = 0;
                    number_on = 0;
                    elixirnum = 0;
                    or_name_on = 0;
                    not_name_on = 0;
                    nerd_name_on = 0;
                end     
       end
       else
            begin
            number_on = 0;
            desired_addr = 0;
            elixirnum = 0;
            and_name_on = 0;
            loading = 0;
            Timeout = 0;
            or_name_on = 0;
            not_name_on = 0;
            nerd_name_on = 0;
            end
   end
endmodule
