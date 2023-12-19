
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 10:44:04 PM
// Design Name: 
// Module Name: 2_input_mux
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


module four_bit_mux(
                        input				S,
						input				[3:0] A_in,
						input 				[3:0] B_in,
						output logic		[3:0] Q_out
    );
    always_comb
	begin
		unique case(S)
			1'b0	:	Q_out = {1'b0, A_in};
			1'b1	:	Q_out = B_in;
		endcase
	end
endmodule
