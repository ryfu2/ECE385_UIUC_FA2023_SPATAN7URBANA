module reg_1 (input  logic Clk, Reset, Load,
              input  logic D,
              output logic Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset)
			  Data_Out <= 1'b0;
		 else if (Load)
			  Data_Out <= D;
		 else 
		      Data_Out <= Data_Out;
    end

endmodule
