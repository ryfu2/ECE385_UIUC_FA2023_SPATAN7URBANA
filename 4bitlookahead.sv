`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 09:09:06 PM
// Design Name: 
// Module Name: 4bitlookahead
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


module fourbitlookahead(
    input [3:0] X,Y,
    input cin,
    output logic[3:0] S,
    output Pout,Gout
    );
    
    logic[3:0] P,G;
    logic[3:0] cpro;
    assign P = X^Y;
    assign G = X&Y;
    assign cpro[0] = cin;
    full_adder FA0(.x(X[0]), .y(Y[0]), .z(cin), .s(S[0]), .c());
    assign cpro[1] = (cin&P[0])|G[0];
    full_adder FA1(.x(X[1]), .y(Y[1]), .z(cpro[1]), .s(S[1]), .c());
    assign cpro[2] = (cpro[1]&P[1])|G[1];
    full_adder FA2(.x(X[2]), .y(Y[2]), .z(cpro[2]), .s(S[2]), .c());
    assign cpro[3] = (cpro[2]&P[2])|G[2];
    full_adder FA3(.x(X[3]), .y(Y[3]), .z(cpro[3]), .s(S[3]), .c());
    assign Pout = P[0]&P[1]&P[2]&P[3];
    assign Gout = G[3] | (G[2]&P[3]) | (G[1]&P[3]&P[2]) | (G[0]&P[3]&P[2]&P[1]);
endmodule
