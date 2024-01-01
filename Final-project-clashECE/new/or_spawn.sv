`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2023 02:41:42 AM
// Design Name: 
// Module Name: or_spawn
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2023 06:25:20 PM
// Design Name: 
// Module Name: Spawn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// This module determines the AI logics for unit spawning, according to current situation on the battle field 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module or_spawn (
	input logic vga_clk,
	input logic vsync,
	input logic reset,
	input logic towerrd, towerld,
	input logic [2:0] attackc, attackt, attackrt,attackand,attackor,
	input logic [9:0] DrawX, DrawY,
	input logic [9:0] andX, andY, orX, orY, nerdX, nerdY, notX, notY,
	input logic left, right, nerdleft, nerdright,
	output logic [3:0] red, green, blue,
	output logic enable, health,
	output logic [2:0] attackindex, 
	output logic [9:0]X,Y
);

logic [10:0] rom_address;
logic [3:0] rom_q;
logic [9:0] sMouseX, sMouseY;
logic [2:0] attack;
assign attack = attackc + attackt + attackrt + attackand + attackor;

logic [3:0] palette_red, palette_green, palette_blue;
logic deploy;
logic negedge_vga_clk;
logic[4:0] hp;
logic[5:0] increment;
logic speeden, s;
logic [9:0] targetX, targetY;
logic [2:0]index;

//Determine which tower to attack
logic [9:0] towerrX, towerrY, towerlX, towerlY, zuofuX, zuofuY;
int Size, DistandX, DistandY;
assign DistandX = targetX - sMouseX;
assign DistandY = targetY - sMouseY;
assign Size = 80;
always_comb
begin
if (!towerrd && Y <= 239 && Y != 0)
    begin
        towerrX = 10'd400;
        towerrY = 10'd80;
    end
else
    begin
        towerrX = 0;
        towerrY = 0;
    end
if (!towerld && Y >= 240)
    begin
        towerlX = 10'd400;
        towerlY = 10'd400;
    end
else
    begin
        towerlX = 0;
        towerlY = 0;
    end
if (towerrd && Y <= 239 && Y != 0)
    begin
        zuofuX = 10'd440;
        zuofuY = 10'd240;
    end
else if (towerld && Y >= 240)
    begin
        zuofuX = 10'd440;
        zuofuY = 10'd240;
    end
else
    begin
        zuofuX = 0;
        zuofuY = 0;
    end
end

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;
range andrange(
.Clk(vga_clk),
.reset(reset),
.X(sMouseX),
.Y(sMouseY),
.andX(andX),
.andY(andY),
.orX(orX),
.orY(orY),
.notX(notX),
.notY(notY),
.nerdX(nerdX),
.nerdY(nerdY),
.zuofuX(zuofuX),
.zuofuY(zuofuY),
.towerlX(towerlX),
.towerrX(towerrX),
.towerlY(towerlY),
.towerrY(towerrY),
.targetX(targetX),
.targetY(targetY),
.index(index)
);
always_ff @ (posedge vsync)
begin
    if (hp >= attack)
    hp <= hp - attack;
    else
    hp <= 0;
    if (hp == 0)
    begin
        deploy <= 0;
        attackindex <= 0;
        speeden <= 0;
        sMouseX <= 0;
        sMouseY <= 0;
    end
    if (reset)
        begin
        deploy <= 0;
        sMouseX <= 0;
        sMouseY <= 0;
        hp <= 10;
        attackindex <= 0;
        speeden <= 0;
        end
    if ((right == 1 || nerdright == 1) && !deploy)
        begin
        hp <= 10;
        deploy <= 1;
        sMouseX <= 10'd180;
        sMouseY <= 10'd140;
        end
    else if ((left == 1 || nerdleft == 1) && !deploy)
        begin
        hp <= 10;
        deploy <= 1;
        sMouseX <= 10'd180;
        sMouseY <= 10'd340;
        end
        if (deploy)
        begin
        speeden <= 1;
        if ((DistandX * DistandX + DistandY * DistandY) >= Size * Size)
            begin
            increment <= 0;
            attackindex <= 0;
            if (sMouseX >= targetX + 1)
                sMouseX <= sMouseX - s;
            else if (sMouseX <= targetX - 1)
                sMouseX <= sMouseX + s;
            if (sMouseY >= targetY + 2)
                sMouseY <= sMouseY - s;
            else if (sMouseY <= targetY - 2)
                sMouseY <= sMouseY + s;
            end
        else
        begin
                if (increment <= 59)
                begin
                    increment <= increment + 1;
                    attackindex <= 0;
                end
                else if (increment == 60)
                begin
                    increment <= 0;
                    attackindex <= index;
                end
                else
                    begin
                    increment <= 0;
                    attackindex <= 0;
                    end
        end
    end
end

logic [9:0] remainedhealth;
assign remainedhealth = (hp % 11) * 6;
always_comb
begin
    if (deploy)
    begin
        if (DrawX >= (sMouseX - 15) && DrawX <= (sMouseX + 16) && DrawY >= (sMouseY - 31) && DrawY <= (sMouseY + 32))
            begin
                rom_address = (DrawX - (sMouseX - 15)) + ((DrawY - (sMouseY - 31)) * 32);
                if (DrawX >= sMouseX - 10)
                    begin
                    enable = 1;
                    health = 0;
                    end
                else
                    begin
                    enable = 0;
                    if (DrawY >= (sMouseY + 32 - remainedhealth))
                    health = 1;
                    else
                    health = 0;
                    end
            end
        else
        begin
            rom_address = 0;
            enable = 0;
            health = 0;
        end
    end
    else
    begin  
            rom_address = 0;
            enable = 0;
            health = 0;
    end
end

always_ff @ (posedge vga_clk) begin
	red <= palette_red;
	green <= palette_green;
	blue <= palette_blue;
end

or_gate_rom and_gate_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

or_gate_palette and_gate_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

speed speedand(
 .enable(speeden),
 .clk(vsync),
 .rate(3),
 .on(s)
);

assign X = sMouseX;
assign Y = sMouseY;

endmodule

