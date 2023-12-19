module ripple_adder
(
	input  [8:0] A, B,
	input         cin,
	output [8:0] S
);

     logic [9:0] cpro;
     assign cpro[0] = cin;
     generate
     for (genvar i = 0; i < 9; i = i + 1) 
     begin
        full_adder FA0 (.x (A[i]), .y (B[i]), .z (cpro[i]), .s (S[i]), .c (cpro[i+1]));
     end
     endgenerate
endmodule