`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class Name: UIUC ECE385
// Engineer: Zuofu Cheng & Ryan Fu
// 
// Create Date: 12/11/2022 10:48:49 AM
// Design Name: 
// Module Name: mb_usb_hdmi_top
// Target Devices: 
// Tool Versions: 
// Description: 
// Top level for mb_lwusb test project, copy mb wrapper here from Verilog and modify
// to SV
// Dependencies: microblaze block design
// 
// Revision:
// Revision 1.1 DDR added to the block design
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mb_usb_hdmi_top(
    input logic Clk,
    input logic reset_rtl_0,
    
    //USB signals
    input logic [0:0] gpio_usb_int_tri_i,
    output logic gpio_usb_rst_tri_o,
    input logic usb_spi_miso,
    output logic usb_spi_mosi,
    output logic usb_spi_sclk,
    output logic usb_spi_ss,
    
    //UART
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd,
    
    //HDMI
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p,
        
    //HEX displays
    output logic [7:0] hex_segA,
    output logic [3:0] hex_gridA,
    output logic [7:0] hex_segB,
    output logic [3:0] hex_gridB,
    
    //DDR3 Input & Outputs
    input  logic SYS_CLK_clk_n, //differential system clock input
    input  logic SYS_CLK_clk_p, //note that this is different than previous designs
    output logic [12:0] ddr3_addr,
    output logic [2:0] ddr3_ba,
    output logic ddr3_cas_n,
    output logic ddr3_ck_n, //differential DDR3 clock, typically between 300-333MHz
    output logic ddr3_ck_p,
    output logic ddr3_cke,
    output logic [1:0] ddr3_dm,
    inout wire [15:0] ddr3_dq, //bidirectional signals need to be of type wire
    inout wire [1:0] ddr3_dqs_n,
    inout wire [1:0] ddr3_dqs_p,
    output logic ddr3_odt,   
    output logic ddr3_ras_n,
    output logic ddr3_reset_n,
    output logic ddr3_we_n,
    
//    //Audio
    output logic SPKL, SPKR
    );
    
    logic [31:0] keycode0_gpio, sound;
    logic readready, readena;
    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY, ballxsig, ballysig, ballsizesig;
    logic hsync, vsync, vde;
    logic blank;
    logic [3:0] red, green, blue;
    logic reset_ah;
    logic gameover;
    
    assign reset_ah = reset_rtl_0;
    //ColorMapper
    battle_example real_colormapper (
        .vga_clk(clk_25MHz),
        .vsync(vsync),
        .reset(reset_ah),
        .DrawX(drawX),
        .DrawY(drawY),
        .MouseX(ballxsig),
        .MouseY(10'd480 - ballysig),
        .blank(blank),
        .andsignals(andsignals),
        .orsignals(orsignals),
        .notsignals(notsignals),
        .nerdsignals(nerdsignals),
        .background(keycode0_gpio[24]),
        .number(number_on),
        .elion(elion),
        .elinum(elinum),
        .andnameon(and_name_on),
        .ornameon(or_name_on),
        .notnameon(not_name_on),
        .nerdnameon(nerd_name_on),
        .loading(loading),
        .Timeoutd(Timeout),
        .timeout(to),
        .red(red),
        .green(green),
        .blue(blue),
        .andinfield(andinfield),
        .orinfield(orinfield),
        .notinfield(notinfield),
        .nerdinfield(nerdinfield),
        .gameover(gameover)
    );

    
    //Keycode HEX drivers
//    HexDriver HexA (
//        .clk(Clk),
//        .reset(reset_ah),
//        .in({keycode0_gpio[31:28], keycode0_gpio[27:24], keycode0_gpio[23:20], keycode0_gpio[19:16]}),
//        .hex_seg(hex_segA),
//        .hex_grid(hex_gridA)
//    );
    
//    HexDriver HexB (
//        .clk(Clk),
//        .reset(reset_ah),
//        .in({keycode0_gpio[15:12], keycode0_gpio[11:8], keycode0_gpio[7:4], keycode0_gpio[3:0]}),
//        .hex_seg(hex_segB),
//        .hex_grid(hex_gridB)
//    );
    HexDriver HexA (
        .clk(Clk),
        .reset(reset_ah),
        .in({sound[31:28], sound[27:24], sound[23:20], sound[19:16]}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );
    
    HexDriver HexB (
        .clk(Clk),
        .reset(reset_ah),
        .in({sound[15:12], sound[11:8], sound[7:4], sound[3:0]}),
        .hex_seg(hex_segB),
        .hex_grid(hex_gridB)
    );
    
//    mb_block mb_block_i(
//        .clk_100MHz(Clk),
//        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
//        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
//        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
//        .reset_rtl_0(~reset_ah), //Block designs expect active low reset, all other modules are active high
//        .uart_rtl_0_rxd(uart_rtl_0_rxd),
//        .uart_rtl_0_txd(uart_rtl_0_txd),
//        .usb_spi_miso(usb_spi_miso),
//        .usb_spi_mosi(usb_spi_mosi),
//        .usb_spi_sclk(usb_spi_sclk),
//        .usb_spi_ss(usb_spi_ss)
//    );
    
    
//    logic uart_rtl_1_rxd, uart_rtl_1_txd, uart_rtl_2_rxd, uart_rtl_2_txd;
    mb_block mb_block_i(
        .SYS_CLK_clk_n(SYS_CLK_clk_n),
        .SYS_CLK_clk_p(SYS_CLK_clk_p),
        .ddr3_addr(ddr3_addr),
        .ddr3_ba(ddr3_ba),
        .ddr3_cas_n(ddr3_cas_n),
        .ddr3_ck_n(ddr3_ck_n),
        .ddr3_ck_p(ddr3_ck_p),
        .ddr3_cke(ddr3_cke),
        .ddr3_dm(ddr3_dm),
        .ddr3_dq(ddr3_dq),
        .ddr3_dqs_n(ddr3_dqs_n),
        .ddr3_dqs_p(ddr3_dqs_p),
        .ddr3_odt(ddr3_odt),
        .ddr3_ras_n(ddr3_ras_n),
        .ddr3_reset_n(ddr3_reset_n),
        .ddr3_we_n(ddr3_we_n),
        .gpio_readready_tri_i(almost_empty),
        .gpio_sound_tri_o(sound),
        .gpio_reset_tri_i(reset_ah),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .reset_rtl_0(1'b1), //Block designs expect active low reset, all other modules are active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss)
    );
//    ddr3 ddr3_i(
//        .SYS_CLK_clk_n(SYS_CLK_clk_n),
//        .SYS_CLK_clk_p(SYS_CLK_clk_p),
//        .ddr3_addr(ddr3_addr),
//        .ddr3_ba(ddr3_ba),
//        .ddr3_cas_n(ddr3_cas_n),
//        .ddr3_ck_n(ddr3_ck_n),
//        .ddr3_ck_p(ddr3_ck_p),
//        .ddr3_cke(ddr3_cke),
//        .ddr3_dm(ddr3_dm),
//        .ddr3_dq(ddr3_dq),
//        .ddr3_dqs_n(ddr3_dqs_n),
//        .ddr3_dqs_p(ddr3_dqs_p),
//        .ddr3_odt(ddr3_odt),
//        .ddr3_ras_n(ddr3_ras_n),
//        .ddr3_reset_n(ddr3_reset_n),
//        .ddr3_we_n(ddr3_we_n),
//        .reset_rtl_0(1'b1), //Block designs expect active low reset, all other modules are active high
//        .gpio_readready_tri_i(readready),
//        .gpio_sounddata_tri_o(sound),
//        .uart_rtl_0_rxd(uart_rtl_0_rxd),
//        .uart_rtl_0_txd(0)
//    );
//    always_comb
//    begin
//        if (uart_rtl_1_txd)
//            uart_rtl_0_txd = uart_rtl_1_txd;
//        else
//            uart_rtl_0_txd = uart_rtl_2_txd;
//    end
    //clock wizard configured with a 1x and 5x clock for HDMI
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
    //VGA Sync signal generator
    vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    

    //Real Digital VGA to HDMI converter
    hdmi_tx_0 vga_to_hdmi (
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        //Reset is active LOW
        .rst(reset_ah),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );
    
    
    logic [15:0] desiredkeycode;
    
    always_comb
    begin
        if (to)
            desiredkeycode = 16'b0;
        else
            desiredkeycode = keycode0_gpio[15:0];
    end
   

    
    //Ball Module
    ball ball_instance(
        .Reset(reset_ah),
        .frame_clk(vsync),                    
        .keycode(desiredkeycode),    
        .BallX(ballysig),
        .BallY(ballxsig),
        .BallS(ballsizesig)
    );
    
    //Color Mapper Module  
    color_mapper color_instance(
        .BallX(ballxsig),
        .BallY(ballysig),
        .DrawX(drawX),
        .DrawY(10'd480 - drawY),
        .Ball_size(ballsizesig),
        .blank(blank)
    );
    
    //Timer
    logic[5:0] second;
    logic[1:0] minute;
    logic to;
    timer timer(
        .background(keycode0_gpio[24]),
        .clk(vsync),
        .reset(reset_ah | gameover),
        .minute(minute),
        .second(second),
        .to(to)
    );
    
    
    //Number and alphabets
    logic number_on, elinum,loading, Timeout;
    logic and_num_on, or_name_on, not_name_on, nerd_name_on;
    numbers numbers(
        .second(second),
        .minute(minute),
        .andinstate(andinstate),
        .orinstate(orinstate),
        .notinstate(notinstate),
        .nerdinstate(nerdinstate),
        .elixir(eli),
        .elixirnum(elinum),
        .DrawX(drawX),
        .DrawY(drawY),
        .background(keycode0_gpio[24]),
        .number_on(number_on),
        .and_name_on(and_name_on),
        .or_name_on(or_name_on),
        .not_name_on(not_name_on),
        .nerd_name_on(nerd_name_on),
        .loading(loading),
        .Timeout(Timeout)
    );
    
    //Elixir Management
    logic [4:0] elixirin;
    logic [4:0] eli;
    logic elion;
    assign elixirin = elixirinand + elixirinot + elixirinor + elixirinerd;
    Elixir Elixir(
        .background(keycode0_gpio[24]),
        .clk(vsync),
        .reset(reset_ah),
        .elixirin(elixirin),
        .drawX(drawX),
        .drawY(drawY),
        .elixirout(eli),
        .elixiron(elion)
    );
    
    //Mousestate management
    logic andidle, andinstate, anddeploy, andinfield;
    logic [2:0] andsignals;
    logic [4:0] elixirinand;
    assign andsignals = {andidle, andinstate, anddeploy};
    Mousestate andstatemachine(
        .Clk(vsync),
        .Reset(reset_ah),
        .otherinz(orinstate),
        .otherino(notinstate),
        .otherint(nerdinstate),
        .infield(andinfield),
        .X(ballxsig),
        .Y(10'd480 - ballysig),
        .lowerX(10'd520),
        .lowerY(10'd290),
        .upperX(10'd600),
        .upperY(10'd370),
        .elixircost(5'd9),
        .click(keycode0_gpio[19:16]),
        .eli(eli),
        .elixirin(elixirinand),
        .idle(andidle),
        .instate(andinstate),
        .deploy(anddeploy)
    );
    
    logic oridle, orinstate, ordeploy, orinfield;
    logic [2:0] orsignals;
    logic [4:0] elixirinor;
    assign orsignals = {oridle, orinstate, ordeploy};
    Mousestate orstatemachine(
        .Clk(vsync),
        .otherinz(andinstate),
        .otherino(notinstate),
        .otherint(nerdinstate),
        .Reset(reset_ah),
        .infield(orinfield),
        .X(ballxsig),
        .Y(10'd480 - ballysig),
        .lowerX(10'd520),
        .lowerY(10'd200),
        .upperX(10'd600),
        .upperY(10'd280),
        .elixircost(5'd12),
        .click(keycode0_gpio[19:16]),
        .eli(eli),
        .elixirin(elixirinor),
        .idle(oridle),
        .instate(orinstate),
        .deploy(ordeploy)
    );
    
    logic notidle, notinstate, notdeploy, notinfield;
    logic [2:0] notsignals;
    logic [4:0] elixirinot;
    assign notsignals = {notidle, notinstate, notdeploy};
    Mousestate notstatemachine(
        .Clk(vsync),
        .otherinz(andinstate),
        .otherino(orinstate),
        .otherint(nerdinstate),
        .Reset(reset_ah),
        .infield(notinfield),
        .X(ballxsig),
        .Y(10'd480 - ballysig),
        .lowerX(10'd520),
        .lowerY(10'd110),
        .upperX(10'd600),
        .upperY(10'd190),
        .elixircost(5'd3),
        .click(keycode0_gpio[19:16]),
        .eli(eli),
        .elixirin(elixirinot),
        .idle(notidle),
        .instate(notinstate),
        .deploy(notdeploy)
    );
    
    logic nerdidle, nerdinstate, nerddeploy, nerdinfield;
    logic [2:0] nerdsignals;
    logic [4:0] elixirinerd;
    assign nerdsignals = {nerdidle, nerdinstate, nerddeploy};
    Mousestate nerdstatemachine(
        .Clk(vsync),
        .otherinz(andinstate),
        .otherino(orinstate),
        .otherint(notinstate),
        .Reset(reset_ah),
        .infield(nerdinfield),
        .X(ballxsig),
        .Y(10'd480 - ballysig),
        .lowerX(10'd520),
        .lowerY(10'd20),
        .upperX(10'd600),
        .upperY(10'd100),
        .elixircost(5'd15),
        .click(keycode0_gpio[19:16]),
        .eli(eli),
        .elixirin(elixirinerd),
        .idle(nerdidle),
        .instate(nerdinstate),
        .deploy(nerddeploy)
    );
    
    
//Audio part
logic clk_44khz, clk_88khz, SPK, srena;
logic [4:0] dsound;
logic [31:0] newsound;
logic [10:0] dsoundad;
logic soundchange;
always_ff @ (posedge Clk)
begin
    if (reset_ah)
        begin
        srena <= 0;
        end
    if (sound[30] != soundchange)
        begin
        srena <= 1;
        end
    else
        srena <= 0;
    soundchange <= sound[30];
end
logic almost_empty, almost_full, full, empty;
fifo_sound fs (
    .din(sound),
    .wr_en(srena & ~full),
    .dout(newsound),
    .almost_empty(almost_empty),
    .almost_full(almost_full),
    .full(full),
    .empty(empty),
    .rd_en(readready & ~empty),
    .rst(reset_ah),
    .wr_clk(Clk),
    .rd_clk(clk_44khz)
);
ffokcounter ffokcounter0(
    .Clk(Clk),
    .reset(reset_ah),
    .Sound(dsound),
    .SPK(SPK),
    .clk_44khz(clk_44khz),
    .clk_88khz(clk_88khz)
);

modulator modulator0(
    .Clk(clk_44khz),
    .reset(reset_ah),
    .Sound(newsound),
    .desiredsound(dsound),
    .readready(readready)
);    

always_comb
begin
    if (empty)
        begin
        SPKL = 0;
        SPKR = 0;
        end
    else
        begin
        SPKL = SPK;
        SPKR = SPK;
        end
end
endmodule
