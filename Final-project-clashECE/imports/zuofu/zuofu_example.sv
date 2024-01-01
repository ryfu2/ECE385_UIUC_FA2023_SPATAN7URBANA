(* use_dsp = "yes" *)
module battle_example (
	input logic vga_clk,
	input logic vsync,
	input logic reset, number, elion, elinum,loading,Timeoutd, timeout,
	input logic andnameon, notnameon, ornameon, nerdnameon,
	input logic [9:0] DrawX, DrawY,
	input logic [9:0] MouseX, MouseY,
	input logic blank, background,
	input logic [2:0] andsignals, orsignals, notsignals, nerdsignals,
	output logic andinfield, orinfield, notinfield, nerdinfield,
	output logic gameover,
	output logic [3:0] red, green, blue
);

logic [16:0] rom_address;
logic [3:0] rom_b;

logic [3:0] zuofu_palette_red, zuofu_palette_green, zuofu_palette_blue;
logic [3:0] bpalette_red, bpalette_green, bpalette_blue;
logic negedge_vga_clk;

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
assign rom_address = ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
logic[5:0] remainedtwr, remainedotwr;
logic[5:0] remainedtwl, remainedotwl;
logic[5:0] remainedc, remainedd;
assign remainedtwr = (hpr % 31)*2;
assign remainedotwr = (ohpr % 31)*2;
assign remainedtwl = (hpl % 31)*2;
assign remainedotwl = (ohpl % 31)*2;
assign remainedc = (hpc % 31)*2;
assign remainedd = (hpd % 31)*2;
logic[2:0] grade;
logic gameoverour, gameoveroth, gameoveron;
logic timeleft, grades, ratings;
always_comb
begin
    if (!hpd)
        begin
        gameoverour = 1;
        grade = 0;
        gameoveroth = 0;
        end
    else if (!hpc)
        begin
        gameoveroth = 1;
        grade = 6;
        gameoverour = 0;
        end
    else
        begin
        gameoverour = 0;
        gameoveroth = 0;
        grade = 3 + towerld + towerrd - otowerrd - otowerld;
        end
end

assign gameover = gameoverour | gameoveroth;
Grade gradedisplay(.*);




