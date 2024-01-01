module angry_face_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	output logic [3:0] red, green, blue
);

logic [10:0] rom_address;
logic [3:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

logic negedge_vga_clk;

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
assign rom_address = ((DrawX * 32) / 640) + (((DrawY * 64) / 480) * 32);

always_ff @ (posedge vga_clk) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
end

angry_face_rom angry_face_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

angry_face_palette angry_face_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
