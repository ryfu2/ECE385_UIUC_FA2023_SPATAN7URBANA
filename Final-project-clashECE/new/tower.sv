`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2023 10:32:23 PM
// Design Name: 
// Module Name: tower
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


module  tower ( 
input  logic clk,
input  logic vga_clk,
input  logic reset,
input  logic [9:0] towerX, towerY,
input  logic [9:0] andX, andY, orX, orY, nerdX, nerdY,
input  logic [3:0] damageand,damageor,damagenerd,
output logic arrowon,
output logic [5:0] thp,
output logic[2:0] attackindex);
    
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	 logic [9:0] targetX, targetY;
	 logic [2:0] index;
	  range andrange(
.Clk(vga_clk),
.reset(reset),
.X(towerX),
.Y(towerY),
.andX(andX),
.andY(andY),
.orX(orX),
.orY(orY),
.notX(0),
.notY(0),
.nerdX(nerdX),
.nerdY(nerdY),
.zuofuX(0),
.zuofuY(0),
.towerlX(0),
.towerrX(0),
.towerlY(0),
.towerrY(0),
.targetX(targetX),
.targetY(targetY),
.index(index)
);
    int DistandX, DistandY, Size;
    logic [5:0] increment;
    assign DistandX = targetX - towerX;
    assign DistandY = targetY - towerY;
    assign Size = 100;
    logic [3:0] damage;
    logic [5:0] hp; 
    assign damage = damageand + damageor + damagenerd;
    assign thp = hp;
    always_ff @ (posedge clk)
    begin:Ball_on_proc
        if (hp >= damage)
            hp <= hp - damage;
        else
            hp <= 0;
        if (reset)
        begin
            increment <= 0;
            arrowon <= 0;
            attackindex <= 3'b0;
            hp <= 6'd30;
        end
        if (hp == 0)
        begin
            arrowon <= 0;
            attackindex <= 3'b0;
        end
        else
        begin
            if (increment <= 60)
            begin
                increment <= increment + 1;
                attackindex <= 3'b0;
                arrowon <= 0;
            end
            else 
            begin
                increment <= 0;
                begin
                if ((DistandX * DistandX + DistandY * DistandY) <= (Size * Size))
                    begin
                    attackindex <= index;
                    arrowon <= 1;
                    end
                else 
                    begin
                    attackindex <= 3'b0;
                    arrowon <= 0;
                    end
                end
            end
         end 
     end
endmodule
