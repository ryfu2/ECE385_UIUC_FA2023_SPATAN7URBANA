module select_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

    /* TODO
     *
     * Insert code here to implement a CSA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
    //Level 1
    logic c1;
    fourbitsfulladder fbfa0 (.x(A[3:0]) ,.y(B[3:0]) ,.z(cin) ,.s(S[3:0]) ,.c(c1));
    
    
    //Level 2
    logic[3:0] Stz,Sto;
    logic c2z,c2o;
    fourbitsfulladder fbfa1z (.x(A[7:4]) ,.y(B[7:4]) ,.z(1'b0) ,.s(Stz[3:0]) ,.c(c2z));
    fourbitsfulladder fbfa1o (.x(A[7:4]) ,.y(B[7:4]) ,.z(1'b1) ,.s(Sto[3:0]) ,.c(c2o));
    four_bit_mux mux0 (.S(c1), .A_in(Stz) ,.B_in(Sto), .Q_out(S[7:4]));
    logic c2;
    assign c2 = (c2o&c1)|c2z;
    
    
    //Level 3
    logic c3z,c3o;
    logic[3:0] Stz1,Sto1;
    fourbitsfulladder fbfa2z (.x(A[11:8]) ,.y(B[11:8]) ,.z(1'b0) ,.s(Stz1[3:0]) ,.c(c3z));
    fourbitsfulladder fbfa2o (.x(A[11:8]) ,.y(B[11:8]) ,.z(1'b1) ,.s(Sto1[3:0]) ,.c(c3o));
    assign c3 = (c3o&c2)|c3z;
    four_bit_mux mux1 (.S(c2), .A_in(Stz1) ,.B_in(Sto1), .Q_out(S[11:8]));
    
    
    //Level 4
    logic c4z,c4o;
    logic [3:0] Stz2,Sto2;
    fourbitsfulladder fbfa3z (.x(A[15:12]) ,.y(B[15:12]) ,.z(1'b0) ,.s(Stz2[3:0]) ,.c(c4z));
    fourbitsfulladder fbfa3o (.x(A[15:12]) ,.y(B[15:12]) ,.z(1'b1) ,.s(Sto2[3:0]) ,.c(c4o));
    assign cout = (c4o & c3)|c4z;
    four_bit_mux mux2 (.S(c3), .A_in(Stz2) ,.B_in(Sto2), .Q_out(S[15:12]));
endmodule
