module or_gate_example (
	input logic vga_clk,
	input logic vsync,
	input logic reset,
	input logic towerrd, towerld,
	input logic [2:0] attackc, attackt, attackrt,
	input logic [2:0] attackeand, attackeor,
	input logic [9:0] DrawX, DrawY,
	input logic [9:0] andX, andY, orX, orY, nerdX, nerdY,
	input logic [9:0] MouseX, MouseY,
	input logic deployin, instatein, idlein,
	output logic [3:0] red, green, blue,
	output logic enable, infield, health,
	output logic [3:0] attackindex, 
	output logic [9:0]X,Y
);

logic [10:0] rom_address;
logic [3:0] rom_q;
logic [9:0] sMouseX, sMouseY;
logic [2:0] attack;
assign attack = attackc + attackt + attackrt + attackeand + attackeor;

logic [3:0] palette_red, palette_green, palette_blue;
logic deploy;
logic setdeploy;

logic negedge_vga_clk;
logic[4:0] hp;
logic[5:0] increment;
logic speeden, s;
int Size, DistandX, DistandY;

logic[9:0] targetX, targetY;
logic [2:0]index;

//Determine which tower to attack
logic [9:0] towerrX, towerrY, towerlX, towerlY, zuofuX, zuofuY;

always_comb
begin
if (!towerrd && Y <= 239 && Y != 0)
    begin
        towerrX = 10'd150;
        towerrY = 10'd80;
    end
else
    begin
        towerrX = 0;
        towerrY = 0;
    end
if (!towerld && Y >= 240)
    begin
        towerlX = 10'd150;
        towerlY = 10'd400;
    end
else
    begin
        towerlX = 0;
        towerlY = 0;
    end
if (towerrd && Y <= 239 && Y != 0)
    begin
        zuofuX = 10'd100;
        zuofuY = 10'd240;
    end
else if (towerld && Y >= 240)
    begin
        zuofuX = 10'd100;
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
range orrange(
.Clk(vga_clk),
.reset(idlein),
.X(sMouseX),
.Y(sMouseY),
.andX(andX),
.andY(andY),
.orX(orX),
.orY(orY),
.notX(0),
.notY(0),
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
 assign DistandX = targetX - sMouseX;
 assign DistandY = targetY - sMouseY;
 assign Size = 80;
// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;
always_ff @ (posedge vsync)
begin
    if (hp >= attack)
    hp <= hp - attack;
    else
    hp <= 0;
    if (idlein)
        begin
        deploy <= 0;
        sMouseX <= 0;
        sMouseY <= 0;
        hp <= 10;
        attackindex <= 0;
        speeden <= 0;
        end
    if (deployin == 1)
        begin
        deploy <= 1;
        sMouseX <= MouseX;
        sMouseY <= MouseY;
        end
    if (deploy)
        begin
        speeden <= 1;
        if ((DistandX * DistandX + DistandY * DistandY) > Size * Size)
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
                    attackindex <= 0;
        end
    end
end

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
logic [9:0] remainedhealth;
assign remainedhealth = (hp % 11) * 6;
always_comb
begin
    if (instatein)
    begin
        infield = 0;
        if (DrawX >= (MouseX - 15) && DrawX <= (MouseX + 16) && DrawY >= (MouseY - 31) && DrawY <= (MouseY + 32))
            begin
                rom_address = (DrawX - (MouseX - 15)) + ((DrawY - (MouseY - 31)) * 32);
                if (DrawX >= MouseX - 10)
                    begin 
                    enable = 1;
                    health = 0;
                    end
                else
                    begin
                    health = 0;
                    enable = 0;
                    end
                setdeploy = 0;
            end
        else
        begin
            rom_address = (DrawX - 570) + ((DrawY - 207) * 32);
            enable = 0;
            setdeploy = 0;
            health = 0;
        end
    
    end
    else if (hp == 0)
    begin
        infield = 0;  
        if (DrawX >= 570 && DrawX <= 601 && DrawY <= 270 && DrawY >= 207)
        begin    
            rom_address = (DrawX - 570) + ((DrawY - 207) * 32);
            enable = 1;
            setdeploy = 0;
            health = 0;
        end
        else
        begin
            rom_address = (DrawX - 570) + ((DrawY - 207) * 32);
            enable = 0;
            setdeploy = 0;
            health = 0;
        end
    end
    else if (deploy)
    begin
        infield = 1;
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
                setdeploy = 0;
            end
        else
        begin
            rom_address = (DrawX - 570) + ((DrawY - 207) * 32);
            enable = 0;
            setdeploy = 0;
            health = 0;
        end
    end
    else
    begin  
        infield = 0;  
        if (DrawX >= 570 && DrawX <= 601 && DrawY <= 270 && DrawY >= 207)
        begin    
            rom_address = (DrawX - 570) + ((DrawY - 207) * 32);
            enable = 1;
            setdeploy = 0;
            health = 0;
        end
        else
        begin
            rom_address = (DrawX - 570) + ((DrawY - 207) * 32);
            enable = 0;
            setdeploy = 0;
            health = 0;
        end
    end
end

always_ff @ (posedge vga_clk) begin
	red <= palette_red;
	green <= palette_green;
	blue <= palette_blue;
end

or_gate_rom or_gate_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

or_gate_palette or_gate_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

speed speedor(
 .enable(speeden),
 .clk(vsync),
 .rate(3),
 .on(s)
);

assign X = sMouseX;
assign Y = sMouseY;

endmodule