always_ff @ (posedge vga_clk) begin
    if (~background)
	   begin
	       red <= zuofu_red;
	       green <= zuofu_green;
	       blue <= zuofu_blue;
	   end  
	else if (gameover | timeout)
	   begin
	       if (gameoveron)
	       begin
	   	   red <= gameover_red;
	       green <= gameover_green;
	       blue <= gameover_blue;
	       end
	       else if (Timeoutd)
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
           else if (grades)
                begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
           else if (ratings)
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
	       else
	       begin
	       red <= 4'h0;
	       green <= 4'h0;
	       blue <= 4'h0;
	       end
	   end 
	else 
	begin    
	    red <= 4'h8;
        green <= 4'h0;
        blue <= 4'h8;
        if (blank) begin
           if ((andsignals[1] | orsignals[1] | notsignals[1] | nerdsignals[1]) && DrawX >= 300 && DrawX <= 500)    //Green Background when dragging
               begin
                   red <= bpalette_red;
                   green <= bpalette_green + 5;
                   blue <= bpalette_blue;
               end
           else    //Normal Background
               begin
                red <= bpalette_red;
                green <= bpalette_green;
                blue <= bpalette_blue;
               end
           if (hpr && DrawX <= 125 && DrawX >= 115 && DrawY <= 112 && DrawY >= 52) //Health bar of the towers
                       begin
                           if (DrawY >= (112 - remainedtwr))
                           begin
                               red <= 4'hD;
                               green <= 4'h3;
                               blue <= 4'h6;
                           end
                           else 
                           begin
                               red <= bpalette_red;
                               green <= bpalette_green;
                               blue <= bpalette_blue;
                           end
                       end
               else if (!hpr && DrawX <= 199 && DrawX >= 100 && DrawY <= 130 && DrawY >= 51)
               begin
                    red <= yeahrred;
                    green <= yeahrgreen;
                    blue <= yeahrblue;
               end
            if (hpl && DrawX <= 125 && DrawX >= 115 && DrawY <= 420 && DrawY >= 360)
                   begin
                       if (DrawY >= (420 - remainedtwl))
                           begin
                           red <= 4'hD;
                           green <= 4'h3;
                           blue <= 4'h6;
                           end
                       else 
                       begin
                           red <= bpalette_red;
                           green <= bpalette_green;
                           blue <= bpalette_blue;
                       end
                   end
               else if (!hpl && DrawX <= 199 && DrawX >= 100 && DrawY <= 430 && DrawY >= 351)
                   begin
                       red <= yeahlred;
                       green <= yeahlgreen;
                       blue <= yeahlblue;
                   end
               
               
               //Division between enemy and our towers
               
               
               
              if (ohpr && DrawX <= 410 && DrawX >= 400 && DrawY <= 112 && DrawY >= 52) //Health bar of the towers
                       begin
                           if (DrawY >= (112 - remainedotwr))
                           begin
                               red <= 4'h6;
                               green <= 4'h3;
                               blue <= 4'hD;
                           end
                           else 
                           begin
                               red <= bpalette_red;
                               green <= bpalette_green;
                               blue <= bpalette_blue;
                           end
                       end
               else if (!ohpr && DrawX <= 439 && DrawX >= 340 && DrawY <= 130 && DrawY >= 51)
               begin
                    red <= norred;
                    green <= norgreen;
                    blue <= norblue;
               end
               if (ohpl && DrawX <= 410 && DrawX >= 400 && DrawY <= 410 && DrawY >= 350)
                   begin
                       if (DrawY >= (410 - remainedotwl))
                           begin
                           red <= 4'h6;
                           green <= 4'h3;
                           blue <= 4'hD;
                           end
                       else 
                       begin
                           red <= bpalette_red;
                           green <= bpalette_green;
                           blue <= bpalette_blue;
                       end
                   end
               else if (!ohpl && DrawX <= 439 && DrawX >= 340 && DrawY <= 430 && DrawY >= 351)
                   begin
                       red <= nolred;
                       green <= nolgreen;
                       blue <= nolblue;
                   end
               if (hpd && DrawX <= 500 && DrawX >= 490 && DrawY <= 269 && DrawY >= 210)
                   begin
                       if (DrawY >= (269 - remainedd))
                           begin
                           red <= 4'h6;
                           green <= 4'h3;
                           blue <= 4'hD;
                           end
                       else 
                       begin
                           red <= bpalette_red;
                           green <= bpalette_green;
                           blue <= bpalette_blue;
                       end
                   end
               else if (!hpd && DrawX <= 539 && DrawX >= 440 && DrawY <= 290 && DrawY >= 191)
                   begin
                       red <= yeahdred;
                       green <= yeahdgreen;
                       blue <= yeahdblue;
                   end
               if (hpc && DrawX <= 80 && DrawX >= 70 && DrawY <= 269 && DrawY >= 210)
                   begin
                       if (DrawY >= (269 - remainedc))
                           begin
                           red <= 4'hD;
                           green <= 4'h3;
                           blue <= 4'h6;
                           end
                       else 
                       begin
                           red <= bpalette_red;
                           green <= bpalette_green;
                           blue <= bpalette_blue;
                       end
                   end
               else if (!hpc && DrawX <= 180 && DrawX >= 101 && DrawY <= 290 && DrawY >= 191)
                   begin
                       red <= yeahcred;
                       green <= yeahcgreen;
                       blue <= yeahcblue;
                   end
           if (timeleft)
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
           if (number) //Timer
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
           if (grades)
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end 
           if (loading)  //Loading Message
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
           if (elion)    //Elixir bar
               begin
                   red <= 4'hc;
                   green <= 4'h2;
                   blue <= 4'hb;
               end
           if (elinum)   //Elixir value
               begin
                   red <= 4'hf;
                   green <= 4'hf;
                   blue <= 4'hf;
               end
           if (and_on)   //and gate
               begin
                   if (and_red == 4'hf && and_green == 4'hf && and_blue == 4'hf)
                   begin
                   end
                   else
                   begin
                   red <= and_red;
                   green <= and_green;
                   blue <= and_blue;
                   end
               end
           if (and_health)   //Health bar of and gate
               begin
                   red <= 4'h6;
                   green <= 4'h3;
                   blue <= 4'hD;
               end
           if (eand_on)   //and gate
               begin
                   if (eand_red == 4'hf && eand_green == 4'hf && eand_blue == 4'hf)
                   begin
                   end
                   else
                   begin
                   red <= eand_red;
                   green <= eand_green;
                   blue <= eand_blue;
                   end
               end
           if (ehealth_on)   //Health bar of and gate
               begin
                   red <= 4'hD;
                   green <= 4'h3;
                   blue <= 4'h6;
               end
           
           if (or_on)   //or gate
               begin
                   if (or_red == 4'hf && or_green == 4'hf && or_blue == 4'hf)
                   begin
                   end
                   else
                   begin
                   red <= or_red;
                   green <= or_green;
                   blue <= or_blue;
                   end
               end
           if (or_health)   //Health bar of and gate
               begin
                   red <= 4'h6;
                   green <= 4'h3;
                   blue <= 4'hD;
               end
           if (eor_on)   //and gate
               begin
                   if (eor_red == 4'hf && eor_green == 4'hf && eor_blue == 4'hf)
                   begin
                   end
                   else
                   begin
                   red <= eor_red;
                   green <= eor_green;
                   blue <= eor_blue;
                   end
               end
           if (eorhealth_on)   //Health bar of and gate
               begin
                   red <= 4'hD;
                   green <= 4'h3;
                   blue <= 4'h6;
               end
           if (not_on)   //or gate
               begin
                   if (not_red == 4'hf && not_green == 4'hf && not_blue == 4'hf)
                   begin
                   end
                   else
                   begin
                   red <= not_red;
                   green <= not_green;
                   blue <= not_blue;
                   end
               end
           if (not_health)   //Health bar of and gate
               begin
                   red <= 4'h6;
                   green <= 4'h3;
                   blue <= 4'hD;
               end
           if (nerd_on)   //or gate
               begin
                   if (nerd_red == 4'h1 && nerd_green == 4'hb && nerd_blue == 4'h4)
                   begin
                   end
                   else
                   begin
                   red <= nerd_red;
                   green <= nerd_green;
                   blue <= nerd_blue;
                   end
               end
           if (nerd_health)   //Health bar of and gate
               begin
                   red <= 4'h6;
                   green <= 4'h3;
                   blue <= 4'hD;
               end
           if (enerd_on)   //or gate
               begin
                   if (enerd_red == 4'h1 && enerd_green == 4'hb && enerd_blue == 4'h4)
                   begin
                   end
                   else
                   begin
                   red <= enerd_red;
                   green <= enerd_green;
                   blue <= enerd_blue;
                   end
               end
           if (enerdhealth_on)   //Health bar of and gate
               begin
                   red <= 4'hD;
                   green <= 4'h3;
                   blue <= 4'h6;
               end
    	   if (arrowl && (DrawX >= 10'd130) && (DrawX <= 10'd170) && (DrawY <= 10'd405) && (DrawY >= 10'd395))  //left tower arrow
    	       begin
    	       	   red <= 4'hf;
    	           green <= 4'h0;
    	           blue <= 4'h0;
    	       end
    	   if (arrowr && (DrawX >= 10'd130) && (DrawX <= 10'd170) && (DrawY <= 10'd85) && (DrawY >= 10'd75))  //right tower arrow
    	       begin
    	       	   red <= 4'hf;
    	           green <= 4'h0;
    	           blue <= 4'h0;
    	       end
    	   if (arrowc && (DrawX >= 10'd80) && (DrawX <= 10'd120) && (DrawY <= 10'd245) && (DrawY >= 10'd235))  //king tower arrow
    	       begin
    	       	   red <= 4'hf;
    	           green <= 4'h0;
    	           blue <= 4'h0;
    	       end
    	   if (oarrowr && (DrawX >= 10'd380) && (DrawX <= 10'd420) && (DrawY <= 10'd85) && (DrawY >= 10'd75))  
    	       begin
    	       	   red <= 4'h0;
    	           green <= 4'h0;
    	           blue <= 4'hf;
    	       end
    	   if (oarrowl && (DrawX >= 10'd380) && (DrawX <= 10'd420) && (DrawY <= 10'd405) && (DrawY >= 10'd395))  
    	       begin
    	       	   red <= 4'h0;
    	           green <= 4'h0;
    	           blue <= 4'hf;
    	       end
    	   if (arrowd && (DrawX >= 10'd420) && (DrawX <= 10'd460) && (DrawY <= 10'd245) && (DrawY >= 10'd235))  
    	       begin
    	       	   red <= 4'h0;
    	           green <= 4'h0;
    	           blue <= 4'hf;
    	       end
           if (andnameon)
               begin
                    red <= 4'hf;
                    green <= 4'hf;
                    blue <= 4'hf;
               end
           else if (ornameon)
               begin
                    red <= 4'hf;
                    green <= 4'hf;
                    blue <= 4'hf;
               end
            else if (notnameon)
               begin
                    red <= 4'hf;
                    green <= 4'hf;
                    blue <= 4'hf;
               end
           else if (nerdnameon)
               begin
                    red <= 4'hf;
                    green <= 4'hf;
                    blue <= 4'hf;
               end
    //		red <= zuofu_palette_red;
    //		green <= zuofu_palette_green;
    //		blue <= zuofu_palette_blue;
        end
    end
end

logic[3:0] gameover_red, gameover_green, gameover_blue;
game_over_example gameover_example(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .red(gameover_red),
    .green(gameover_green),
    .blue(gameover_blue),
    .gameoveron(gameoveron)
);

logic[3:0] zuofu_red, zuofu_green, zuofu_blue;
zuofu_example zuofu_example(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .red(zuofu_red),
    .green(zuofu_green),
    .blue(zuofu_blue)
);


battlefield_rom battlefield_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_b)
);

battlefield_palette battlefield_palette (
	.index (rom_b),
	.red   (bpalette_red),
	.green (bpalette_green),
	.blue  (bpalette_blue)
);
//Towers
//Left Tower
always_comb
begin
    case (tattackindex)
        3'd3: begin
        attacktand = 1;
        attacktor = 0;
        attacktnerd = 0;
        end
        3'd4: begin
        attacktor = 1;
        attacktand = 0;
        attacktnerd = 0;
        end
        3'd6: begin
        attacktor = 0;
        attacktand = 0;
        attacktnerd = 1;
        end
        default: begin
        attacktand = 0;
        attacktor = 0;
        attacktnerd = 0;
        end
    endcase
end
logic [2:0] tattackindex;
logic [5:0] hpl;
logic arrowl;
logic [3:0] damageandl, damageorl, damagenotl, damagenerdl;
tower lefttower(
    .clk(vsync),
    .vga_clk(vga_clk),
    .reset(~background | gameover),
    .towerX(10'd150),
    .towerY(10'd400),
    .andX(andX),
    .andY(andY),
    .orX(orX),
    .orY(orY),
    .nerdX(nerdX),
    .nerdY(nerdY),
    .damageand(damageandl),
    .damageor(damageorl),
    .damagenerd(damagenerdl),
    .attackindex(tattackindex),
    .arrowon(arrowl),
    .thp(hpl)
);

//Right Tower
always_comb
begin
    case (rtattackindex)
        3'd3: begin
        attackrtand = 1;
        attackrtor = 0;
        attackrtnerd = 0;
        end
        3'd4: begin
        attackrtor = 1;
        attackrtand = 0;
        attackrtnerd = 0;
        end
        3'd6: begin
        attackrtor = 0;
        attackrtand = 0;
        attackrtnerd = 1;
        end
        default: begin
        attackrtand = 0;
        attackrtor = 0;
        attackrtnerd = 0;
        end
    endcase
end
logic [2:0] rtattackindex;
logic [5:0] hpr;
logic arrowr;
logic [3:0] damageandr, damageorr, damagenotr, damagenerdr;
tower righttower(
    .clk(vsync),
    .vga_clk(vga_clk),
    .reset(~background | gameover),
    .towerX(10'd150),
    .towerY(10'd80),
    .andX(andX),
    .andY(andY),
    .orX(orX),
    .orY(orY),
    .nerdX(nerdX),
    .nerdY(nerdY),
    .damageand(damageandr),
    .damageor(damageorr),
    .damagenerd(damagenerdr),
    .attackindex(rtattackindex),
    .arrowon(arrowr),
    .thp(hpr)
);

//Destroyed Tower
logic[3:0] yeahrred, yeahrgreen, yeahrblue;
yeah_example yeahr(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .X(10'd100),
    .Y(10'd51),
    .red(yeahrred),
    .green(yeahrgreen),
    .blue(yeahrblue)
);

logic[3:0] yeahlred, yeahlgreen, yeahlblue;

yeah_example yeahl(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .X(10'd100),
    .Y(10'd351),
    .red(yeahlred),
    .green(yeahlgreen),
    .blue(yeahlblue)
);

//King
logic [2:0] attackdtand,attackdtor, attackdtnerd;
always_comb
begin
    case (dtattackindex)
        3'd3: begin
        attackdtand = 1;
        attackdtor = 0;
        attackdtnerd = 0;
        end
        3'd4: begin
        attackdtor = 1;
        attackdtand = 0;
        attackdtnerd = 0;
        end
        3'd6: begin
        attackdtor = 0;
        attackdtand = 0;
        attackdtnerd = 1;
        end
        default: begin
        attackdtand = 0;
        attackdtor = 0;
        attackdtnerd = 0;
        end
    endcase
end
logic [2:0] dtattackindex;
logic [5:0] hpd;
logic arrowd;
logic [3:0] damageandd, damageord, damagenotd, damagenerdd;
tower king(
    .clk(vsync),
    .vga_clk(vga_clk),
    .reset(~background),
    .towerX(10'd440),
    .towerY(10'd240),
    .andX(eandX),
    .andY(eandY),
    .orX(eorX),
    .orY(eorY),
    .nerdX(enerdX),
    .nerdY(enerdY),
    .damageand(damageandd),
    .damageor(damageord),
    .damagenerd(damagenerdd),
    .attackindex(dtattackindex),
    .arrowon(arrowd),
    .thp(hpd)
);

//Destroyed Tower
logic[3:0] yeahdred, yeahdgreen, yeahdblue;
oops_example death(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .X(10'd440),
    .Y(10'd208),
    .red(yeahdred),
    .green(yeahdgreen),
    .blue(yeahdblue)
);

////Zuofu
logic [2:0] attackctand,attackctor,attackctnerd;
always_comb
begin
    case (ctattackindex)
        3'd3: begin
        attackctand = 1;
        attackctor = 0;
        attackctnerd = 0;
        end
        3'd4: begin
        attackctor = 1;
        attackctand = 0;
        attackctnerd = 0;
        end
        3'd6: begin
        attackctor = 0;
        attackctand = 0;
        attackctnerd = 1;
        end
        default: begin
        attackctand = 0;
        attackctor = 0;
        attackctnerd = 0;
        end
    endcase
end
logic [2:0] ctattackindex;
logic [5:0] hpc;
logic arrowc;
logic [3:0] damageandc, damageorc, damagenotc, damagenerdc;
tower zuofu(
    .clk(vsync),
    .vga_clk(vga_clk),
    .reset(~background),
    .towerX(10'd100),
    .towerY(10'd240),
    .andX(andX),
    .andY(andY),
    .orX(orX),
    .orY(orY),
    .nerdX(nerdX),
    .nerdY(nerdY),
    .damageand(damageandc),
    .damageor(damageorc),
    .damagenerd(damagenerdc),
    .attackindex(ctattackindex),
    .arrowon(arrowc),
    .thp(hpc)
);

//Destroyed Tower
logic[3:0] yeahcred, yeahcgreen, yeahcblue;
yeah_example goodbyezuofu(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .X(10'd80),
    .Y(10'd208),
    .red(yeahcred),
    .green(yeahcgreen),
    .blue(yeahcblue)
);


//Our Tower

always_comb
begin
    case (otattackindex)
        3'd3: begin
        attackteand = 1;
        attackteor = 0;
        attacktenerd = 0;
        end
        3'd4: begin
        attackteor = 1;
        attackteand = 0;
        attacktenerd = 0;
        end
        3'd6:begin
        attackteand = 0;
        attackteor = 0;
        attacktenerd = 1;
        end
        default: begin
        attackteand = 0;
        attackteor = 0;
        attacktenerd = 0;
        end
    endcase
end
logic [2:0] otattackindex;
logic [5:0] ohpl;
logic oarrowl;
logic [3:0] odamageandl, odamageorl, odamagenotl, odamagenerdl;
tower ourltower(
    .clk(vsync),
    .vga_clk(vga_clk),
    .reset(~background | gameover),
    .towerX(10'd400),
    .towerY(10'd400),
    .andX(eandX),
    .andY(eandY),
    .orX(eorX),
    .orY(eorY),
    .nerdX(enerdX),
    .nerdY(enerdY),
    .damageand(odamageandl),
    .damageor(odamageorl),
    .damagenerd(odamagenerdl),
    .attackindex(otattackindex),
    .arrowon(oarrowl),
    .thp(ohpl)
);

logic [2:0] ortattackindex;
logic [5:0] ohpr;
logic oarrowr;
logic [3:0] odamageandr, odamageorr, odamagenotr, odamagenerdr;

always_comb
begin
    case (ortattackindex)
        3'd3: begin
        attackrteand = 1;
        attackrteor = 0;
        attackrtenerd = 0;
        end
        3'd4: begin
        attackrteor = 1;
        attackrteand = 0;
        attackrtenerd = 0;
        end
        3'd6: begin
        attackrteor = 0;
        attackrteand = 0;
        attackrtenerd = 1;
        end
        default: begin
        attackrteand = 0;
        attackrteor = 0;
        attackrtenerd = 0;
        end
    endcase
end

tower ourrtower(
    .clk(vsync),
    .vga_clk(vga_clk),
    .reset(~background | gameover),
    .towerX(10'd400),
    .towerY(10'd80),
    .andX(eandX),
    .andY(eandY),
    .orX(eorX),
    .orY(eorY),
    .nerdX(enerdX),
    .nerdY(enerdY),
    .damageand(odamageandr),
    .damageor(odamageorr),
    .damagenerd(odamagenerdr),
    .attackindex(ortattackindex),
    .arrowon(oarrowr),
    .thp(ohpr)
);

logic[3:0] norred, norgreen, norblue;
oops_example oopsr(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .X(10'd439),
    .Y(10'd51),
    .red(norred),
    .green(norgreen),
    .blue(norblue)
);

logic[3:0] nolred, nolgreen, nolblue;
oops_example oopsl(
    .vga_clk(vga_clk),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .X(10'd439),
    .Y(10'd351),
    .red(nolred),
    .green(nolgreen),
    .blue(nolblue)
);

//Logic for detecting if the towers are dead or not
logic towerrd, towerld;
always_comb
begin
    if (hpr)
        towerrd = 0;
    else
        towerrd = 1;
    if (hpl)
        towerld = 0;
    else
        towerld = 1;
end

logic otowerrd, otowerld;
always_comb
begin
    if (ohpr)
        otowerrd = 0;
    else
        otowerrd = 1;
    if (ohpl)
        otowerld = 0;
    else
        otowerld = 1;
end


//Units:
//#1 AND Gate
logic [3:0] and_red, and_green, and_blue, andattackindex;
logic [9:0] andX, andY;
logic [2:0] attacktand, attackrtand, attackeandand, attackandeand, attackeorand;
logic and_on, and_health;
always_comb
begin
    case (andattackindex)
        4'd1: 
        begin
        damageandr = 1;
        damageandl = 0;
        damageandc = 0;
        attackandeand = 0;
        attackandeor = 0;
        attackandenerd = 0;
        end
        4'd2: 
        begin
        damageandl = 1;
        damageandr = 0;
        damageandc = 0;
        attackandeand = 0;
        attackandeor = 0;
        attackandenerd = 0;
        end
        4'd3:
        begin
        damageandl = 0;
        damageandr = 0;
        damageandc = 0;
        attackandeand = 1;
        attackandeor = 0;
        attackandenerd = 0;
        end
        4'd4:
        begin
        damageandr = 0;
        damageandl = 0;
        damageandc = 0;
        attackandeand = 0;
        attackandeor = 1;
        attackandenerd = 0;
        end
        4'd6:
        begin
        damageandr = 0;
        damageandl = 0;
        damageandc = 0;
        attackandeand = 0;
        attackandeor = 0;
        attackandenerd = 1;
        end
        4'd7:
        begin
        damageandr = 0;
        damageandl = 0;
        damageandc = 1;
        attackandeand = 0;
        attackandeor = 0;
        attackandenerd = 0;
        end
        default: 
        begin
        damageandr = 0;
        damageandl = 0;
        damageandc = 0;
        attackandeand = 0;
        attackandeor = 0;
        attackandenerd = 0;
        end
    endcase
end

and_gate_example and_gate(
    .vga_clk(vga_clk),
    .reset(reset),
    .vsync(vsync),
    .towerrd(towerrd),
    .towerld(towerld),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .andX(eandX),
    .andY(eandY),
    .orX(eorX),
    .orY(eorY),
    .nerdX(enerdX),
    .nerdY(enerdY),
    .instatein(andsignals[1]),
    .deployin(andsignals[0]),
    .idlein(andsignals[2] | gameover | timeout),
    .MouseX(MouseX),
    .MouseY(MouseY),
    .enable(and_on),
    .infield(andinfield),
    .health(and_health),
    .X(andX),
    .Y(andY),
    .attackindex(andattackindex),
    .attackt(attacktand),
    .attackrt(attackrtand),
    .attackc(attackctand),
    .attackeand(attackeandand),
    .attackeor(attackeorand),
    .red(and_red),
    .green(and_green),
    .blue(and_blue)
);

//Unit2 : Or Gate

logic [3:0] or_red, or_green, or_blue, orattackindex;
logic [9:0] orX, orY;
logic [2:0] attacktor, attackrtor;
logic or_on, or_health;
always_comb
begin
    case (orattackindex)
        4'd1: 
        begin
        damageorr = 2;
        damageorl = 0;
        damageorc = 0;
        attackoreand = 0;
        attackoreor = 0;
        attackorenerd = 0;
        end
        4'd2: 
        begin
        damageorl = 2;
        damageorr = 0;
        damageorc = 0;
        attackoreand = 0;
        attackoreor = 0;
        attackorenerd = 0;
        end
        4'd3: 
        begin
        damageorl = 0;
        damageorr = 0;
        damageorc = 0;
        attackoreand = 2;
        attackoreor = 0;
        attackorenerd = 0;
        end
        4'd4: 
        begin
        damageorl = 0;
        damageorr = 0;
        damageorc = 0;
        attackoreand = 0;
        attackoreor = 2;
        attackorenerd = 0;
        end
        4'd6:
        begin
        damageorl = 0;
        damageorr = 0;
        damageorc = 0;
        attackoreand = 0;
        attackoreor = 0;
        attackorenerd = 2;
        end
        4'd7: 
        begin
        damageorl = 0;
        damageorr = 0;
        damageorc = 2;
        attackoreand = 0;
        attackoreor = 0;
        attackorenerd = 0;
        end
        default: 
        begin
        damageorr = 0;
        damageorl = 0;
        damageorc = 0;
        attackoreand = 0;
        attackoreor = 0;
        attackorenerd = 0;
        end
    endcase
end

//Or gate
or_gate_example or_gate(
    .vga_clk(vga_clk),
    .reset(reset),
    .vsync(vsync),
    .towerrd(towerrd),
    .towerld(towerld),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .instatein(orsignals[1]),
    .deployin(orsignals[0]),
    .idlein(orsignals[2] | gameover | timeout),
    .MouseX(MouseX),
    .MouseY(MouseY),
    .enable(or_on),
    .infield(orinfield),
    .health(or_health),
    .X(orX),
    .Y(orY),
    .andX(eandX),
    .andY(eandY),
    .orX(eorX),
    .orY(eorY),
    .nerdX(enerdX),
    .nerdY(enerdY),
    .attackindex(orattackindex),
    .attackt(attacktor),
    .attackrt(attackrtor),
    .attackc(attackctor),
    .attackeand(attackeandor),
    .attackeor(attackeoror),
    .red(or_red),
    .green(or_green),
    .blue(or_blue)
);


logic [3:0] not_red, not_green, not_blue, notattackindex;
logic [9:0] notX, notY;
logic [2:0] attacktnot, attackrtnot;
logic not_on, not_health;
always_comb
begin
    case (notattackindex)
        4'd1: 
        begin
        damagenotr = 1;
        damagenotl = 0;
        end
        4'd2: 
        begin
        damagenotl = 2;
        damagenotr = 0;
        end
        default: 
        begin
        damagenotr = 0;
        damagenotl = 0;
        end
    endcase
end

//Not gate
not_gate_example not_gate(
    .vga_clk(vga_clk),
    .reset(reset),
    .vsync(vsync),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .towerrd(towerrd),
    .towerld(towerld),
    .andX(eandX),
    .andY(eandY),
    .orX(eorX),
    .orY(eorY),
    .instatein(notsignals[1]),
    .deployin(notsignals[0]),
    .idlein(notsignals[2] | gameover | timeout),
    .MouseX(MouseX),
    .MouseY(MouseY),
    .enable(not_on),
    .infield(notinfield),
    .health(not_health),
    .X(notX),
    .Y(notY),
    .attackindex(notattackindex),
    .attackt(attacktnot),
    .attackrt(attackrtnot),
    .attackand(attackeandnot),
    .attackor(attackeandor),
    .red(not_red),
    .green(not_green),
    .blue(not_blue)
);

//Nerd

logic [3:0] nerd_red, nerd_green, nerd_blue, nerdattackindex;
logic [9:0] nerdX, nerdY;
logic [2:0] attacktnerd, attackrtnerd, attackeandnerd, attackeornerd;
logic nerd_on, nerd_health;
always_comb
begin
    case (nerdattackindex)
        4'd1: 
        begin
        damagenerdr = 2;
        damagenerdl = 0;
        damagenerdc = 0;
        end
        4'd2: 
        begin
        damagenerdl = 2;
        damagenerdr = 0;
        damagenerdc = 0;
        end
        4'd7: 
        begin
        damagenerdl = 0;
        damagenerdr = 0;
        damagenerdc = 2;
        end
        default: 
        begin
        damagenerdr = 0;
        damagenerdl = 0;
        damagenerdc = 0;
        end
    endcase
end
nerd_example nerd(
    .vga_clk(vga_clk),
    .reset(reset),
    .vsync(vsync),
    .towerrd(towerrd),
    .towerld(towerld),
    .DrawX(DrawX),
    .DrawY(DrawY),
    .instatein(nerdsignals[1]),
    .deployin(nerdsignals[0]),
    .idlein(nerdsignals[2] | gameover | timeout),
    .MouseX(MouseX),
    .MouseY(MouseY),
    .enable(nerd_on),
    .infield(nerdinfield),
    .health(nerd_health),
    .X(nerdX),
    .Y(nerdY),
    .attackindex(nerdattackindex),
    .attackt(attacktnerd),
    .attackrt(attackrtnerd),
    .attackc(attackctnerd),
    .attackand(attackeandnerd),
    .attackor(attackeornerd),
    .red(nerd_red),
    .green(nerd_green),
    .blue(nerd_blue)
);

//enemy units
logic nerdleft, nerdright;

logic [9:0] eandX, eandY;
logic andleft, andright, eand_on, ehealth_on;
logic [3:0] eand_red, eand_green, eand_blue;
logic [2:0] eandindex,attackteand, attackrteand, attackoreand, attackeandor, attackeandnot;
always_comb
begin
if (andX!= 0 && andX <= 280 && andY >= 240)
    begin
        andleft = 1;
        andright = 0;
    end
else if (andX != 0 && andX <= 280 && andY <= 239)
    begin
        andright = 1;
        andleft = 0;
    end 
else
    begin
        andright = 0;
        andleft = 0;
    end
if (nerdX != 0 && nerdX <= 280 && nerdY >= 240)
    begin
        nerdleft = 1;
        nerdright = 0;
    end
else if (nerdX != 0 && nerdX <= 280 && nerdY <= 239)
    begin
        nerdright = 1;
        nerdleft = 0;
    end
else
    begin
        nerdleft = 0;
        nerdright = 0;
    end
case(eandindex)
    3'd1: begin
    attackeandand = 0;
    odamageandr = 1;
    odamageandl = 0;
    attackeandor = 0;
    damageandd = 0;
    attackeandnerd = 0;
    attackeandnot = 0;
    end
    3'd2: begin
    attackeandand = 0;
    odamageandr = 0;
    odamageandl = 1;
    attackeandor = 0;
    damageandd = 0;
    attackeandnerd = 0;
    attackeandnot = 0;
    end
    3'd3: begin
    attackeandand = 1;
    odamageandr = 0;
    odamageandl = 0;
    attackeandor = 0;
    damageandd = 0;
    attackeandnerd = 0;
    attackeandnot = 0;
    end
    3'd4:
    begin
    attackeandand = 0;
    odamageandr = 0;
    odamageandl = 0;
    attackeandor = 1;
    damageandd = 0;
    attackeandnerd = 0;
    attackeandnot = 0;
    end
    3'd5:
    begin
    attackeandand = 0;
    odamageandr = 0;
    odamageandl = 0;
    attackeandor = 0;
    damageandd = 0;
    attackeandnerd = 0;
    attackeandnot = 1;
    end
    3'd6:begin
    attackeandand = 0;
    odamageandr = 0;
    odamageandl = 0;
    attackeandor = 0;
    damageandd = 0;
    attackeandnerd = 1;
    attackeandnot = 0;
    end
    3'd7:begin
    attackeandand = 0;
    odamageandr = 0;
    odamageandl = 0;
    attackeandor = 0;
    damageandd = 1;
    attackeandnerd = 0;
    attackeandnot = 0;
    end
    default: begin
    attackeandand = 0;
    odamageandr = 0;
    odamageandl = 0;
    attackeandor = 0;
    damageandd = 0;
    attackeandnerd = 0;
    attackeandnot = 0;
    end
endcase
end
and_spawn enemyspawn (
	.vga_clk(vga_clk),
	.vsync(vsync),
	.reset(~background | gameover | timeout),
	.towerrd(otowerrd),
	.towerld(otowerld),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.andX(andX),
	.andY(andY),
	.orX(orX),
	.orY(orY),
    .nerdX(nerdX),
	.nerdY(nerdY),
    .notX(notX),
	.notY(notY),
	.left(andleft),
	.nerdleft(nerdleft),
	.nerdright(nerdright),
	.right(andright),
	.red(eand_red),
	.green(eand_green),
	.blue(eand_blue),
	.enable(eand_on),
	.health(ehealth_on),
	.attackindex(eandindex),
	.attackt(attackteand),
	.attackc(attackdtand),
	.attackrt(attackrteand),
	.attackand(attackandeand),
	.attackor(attackoreand),
	.X(eandX),
	.Y(eandY)
);

logic [9:0] eorX, eorY;
logic orleft, orright, eor_on, eorhealth_on;
logic [3:0] eor_red, eor_green, eor_blue;
logic [2:0] eorindex, attackteor, attackrteor, attackandeor, attackoreor, attackeoror, attackeornot;
always_comb
begin
if (orX != 0 && orX <= 280 && orY >= 240)
    begin
        orleft = 1;
        orright = 0;
    end
else if (orX != 0 && orX <= 280 && orY <= 239)
    begin
        orright = 1;
        orleft = 0;
    end 
else
    begin
        orright = 0;
        orleft = 0;
    end
case(eorindex)
    3'd1: begin
    attackeorand = 0;
    odamageorr = 2;
    odamageorl = 0;
    attackeoror = 0;
    damageord = 0;
    attackeornerd = 0;
    attackeornot = 0;
    end
    3'd2: begin
    attackeorand = 0;
    odamageorr = 0;
    odamageorl = 2;
    attackeoror = 0;
    damageord = 0;
    attackeornerd = 0;
    attackeornot = 0;
    end
    3'd3: begin
    attackeorand = 2;
    odamageorr = 0;
    odamageorl = 0;
    attackeoror = 0;
    attackeornerd = 0;
    damageord = 0;
    attackeornot = 0;
    end
    3'd4: begin
    attackeorand = 0;
    odamageorr = 0;
    odamageorl = 0;
    attackeoror = 2;
    attackeornerd = 0;
    damageord = 0;
    attackeornot = 0;
    end
    3'd5: begin
    attackeorand = 0;
    odamageorr = 0;
    odamageorl = 0;
    attackeoror = 0;
    attackeornerd = 0;
    damageord = 0;
    attackeornot = 2;
    end
    3'd6: begin
    attackeorand = 0;
    odamageorr = 0;
    odamageorl = 0;
    attackeoror = 0;
    attackeornerd = 2;
    damageord = 0;
    attackeornot = 0;
    end
    3'd7: begin
    attackeorand = 0;
    odamageorr = 0;
    odamageorl = 0;
    attackeoror = 0;
    damageord = 2;
    attackeornerd = 0;
    attackeornot = 0;
    end
    default: begin
    attackeorand = 0;
    odamageorr = 0;
    odamageorl = 0;
    attackeoror = 0;
    damageord = 0;
    attackeornerd = 0;
    attackeornot = 0;
    end
endcase
end
or_spawn eorspawn (
	.vga_clk(vga_clk),
	.vsync(vsync),
	.reset(~background | gameover | timeout),
	.towerrd(otowerrd),
	.towerld(otowerld),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.andX(andX),
	.andY(andY),
	.orX(orX),
	.orY(orY),
	.nerdX(nerdX),
	.nerdY(nerdY),
	.notX(notX),
	.notY(notY),
    .nerdleft(nerdleft),
	.nerdright(nerdright),
	.left(orleft),
	.right(orright),
	.red(eor_red),
	.green(eor_green),
	.blue(eor_blue),
	.enable(eor_on),
	.health(eorhealth_on),
	.attackindex(eorindex),
	.attackt(attackteor),
	.attackrt(attackrteor),
	.attackc(attackdtor),
	.attackand(attackandeor),
	.attackor(attackoreor),
	.X(eorX),
	.Y(eorY)
);

logic [9:0] enerdX, enerdY;
logic enerd_on, enerdhealth_on;
logic [3:0] enerd_red, enerd_green, enerd_blue;
logic [2:0] enerdindex, attacktenerd, attackrtenerd, attackandenerd, attackorenerd;
always_comb
begin
case(enerdindex)
    3'd1: begin
    odamagenerdr = 2;
    odamagenerdl = 0;
    damagenerdd = 0;
    end
    3'd2: begin
    odamagenerdr = 0;
    odamagenerdl = 2;
    damagenerdd = 0;
    end
    3'd7: begin
    odamagenerdr = 0;
    odamagenerdl = 0;
    damagenerdd = 2;
    end
    default: begin
    odamagenerdr = 0;
    odamagenerdl = 0;
    damagenerdd = 0;
    end
endcase
end
nerd_spawn enerdspawn (
	.vga_clk(vga_clk),
	.vsync(vsync),
	.reset(~background | gameover | timeout),
	.towerrd(otowerrd),
	.towerld(otowerld),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.on(background && !(andinfield | orinfield | nerdinfield)),
	.hpr(ohpr),
	.hpl(ohpl),
	.red(enerd_red),
	.green(enerd_green),
	.blue(enerd_blue),
	.enable(enerd_on),
	.health(enerdhealth_on),
	.attackindex(enerdindex),
	.attackt(attacktenerd),
	.attackrt(attackrtenerd),
	.attackc(attackdtnerd),
	.attackand(attackandenerd),
	.attackor(attackorenerd),
	.X(enerdX),
	.Y(enerdY)
);
endmodule
