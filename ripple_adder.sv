module ripple_adder
(
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     logic [16:0] cpro;
     assign cpro[0] = cin;
     generate
     for (genvar i = 0; i < 16; i = i + 1) 
     begin
        full_adder FA0 (.x (A[i]), .y (B[i]), .z (cpro[i]), .s (S[i]), .c (cpro[i+1]));
     end
     endgenerate
     
     assign cout = cpro[16];
//     full_adder FA0 (.x (A[0]), .y (B[0]), .z (c_in), .s (S[0]), .c (cpro[1]));
//     full_adder FA1 (.x (A[1]), .y (B[1]), .z (cpro[1]), .s (S[1]), .c (cpro[2]));
//     full_adder FA2 (.x (A[2]), .y (B[2]), .z (cpro[2]), .s (S[2]), .c (cpro[3]));
//     full_adder FA3 (.x (A[3]), .y (B[3]), .z (cpro[3]), .s (S[3]), .c (cpro[4]));
//     full_adder FA4 (.x (A[4]), .y (B[4]), .z (cpro[4]), .s (S[4]), .c (cpro[5]));
//     full_adder FA5 (.x (A[5]), .y (B[5]), .z (cpro[5]), .s (S[5]), .c (cpro[6]));
//     full_adder FA6 (.x (A[6]), .y (B[6]), .z (cpro[6]), .s (S[6]), .c (cpro[7]));
//     full_adder FA7 (.x (A[7]), .y (B[7]), .z (cpro[7]), .s (S[7]), .c (cpro[8]));
//     full_adder FA8 (.x (A[8]), .y (B[8]), .z (cpro[8]), .s (S[8]), .c (cpro[9]));
//     full_adder FA9 (.x (A[9]), .y (B[9]), .z (cpro[9]), .s (S[9]), .c (cpro[10]));
//     full_adder FAA (.x (A[10]), .y (B[10]), .z (cpro[10]), .s (S[10]), .c (cpro[11]));
//     full_adder FAB (.x (A[11]), .y (B[11]), .z (cpro[11]), .s (S[11]), .c (cpro[12]));
//     full_adder FAC (.x (A[12]), .y (B[12]), .z (cpro[12]), .s (S[12]), .c (cpro[13]));
//     full_adder FAD (.x (A[13]), .y (B[13]), .z (cpro[13]), .s (S[13]), .c (cpro[14]));
//     full_adder FAE (.x (A[14]), .y (B[14]), .z (cpro[14]), .s (S[14]), .c (cpro[15]));
//     full_adder FAF (.x (A[15]), .y (B[15]), .z (cpro[15]), .s (S[15]), .c (cout));
     
endmodule