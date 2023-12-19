//4-bit logic processor top level module
//for use with ECE 385 Fall 2023
//last modified by Zuofu Cheng


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (input logic   Clk,     // Internal
                                Reset_Load_Clear,   // Push button 0
                                Run, // Push button 1
                  input  logic [7:0]  SW,     // input data
                  output logic Xval,        //the most significant bit of output AB
                  output logic [7:0]  Aval,    // DEBUG
                               Bval, 
                  //output logic [7:0] Sval,   // DEBUG   
                  output logic [7:0] hex_seg, // Hex display control
                  output logic [3:0] hex_grid); // Hex display control

	 //local logic variables go here
	 logic Reset_SH, Run_SH, Load_SH;
	 logic Aout, Bout, Xin, Xout;
	 logic [7:0] Ainput, Binput, S, Aoutput, Boutput;
     logic Add_En, Shift_En, Sub_En;
	 
//      always_comb
//       begin
//            Run_SH = ~Run;
//            Reset_SH = ~Reset_Load_Clear;
//       end
      assign Aval = Aoutput;
      assign Bval = Boutput;
      assign Xval = Xout;
      assign Sval = S;
      // Register A
	  reg_8 reg_A (
                        .Clk(Clk),
                        .Reset(Reset_Load_Clear | Load_SH),
                        .Load(Add_En|Sub_En),
                        .Shift_En(Shift_En),
                        .Shift_In(Xout),
                        .D(Ainput[7:0]),
                        .Data_Out(Aoutput[7:0]),
                        .Shift_Out(Aout) );

      //Register B
      reg_8 reg_B (
                        .Clk(Clk),
                        .Reset(1'b0),
                        .Load(Reset_Load_Clear),
                        .Shift_En(Shift_En),
                        .Shift_In(Aout),
                        .D(SW[7:0]),
                        .Data_Out(Boutput[7:0]),
                        .Shift_Out(Bout) );
      
      //Register X
      reg_1 reg_X (
                        .Clk(Clk),
                        .Reset(Reset_Load_Clear | Load_SH),
                        .Load(Add_En | Sub_En),
                        .D(Xin),
                        .Data_Out(Xout));
      
      //Adder
      nine_bits_adder   add_unit (
                        .A(Aoutput[7:0]),
                        .B(SW[7:0]),
                        .S(Ainput[7:0]),
                        .sub_enable(Sub_En),
                        .add_enable(Add_En),
                        .Xin(Xout),
                        .X(Xin)
                         );
      //Control Unit
	  control           control_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .Run(Run_SH),
                        .Shift_En(Shift_En),
                        .Sub_En(Sub_En),
                        .Add_En(Add_En),
                        .Load(Load_SH),
                        .M(Bout)
                        );
      HexDriver HexA (
			.clk(Clk),
			.reset(Reset_Load_Clear),
			.in({Aoutput[7:4],  Aoutput[3:0], Boutput[7:4], Boutput[3:0]}),
			.hex_seg(hex_seg),
			.hex_grid(hex_grid)
		);
	  sync button_sync[1:0] (Clk, {~Reset_Load_Clear, ~Run}, {Reset_SH, Run_SH});
//	  sync Din_sync[7:0] (Clk, SW, S);
endmodule
