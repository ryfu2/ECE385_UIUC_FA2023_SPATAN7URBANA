`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 09:10:35 PM
// Design Name: 
// Module Name: regBen
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


module regBen(
    input Clk,Reset,LD_BEN,IR_11,IR_10,IR_9,N,Z,P,
    output logic Dout
    );
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			Dout <= 1'b0;
		else if (LD_BEN == 1'b1)
			Dout <= (IR_11 && N) + (IR_10 && Z) + (IR_9 && P);
        else 
            Dout = 1'b0;
	end
endmodule
