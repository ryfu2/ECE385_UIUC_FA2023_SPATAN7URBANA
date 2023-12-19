//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//------------------------------------------------------------------------------


module slc3(
	input logic [15:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [15:0] LED,
	input logic [15:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [7:0] hex_seg,
	output logic [3:0] hex_grid,
	output logic [7:0] hex_segB,
	output logic [3:0] hex_gridB,
	output logic [15:0] ADDR,
	output logic [15:0] Data_to_SRAM
);

// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX;
logic BEN, MIO_EN, DRMUX, SR1MUX;
logic N,Z,P;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic [2:0] SR1IN, DR;
logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR, PC, ALU, ADDER, MARADDER;
logic [15:0] SR1OUT, SR2OUT;
logic [3:0] hex_4[3:0]; 
logic [3:0] one_hot;
logic [15:0] BUS;

//Bus Mux
assign one_hot[3] = GatePC;
assign one_hot[2] = GateMDR;
assign one_hot[1] = GateALU;
assign one_hot[0] = GateMARMUX;
assign LED = IR;
always_comb 
begin
    case (one_hot)
    4'b1000: BUS = PC;
    4'b0100: BUS = MDR;
    4'b0010: BUS = ALU;    //subject to change
    4'b0001: BUS = MARADDER;    //subject to change
    default: BUS = PC;
    endcase
end

HexDriver HexA (
    .clk(Clk),
    .reset(Reset),
    .in({hex_4[3][3:0],  hex_4[2][3:0], hex_4[1][3:0], hex_4[0][3:0]}),
    .hex_seg(hex_seg),
    .hex_grid(hex_grid)
);

//HexDriver HexA (
//    .clk(Clk),
//    .reset(Reset),
//    .in({IR[15:12],  IR[11:8], IR[7:4], IR[3:0]}),
//    .hex_seg(hex_seg),
//    .hex_grid(hex_grid)
//);

// You may use the second (right) HEX driver to display additional debug information
// For example, Prof. Cheng's solution code has PC being displayed on the right HEX


HexDriver HexB (
    .clk(Clk),
    .reset(Reset),
    .in({PC[15:12], PC[11:8], PC[7:4], PC[3:0]}),
    .hex_seg(hex_segB),
    .hex_grid(hex_gridB)
);

// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;

// Instantiate the rest of your modules here according to the block diagram of the SLC-3
// including your register file, ALU, etc..


// Our I/O controller (note, this plugs into MDR/MAR)

Mem2IO memory_subsystem(
    .*, .Reset(Reset), .ADDR(ADDR), .Switches(SW),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]), 
    .Data_from_CPU(MDR), .Data_to_CPU(MDR_In),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset), .Run(Run), .Continue(Continue),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
   .Mem_OE(OE), .Mem_WE(WE)
);

regN negative(.Clk(Clk), .Reset(Reset), .LD_CC(LD_CC), .first(BUS[15]), .Dout(N));
regP positive(.Clk(Clk), .Reset(Reset), .LD_CC(LD_CC), .first(BUS), .Dout(P));
regZ zero(.Clk(Clk), .Reset(Reset), .LD_CC(LD_CC), .first(BUS), .Dout(Z));
regBen bigben(.Clk(Clk), .Reset(Reset), .LD_BEN(LD_BEN), .IR_11(IR[11]), .IR_10(IR[10]), .IR_9(IR[9]), .N(N), .Z(Z) ,.P(P), .Dout(BEN));

ADDRMUX ADDR_MIDDLE (
    .PC(PC),
    .SR1OUT(SR1OUT),
    .IR(IR),
    .ADDR1MUX(ADDR1MUX),
    .ADDR2MUX(ADDR2MUX),
    .ADDR(ADDER)
);

MARMUX_unit MUX_IN_THE_WEST (
    .MARMUX(MARMUX),
    .IR(IR),
    .ADDR(ADDER),
    .MARADDER(MARADDER)
);
always_comb
begin
    if (SR1MUX)
        SR1IN = IR[11:9];
    else
        SR1IN = IR[8:6];
    if (DRMUX)
        DR = 3'b111;
    else 
        DR = IR[11:9];
end

Register_File regfile(
    .Clk(Clk),
    .BUS(BUS),
    .Reset(Reset),
    .LD_REG(LD_REG),
    .DR(DR),
    .SR1IN(SR1IN),
    .SR2IN(IR[2:0]),
    .SR1OUTPUT(SR1OUT),
    .SR2OUTPUT(SR2OUT)
);

ALU_unit ALU_unit0 (
    .SR2MUX(SR2MUX),
    .ALUK(ALUK),
    .IR(IR[4:0]),
    .SR1OUT(SR1OUT),
    .SR2OUT(SR2OUT),
    .ALUOUT(ALU)
);

PC_unit PCreg(
    .Clk(Clk),
    .Reset(Reset),
    .LD_PC(LD_PC),
    .SW(SW),
    .BUS(BUS),
    .ADDER(ADDER),
    .PC_in(PC),
    .PCMUX(PCMUX),
    .PC(PC));

reg_16 MARreg(
    .Clk(Clk),
    .Reset(Reset), 
    .Load(LD_MAR),
    .D(BUS),
    .Data_Out(MAR));
//select the MDR input
logic[15:0] desiredMDR;

always_comb
begin
    if (~MIO_EN) desiredMDR = BUS;
    else desiredMDR = MDR_In;
end

reg_16 MDRreg(
    .Clk(Clk),
    .Reset(Reset),
    .Load(LD_MDR),
    .D(desiredMDR),
    .Data_Out(MDR));
    
reg_16 IRreg(
    .Clk(Clk),
    .Reset(Reset),
    .Load(LD_IR),
    .D(BUS),
    .Data_Out(IR));

endmodule
