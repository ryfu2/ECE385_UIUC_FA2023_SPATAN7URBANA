//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0]  DrawX, DrawY,
                       input logic Clk,
                       input  logic [31:0] axi_rdata, control_data,
                       output logic [3:0]  Red, Green, Blue );
                       
//    logic IV3, IV2, IV1, IV0;
//    logic[7:0] CODE3, CODE2, CODE1, CODE0;
//    assign IV3 = axi_rdata[31];
//    assign IV2 = axi_rdata[23];
//    assign IV1 = axi_rdata[15];
//    assign IV0 = axi_rdata[7];
//    assign CODE3 = axi_rdata[30:24];
//    assign CODE2 = axi_rdata[22:16];
//    assign CODE1 = axi_rdata[14:8];
//    assign CODE0 = axi_rdata[7:0];
    
//    logic [7:0] data3, data2, data1, data0;
//    font_rom font3(.addr(CODE3), .data(data3));
//    font_rom font2(.addr(CODE2), .data(data2));
//    font_rom font1(.addr(CODE1), .data(data1));
//    font_rom font0(.addr(CODE0), .data(data0));
    logic[9:0] shape_x;
    logic[9:0] shape_y;  
    logic[9:0] threshold;
    
    assign shape_size_x = 32;
    assign shape_size_y = 16;
    
    assign shape_x = DrawX - DrawX % 8;
    assign shape_y = DrawY - DrawY % 16;
    assign threshold = DrawX - DrawX % 32;
    
//    assign shape2_x = shape1_x + 8;
//    assign shape3_x = shape2_x + 8;
//    assign shape4_x = shape3_x + 8;

    logic desiredIV;
    logic [10:0] desiredCode;
    logic [7:0] desireddata;
    logic [10:0] sprite_addr;
    logic [3:0] forer, foreg, foreb, backr, backg, backb;
    
    assign forer = control_data[24:21];
    assign foreg = control_data[20:17];
    assign foreb = control_data[16:13];
    assign backr = control_data[12:9];
    assign backg = control_data[8:5];
    assign backb = control_data[4:1];
    
    always_comb
    begin 
        if ((DrawX - threshold) <= 7 && (DrawX - threshold) >= 0)
        begin
            desiredIV = axi_rdata[7];
            desiredCode = {4'b0000, axi_rdata[6:0]};
        end
        else if ((DrawX - threshold) <= 15 && (DrawX - threshold) >= 8)
        begin
            desiredIV = axi_rdata[15];
            desiredCode = {4'b0000, axi_rdata[14:8]};
        end
        else if ((DrawX - threshold) <=23 && (DrawX - threshold) >= 16)
        begin
            desiredIV = axi_rdata[23];
            desiredCode = {4'b0000, axi_rdata[22:16]};
        end
        else if (((DrawX - threshold) <=31 && (DrawX - threshold) >= 24))
        begin
            desiredIV = axi_rdata[31];
            desiredCode = {4'b0000, axi_rdata[30:24]};
        end
        else
        begin
            desiredIV = 0;
            desiredCode = 0; 
        end
    end
    
    
//always_comb
//begin:Ball_on_proc
//    if (DrawX >= shape_x && DrawX < shape_x + shape_size_x &&
//        DrawY >= shape_y && DrawY < shape_y + shape_size_y)
//        begin
//        shape_on = 1'b1;
//        sprite_addr = (DrawY - shape_y) + desiredCode*16;
//        end
//    else
//        shape_on = 1'b0;
//        sprite_addr = 11'b0;
//end

assign sprite_addr = (DrawY - shape_y) + (16*desiredCode);

font_rom font(.addr(sprite_addr), .data(desireddata));

always_ff @ (posedge Clk)
begin:RGB_Display
    if ((desireddata[7 - DrawX[2:0]])^desiredIV == 1'b1)
        begin
        Red <= forer;
        Green <= foreg;
        Blue <= foreb;
//        if (desiredIV)
//        begin
//            Red = backr;
//            Green = backg;
//            Blue = backb;
//        end
//        else
//        begin
//            Red = forer;
//            Green = foreg;
//            Blue = foreb;
//        end
        end
    else 
    begin
        Red <= backr;
        Green <= backg;
        Blue <= backb;
    end
//    else if(desireddata[7 - DrawX[2:0]] == 1'b0)
//    begin
//        if (desiredIV)
//        begin
//            Red = forer;
//            Green = foreg;
//            Blue = foreb;
//        end
//        else
//        begin
//            Red = backr;
//            Green = backg;
//            Blue = backb;
//        end
//    end
//    else
//    begin
//        if (desiredIV)
//        begin
//            Red = forer;
//            Green = foreg;
//            Blue = foreb;
//        end
//        else
//        begin
//            Red = backr;
//            Green = backg;
//            Blue = backb;
//        end
//    end
end
    
endmodule
