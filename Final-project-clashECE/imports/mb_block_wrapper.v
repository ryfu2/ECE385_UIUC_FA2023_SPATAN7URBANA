//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Mon Oct  9 23:50:36 2023
//Host        : DonkeyWang running 64-bit major release  (build 9200)
//Command     : generate_target mb_block_wrapper.bd
//Design      : mb_block_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mb_block_wrapper
   (clk_100MHz,
    gpio_rtl_0_tri_io,
    gpio_rtl_1_tri_io,
    gpio_rtl_2_tri_io,
    gpio_rtl_3_tri_io,
    reset_rtl_0,
    uart_rtl_0_rxd,
    uart_rtl_0_txd);
  input clk_100MHz;
  inout [15:0]gpio_rtl_0_tri_io;
  inout [0:0]gpio_rtl_1_tri_io;
  inout [0:0]gpio_rtl_2_tri_io;
  inout [15:0]gpio_rtl_3_tri_io;
  input reset_rtl_0;
  input uart_rtl_0_rxd;
  output uart_rtl_0_txd;

  wire clk_100MHz;
  wire [0:0]gpio_rtl_0_tri_i_0;
  wire [1:1]gpio_rtl_0_tri_i_1;
  wire [10:10]gpio_rtl_0_tri_i_10;
  wire [11:11]gpio_rtl_0_tri_i_11;
  wire [12:12]gpio_rtl_0_tri_i_12;
  wire [13:13]gpio_rtl_0_tri_i_13;
  wire [14:14]gpio_rtl_0_tri_i_14;
  wire [15:15]gpio_rtl_0_tri_i_15;
  wire [2:2]gpio_rtl_0_tri_i_2;
  wire [3:3]gpio_rtl_0_tri_i_3;
  wire [4:4]gpio_rtl_0_tri_i_4;
  wire [5:5]gpio_rtl_0_tri_i_5;
  wire [6:6]gpio_rtl_0_tri_i_6;
  wire [7:7]gpio_rtl_0_tri_i_7;
  wire [8:8]gpio_rtl_0_tri_i_8;
  wire [9:9]gpio_rtl_0_tri_i_9;
  wire [0:0]gpio_rtl_0_tri_io_0;
  wire [1:1]gpio_rtl_0_tri_io_1;
  wire [10:10]gpio_rtl_0_tri_io_10;
  wire [11:11]gpio_rtl_0_tri_io_11;
  wire [12:12]gpio_rtl_0_tri_io_12;
  wire [13:13]gpio_rtl_0_tri_io_13;
  wire [14:14]gpio_rtl_0_tri_io_14;
  wire [15:15]gpio_rtl_0_tri_io_15;
  wire [2:2]gpio_rtl_0_tri_io_2;
  wire [3:3]gpio_rtl_0_tri_io_3;
  wire [4:4]gpio_rtl_0_tri_io_4;
  wire [5:5]gpio_rtl_0_tri_io_5;
  wire [6:6]gpio_rtl_0_tri_io_6;
  wire [7:7]gpio_rtl_0_tri_io_7;
  wire [8:8]gpio_rtl_0_tri_io_8;
  wire [9:9]gpio_rtl_0_tri_io_9;
  wire [0:0]gpio_rtl_0_tri_o_0;
  wire [1:1]gpio_rtl_0_tri_o_1;
  wire [10:10]gpio_rtl_0_tri_o_10;
  wire [11:11]gpio_rtl_0_tri_o_11;
  wire [12:12]gpio_rtl_0_tri_o_12;
  wire [13:13]gpio_rtl_0_tri_o_13;
  wire [14:14]gpio_rtl_0_tri_o_14;
  wire [15:15]gpio_rtl_0_tri_o_15;
  wire [2:2]gpio_rtl_0_tri_o_2;
  wire [3:3]gpio_rtl_0_tri_o_3;
  wire [4:4]gpio_rtl_0_tri_o_4;
  wire [5:5]gpio_rtl_0_tri_o_5;
  wire [6:6]gpio_rtl_0_tri_o_6;
  wire [7:7]gpio_rtl_0_tri_o_7;
  wire [8:8]gpio_rtl_0_tri_o_8;
  wire [9:9]gpio_rtl_0_tri_o_9;
  wire [0:0]gpio_rtl_0_tri_t_0;
  wire [1:1]gpio_rtl_0_tri_t_1;
  wire [10:10]gpio_rtl_0_tri_t_10;
  wire [11:11]gpio_rtl_0_tri_t_11;
  wire [12:12]gpio_rtl_0_tri_t_12;
  wire [13:13]gpio_rtl_0_tri_t_13;
  wire [14:14]gpio_rtl_0_tri_t_14;
  wire [15:15]gpio_rtl_0_tri_t_15;
  wire [2:2]gpio_rtl_0_tri_t_2;
  wire [3:3]gpio_rtl_0_tri_t_3;
  wire [4:4]gpio_rtl_0_tri_t_4;
  wire [5:5]gpio_rtl_0_tri_t_5;
  wire [6:6]gpio_rtl_0_tri_t_6;
  wire [7:7]gpio_rtl_0_tri_t_7;
  wire [8:8]gpio_rtl_0_tri_t_8;
  wire [9:9]gpio_rtl_0_tri_t_9;
  wire [0:0]gpio_rtl_1_tri_i_0;
  wire [0:0]gpio_rtl_1_tri_io_0;
  wire [0:0]gpio_rtl_1_tri_o_0;
  wire [0:0]gpio_rtl_1_tri_t_0;
  wire [0:0]gpio_rtl_2_tri_i_0;
  wire [0:0]gpio_rtl_2_tri_io_0;
  wire [0:0]gpio_rtl_2_tri_o_0;
  wire [0:0]gpio_rtl_2_tri_t_0;
  wire [0:0]gpio_rtl_3_tri_i_0;
  wire [1:1]gpio_rtl_3_tri_i_1;
  wire [10:10]gpio_rtl_3_tri_i_10;
  wire [11:11]gpio_rtl_3_tri_i_11;
  wire [12:12]gpio_rtl_3_tri_i_12;
  wire [13:13]gpio_rtl_3_tri_i_13;
  wire [14:14]gpio_rtl_3_tri_i_14;
  wire [15:15]gpio_rtl_3_tri_i_15;
  wire [2:2]gpio_rtl_3_tri_i_2;
  wire [3:3]gpio_rtl_3_tri_i_3;
  wire [4:4]gpio_rtl_3_tri_i_4;
  wire [5:5]gpio_rtl_3_tri_i_5;
  wire [6:6]gpio_rtl_3_tri_i_6;
  wire [7:7]gpio_rtl_3_tri_i_7;
  wire [8:8]gpio_rtl_3_tri_i_8;
  wire [9:9]gpio_rtl_3_tri_i_9;
  wire [0:0]gpio_rtl_3_tri_io_0;
  wire [1:1]gpio_rtl_3_tri_io_1;
  wire [10:10]gpio_rtl_3_tri_io_10;
  wire [11:11]gpio_rtl_3_tri_io_11;
  wire [12:12]gpio_rtl_3_tri_io_12;
  wire [13:13]gpio_rtl_3_tri_io_13;
  wire [14:14]gpio_rtl_3_tri_io_14;
  wire [15:15]gpio_rtl_3_tri_io_15;
  wire [2:2]gpio_rtl_3_tri_io_2;
  wire [3:3]gpio_rtl_3_tri_io_3;
  wire [4:4]gpio_rtl_3_tri_io_4;
  wire [5:5]gpio_rtl_3_tri_io_5;
  wire [6:6]gpio_rtl_3_tri_io_6;
  wire [7:7]gpio_rtl_3_tri_io_7;
  wire [8:8]gpio_rtl_3_tri_io_8;
  wire [9:9]gpio_rtl_3_tri_io_9;
  wire [0:0]gpio_rtl_3_tri_o_0;
  wire [1:1]gpio_rtl_3_tri_o_1;
  wire [10:10]gpio_rtl_3_tri_o_10;
  wire [11:11]gpio_rtl_3_tri_o_11;
  wire [12:12]gpio_rtl_3_tri_o_12;
  wire [13:13]gpio_rtl_3_tri_o_13;
  wire [14:14]gpio_rtl_3_tri_o_14;
  wire [15:15]gpio_rtl_3_tri_o_15;
  wire [2:2]gpio_rtl_3_tri_o_2;
  wire [3:3]gpio_rtl_3_tri_o_3;
  wire [4:4]gpio_rtl_3_tri_o_4;
  wire [5:5]gpio_rtl_3_tri_o_5;
  wire [6:6]gpio_rtl_3_tri_o_6;
  wire [7:7]gpio_rtl_3_tri_o_7;
  wire [8:8]gpio_rtl_3_tri_o_8;
  wire [9:9]gpio_rtl_3_tri_o_9;
  wire [0:0]gpio_rtl_3_tri_t_0;
  wire [1:1]gpio_rtl_3_tri_t_1;
  wire [10:10]gpio_rtl_3_tri_t_10;
  wire [11:11]gpio_rtl_3_tri_t_11;
  wire [12:12]gpio_rtl_3_tri_t_12;
  wire [13:13]gpio_rtl_3_tri_t_13;
  wire [14:14]gpio_rtl_3_tri_t_14;
  wire [15:15]gpio_rtl_3_tri_t_15;
  wire [2:2]gpio_rtl_3_tri_t_2;
  wire [3:3]gpio_rtl_3_tri_t_3;
  wire [4:4]gpio_rtl_3_tri_t_4;
  wire [5:5]gpio_rtl_3_tri_t_5;
  wire [6:6]gpio_rtl_3_tri_t_6;
  wire [7:7]gpio_rtl_3_tri_t_7;
  wire [8:8]gpio_rtl_3_tri_t_8;
  wire [9:9]gpio_rtl_3_tri_t_9;
  wire reset_rtl_0;
  wire uart_rtl_0_rxd;
  wire uart_rtl_0_txd;

  IOBUF gpio_rtl_0_tri_iobuf_0
       (.I(gpio_rtl_0_tri_o_0),
        .IO(gpio_rtl_0_tri_io[0]),
        .O(gpio_rtl_0_tri_i_0),
        .T(gpio_rtl_0_tri_t_0));
  IOBUF gpio_rtl_0_tri_iobuf_1
       (.I(gpio_rtl_0_tri_o_1),
        .IO(gpio_rtl_0_tri_io[1]),
        .O(gpio_rtl_0_tri_i_1),
        .T(gpio_rtl_0_tri_t_1));
  IOBUF gpio_rtl_0_tri_iobuf_10
       (.I(gpio_rtl_0_tri_o_10),
        .IO(gpio_rtl_0_tri_io[10]),
        .O(gpio_rtl_0_tri_i_10),
        .T(gpio_rtl_0_tri_t_10));
  IOBUF gpio_rtl_0_tri_iobuf_11
       (.I(gpio_rtl_0_tri_o_11),
        .IO(gpio_rtl_0_tri_io[11]),
        .O(gpio_rtl_0_tri_i_11),
        .T(gpio_rtl_0_tri_t_11));
  IOBUF gpio_rtl_0_tri_iobuf_12
       (.I(gpio_rtl_0_tri_o_12),
        .IO(gpio_rtl_0_tri_io[12]),
        .O(gpio_rtl_0_tri_i_12),
        .T(gpio_rtl_0_tri_t_12));
  IOBUF gpio_rtl_0_tri_iobuf_13
       (.I(gpio_rtl_0_tri_o_13),
        .IO(gpio_rtl_0_tri_io[13]),
        .O(gpio_rtl_0_tri_i_13),
        .T(gpio_rtl_0_tri_t_13));
  IOBUF gpio_rtl_0_tri_iobuf_14
       (.I(gpio_rtl_0_tri_o_14),
        .IO(gpio_rtl_0_tri_io[14]),
        .O(gpio_rtl_0_tri_i_14),
        .T(gpio_rtl_0_tri_t_14));
  IOBUF gpio_rtl_0_tri_iobuf_15
       (.I(gpio_rtl_0_tri_o_15),
        .IO(gpio_rtl_0_tri_io[15]),
        .O(gpio_rtl_0_tri_i_15),
        .T(gpio_rtl_0_tri_t_15));
  IOBUF gpio_rtl_0_tri_iobuf_2
       (.I(gpio_rtl_0_tri_o_2),
        .IO(gpio_rtl_0_tri_io[2]),
        .O(gpio_rtl_0_tri_i_2),
        .T(gpio_rtl_0_tri_t_2));
  IOBUF gpio_rtl_0_tri_iobuf_3
       (.I(gpio_rtl_0_tri_o_3),
        .IO(gpio_rtl_0_tri_io[3]),
        .O(gpio_rtl_0_tri_i_3),
        .T(gpio_rtl_0_tri_t_3));
  IOBUF gpio_rtl_0_tri_iobuf_4
       (.I(gpio_rtl_0_tri_o_4),
        .IO(gpio_rtl_0_tri_io[4]),
        .O(gpio_rtl_0_tri_i_4),
        .T(gpio_rtl_0_tri_t_4));
  IOBUF gpio_rtl_0_tri_iobuf_5
       (.I(gpio_rtl_0_tri_o_5),
        .IO(gpio_rtl_0_tri_io[5]),
        .O(gpio_rtl_0_tri_i_5),
        .T(gpio_rtl_0_tri_t_5));
  IOBUF gpio_rtl_0_tri_iobuf_6
       (.I(gpio_rtl_0_tri_o_6),
        .IO(gpio_rtl_0_tri_io[6]),
        .O(gpio_rtl_0_tri_i_6),
        .T(gpio_rtl_0_tri_t_6));
  IOBUF gpio_rtl_0_tri_iobuf_7
       (.I(gpio_rtl_0_tri_o_7),
        .IO(gpio_rtl_0_tri_io[7]),
        .O(gpio_rtl_0_tri_i_7),
        .T(gpio_rtl_0_tri_t_7));
  IOBUF gpio_rtl_0_tri_iobuf_8
       (.I(gpio_rtl_0_tri_o_8),
        .IO(gpio_rtl_0_tri_io[8]),
        .O(gpio_rtl_0_tri_i_8),
        .T(gpio_rtl_0_tri_t_8));
  IOBUF gpio_rtl_0_tri_iobuf_9
       (.I(gpio_rtl_0_tri_o_9),
        .IO(gpio_rtl_0_tri_io[9]),
        .O(gpio_rtl_0_tri_i_9),
        .T(gpio_rtl_0_tri_t_9));
  IOBUF gpio_rtl_1_tri_iobuf_0
       (.I(gpio_rtl_1_tri_o_0),
        .IO(gpio_rtl_1_tri_io[0]),
        .O(gpio_rtl_1_tri_i_0),
        .T(gpio_rtl_1_tri_t_0));
  IOBUF gpio_rtl_2_tri_iobuf_0
       (.I(gpio_rtl_2_tri_o_0),
        .IO(gpio_rtl_2_tri_io[0]),
        .O(gpio_rtl_2_tri_i_0),
        .T(gpio_rtl_2_tri_t_0));
  IOBUF gpio_rtl_3_tri_iobuf_0
       (.I(gpio_rtl_3_tri_o_0),
        .IO(gpio_rtl_3_tri_io[0]),
        .O(gpio_rtl_3_tri_i_0),
        .T(gpio_rtl_3_tri_t_0));
  IOBUF gpio_rtl_3_tri_iobuf_1
       (.I(gpio_rtl_3_tri_o_1),
        .IO(gpio_rtl_3_tri_io[1]),
        .O(gpio_rtl_3_tri_i_1),
        .T(gpio_rtl_3_tri_t_1));
  IOBUF gpio_rtl_3_tri_iobuf_10
       (.I(gpio_rtl_3_tri_o_10),
        .IO(gpio_rtl_3_tri_io[10]),
        .O(gpio_rtl_3_tri_i_10),
        .T(gpio_rtl_3_tri_t_10));
  IOBUF gpio_rtl_3_tri_iobuf_11
       (.I(gpio_rtl_3_tri_o_11),
        .IO(gpio_rtl_3_tri_io[11]),
        .O(gpio_rtl_3_tri_i_11),
        .T(gpio_rtl_3_tri_t_11));
  IOBUF gpio_rtl_3_tri_iobuf_12
       (.I(gpio_rtl_3_tri_o_12),
        .IO(gpio_rtl_3_tri_io[12]),
        .O(gpio_rtl_3_tri_i_12),
        .T(gpio_rtl_3_tri_t_12));
  IOBUF gpio_rtl_3_tri_iobuf_13
       (.I(gpio_rtl_3_tri_o_13),
        .IO(gpio_rtl_3_tri_io[13]),
        .O(gpio_rtl_3_tri_i_13),
        .T(gpio_rtl_3_tri_t_13));
  IOBUF gpio_rtl_3_tri_iobuf_14
       (.I(gpio_rtl_3_tri_o_14),
        .IO(gpio_rtl_3_tri_io[14]),
        .O(gpio_rtl_3_tri_i_14),
        .T(gpio_rtl_3_tri_t_14));
  IOBUF gpio_rtl_3_tri_iobuf_15
       (.I(gpio_rtl_3_tri_o_15),
        .IO(gpio_rtl_3_tri_io[15]),
        .O(gpio_rtl_3_tri_i_15),
        .T(gpio_rtl_3_tri_t_15));
  IOBUF gpio_rtl_3_tri_iobuf_2
       (.I(gpio_rtl_3_tri_o_2),
        .IO(gpio_rtl_3_tri_io[2]),
        .O(gpio_rtl_3_tri_i_2),
        .T(gpio_rtl_3_tri_t_2));
  IOBUF gpio_rtl_3_tri_iobuf_3
       (.I(gpio_rtl_3_tri_o_3),
        .IO(gpio_rtl_3_tri_io[3]),
        .O(gpio_rtl_3_tri_i_3),
        .T(gpio_rtl_3_tri_t_3));
  IOBUF gpio_rtl_3_tri_iobuf_4
       (.I(gpio_rtl_3_tri_o_4),
        .IO(gpio_rtl_3_tri_io[4]),
        .O(gpio_rtl_3_tri_i_4),
        .T(gpio_rtl_3_tri_t_4));
  IOBUF gpio_rtl_3_tri_iobuf_5
       (.I(gpio_rtl_3_tri_o_5),
        .IO(gpio_rtl_3_tri_io[5]),
        .O(gpio_rtl_3_tri_i_5),
        .T(gpio_rtl_3_tri_t_5));
  IOBUF gpio_rtl_3_tri_iobuf_6
       (.I(gpio_rtl_3_tri_o_6),
        .IO(gpio_rtl_3_tri_io[6]),
        .O(gpio_rtl_3_tri_i_6),
        .T(gpio_rtl_3_tri_t_6));
  IOBUF gpio_rtl_3_tri_iobuf_7
       (.I(gpio_rtl_3_tri_o_7),
        .IO(gpio_rtl_3_tri_io[7]),
        .O(gpio_rtl_3_tri_i_7),
        .T(gpio_rtl_3_tri_t_7));
  IOBUF gpio_rtl_3_tri_iobuf_8
       (.I(gpio_rtl_3_tri_o_8),
        .IO(gpio_rtl_3_tri_io[8]),
        .O(gpio_rtl_3_tri_i_8),
        .T(gpio_rtl_3_tri_t_8));
  IOBUF gpio_rtl_3_tri_iobuf_9
       (.I(gpio_rtl_3_tri_o_9),
        .IO(gpio_rtl_3_tri_io[9]),
        .O(gpio_rtl_3_tri_i_9),
        .T(gpio_rtl_3_tri_t_9));
  mb_block mb_block_i
       (.clk_100MHz(clk_100MHz),
        .gpio_rtl_0_tri_i({gpio_rtl_0_tri_i_15,gpio_rtl_0_tri_i_14,gpio_rtl_0_tri_i_13,gpio_rtl_0_tri_i_12,gpio_rtl_0_tri_i_11,gpio_rtl_0_tri_i_10,gpio_rtl_0_tri_i_9,gpio_rtl_0_tri_i_8,gpio_rtl_0_tri_i_7,gpio_rtl_0_tri_i_6,gpio_rtl_0_tri_i_5,gpio_rtl_0_tri_i_4,gpio_rtl_0_tri_i_3,gpio_rtl_0_tri_i_2,gpio_rtl_0_tri_i_1,gpio_rtl_0_tri_i_0}),
        .gpio_rtl_0_tri_o({gpio_rtl_0_tri_o_15,gpio_rtl_0_tri_o_14,gpio_rtl_0_tri_o_13,gpio_rtl_0_tri_o_12,gpio_rtl_0_tri_o_11,gpio_rtl_0_tri_o_10,gpio_rtl_0_tri_o_9,gpio_rtl_0_tri_o_8,gpio_rtl_0_tri_o_7,gpio_rtl_0_tri_o_6,gpio_rtl_0_tri_o_5,gpio_rtl_0_tri_o_4,gpio_rtl_0_tri_o_3,gpio_rtl_0_tri_o_2,gpio_rtl_0_tri_o_1,gpio_rtl_0_tri_o_0}),
        .gpio_rtl_0_tri_t({gpio_rtl_0_tri_t_15,gpio_rtl_0_tri_t_14,gpio_rtl_0_tri_t_13,gpio_rtl_0_tri_t_12,gpio_rtl_0_tri_t_11,gpio_rtl_0_tri_t_10,gpio_rtl_0_tri_t_9,gpio_rtl_0_tri_t_8,gpio_rtl_0_tri_t_7,gpio_rtl_0_tri_t_6,gpio_rtl_0_tri_t_5,gpio_rtl_0_tri_t_4,gpio_rtl_0_tri_t_3,gpio_rtl_0_tri_t_2,gpio_rtl_0_tri_t_1,gpio_rtl_0_tri_t_0}),
        .gpio_rtl_1_tri_i(gpio_rtl_1_tri_i_0),
        .gpio_rtl_1_tri_o(gpio_rtl_1_tri_o_0),
        .gpio_rtl_1_tri_t(gpio_rtl_1_tri_t_0),
        .gpio_rtl_2_tri_i(gpio_rtl_2_tri_i_0),
        .gpio_rtl_2_tri_o(gpio_rtl_2_tri_o_0),
        .gpio_rtl_2_tri_t(gpio_rtl_2_tri_t_0),
        .gpio_rtl_3_tri_i({gpio_rtl_3_tri_i_15,gpio_rtl_3_tri_i_14,gpio_rtl_3_tri_i_13,gpio_rtl_3_tri_i_12,gpio_rtl_3_tri_i_11,gpio_rtl_3_tri_i_10,gpio_rtl_3_tri_i_9,gpio_rtl_3_tri_i_8,gpio_rtl_3_tri_i_7,gpio_rtl_3_tri_i_6,gpio_rtl_3_tri_i_5,gpio_rtl_3_tri_i_4,gpio_rtl_3_tri_i_3,gpio_rtl_3_tri_i_2,gpio_rtl_3_tri_i_1,gpio_rtl_3_tri_i_0}),
        .gpio_rtl_3_tri_o({gpio_rtl_3_tri_o_15,gpio_rtl_3_tri_o_14,gpio_rtl_3_tri_o_13,gpio_rtl_3_tri_o_12,gpio_rtl_3_tri_o_11,gpio_rtl_3_tri_o_10,gpio_rtl_3_tri_o_9,gpio_rtl_3_tri_o_8,gpio_rtl_3_tri_o_7,gpio_rtl_3_tri_o_6,gpio_rtl_3_tri_o_5,gpio_rtl_3_tri_o_4,gpio_rtl_3_tri_o_3,gpio_rtl_3_tri_o_2,gpio_rtl_3_tri_o_1,gpio_rtl_3_tri_o_0}),
        .gpio_rtl_3_tri_t({gpio_rtl_3_tri_t_15,gpio_rtl_3_tri_t_14,gpio_rtl_3_tri_t_13,gpio_rtl_3_tri_t_12,gpio_rtl_3_tri_t_11,gpio_rtl_3_tri_t_10,gpio_rtl_3_tri_t_9,gpio_rtl_3_tri_t_8,gpio_rtl_3_tri_t_7,gpio_rtl_3_tri_t_6,gpio_rtl_3_tri_t_5,gpio_rtl_3_tri_t_4,gpio_rtl_3_tri_t_3,gpio_rtl_3_tri_t_2,gpio_rtl_3_tri_t_1,gpio_rtl_3_tri_t_0}),
        .reset_rtl_0(reset_rtl_0),
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd));
endmodule
