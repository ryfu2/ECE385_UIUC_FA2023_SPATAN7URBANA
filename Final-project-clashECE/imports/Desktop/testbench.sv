module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
    logic Clk = 0;
    logic reset;
    logic [7:0] Sound;
    logic clk_44khz, SPK, clk_88khz;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
ffokcounter counter0(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: TEST_VECTORS
reset = 1;
#10 reset = 0;
#10
Sound = 8'b00110001;




end




endmodule
