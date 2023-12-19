`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 04:28:30 PM
// Design Name: 
// Module Name: nine_bit_adder
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


module nine_bits_adder(
    input logic [7:0] A,B,
    input logic sub_enable,add_enable,Xin,
    output logic[7:0] S,
    output X
    );
    logic [8:0] Acopy,Bcopy,Outa,Outs;
    logic [7:0] Scopy;
    logic Xcopy;
    assign Acopy = {A[7], A[7:0]};
    assign Bcopy = {B[7], B[7:0]};
    ripple_adder adder0(.A(Acopy), .B(Bcopy), .cin(1'b0), .S(Outa));
    ripple_adder adder1(.A(Acopy), .B(~Bcopy), .cin(1'b1), .S(Outs));
    always_comb
    begin
        if (sub_enable == 1'b0 && add_enable == 1'b1)
            begin
            Xcopy = Outa[8];
            Scopy = Outa[7:0];
            end
        else if (sub_enable == 1'b1)
            begin
            Xcopy = Outs[8];
            Scopy = Outs[7:0];
            end    
        else 
            begin
            Xcopy = 1'b0;
            Scopy = Acopy[7:0];
            end
    end
    assign S = Scopy;
    assign X = Xcopy;
    
    
endmodule
