`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 08:41:24 PM
// Design Name: 
// Module Name: regZ
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


module regP(
    input Clk,Reset,LD_CC,
	input logic[15:0] first,
    output logic Dout
    );
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			Dout <= 1'b0;
		else if (LD_CC == 1'b1 && first[15] == 1'b0 && first != 16'b0)
			Dout <= 1'b1;
		else if (LD_CC == 1'b1 && (first[15] != 1'b0 || first == 16'b0))
		    Dout <= 1'b0;
	end
endmodule
