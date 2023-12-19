module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
      logic [3:0] G;
      logic [3:0] P;  
      logic [2:0] cpro;
      
      fourbitlookahead fbla0(.X(A[3:0]), .Y(B[3:0]), .cin(cin), .S(S[3:0]), .Pout(P[0]) ,.Gout(G[0]));
      assign cpro[0] = G[0] |(cin&P[0]);
      fourbitlookahead fbla1(.X(A[7:4]), .Y(B[7:4]), .cin(cpro[0]), .S(S[7:4]), .Pout(P[1]) ,.Gout(G[1]));
      assign cpro[1] = G[1]|(cpro[0]&P[1]);
      fourbitlookahead fbla2(.X(A[11:8]), .Y(B[11:8]), .cin(cpro[1]), .S(S[11:8]), .Pout(P[2]) ,.Gout(G[2]));
      assign cpro[2] = G[2]|(cpro[1]&P[2]); 
      fourbitlookahead fbla3(.X(A[15:12]), .Y(B[15:12]), .cin(cpro[2]), .S(S[15:12]), .Pout(P[3]) ,.Gout(G[3]));
      assign cout = G[3]|(cpro[2]&P[3]);
endmodule
