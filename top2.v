module top2(
  input CLOCK_50,
  input [3:0] KEY, // para o reset
  input [9:0] SW,

  output VGA_VS,
  output VGA_HS,
  output [7:0] VGA_R,
  output [7:0] VGA_G,
  output [7:0] VGA_B,
  output VGA_SYNC_N = 1,
  output VGA_BLANK_N = 1,
  output VGA_CLK
);

wire CLOCK_24;
wire CLOCK_25;
wire rst = !SW[0];

wire [3:0] command_out_ptr1;
wire [7:0] y_pos_ptr1;
wire [3:0] sprite_ptr1;
wire [3:0] command_out_ptr2;
wire [7:0] y_pos_ptr2;
wire [3:0] sprite_ptr2;

wire [7:0] R_in;
wire [7:0] G_in;
wire [7:0] B_in;

// Mudar a atribuição de R_in, G_in e B_in para adicionar transparencia -> passar só os bits mais significativos de cor

assign R_in = ((sprite_ptr1[0] || sprite_ptr1[3]) || (sprite_ptr2[0] || sprite_ptr2[3])) ? 8'b11111111 : 8'b00000000;
assign G_in = ((sprite_ptr1[1] || sprite_ptr1[3]) || (sprite_ptr2[1] || sprite_ptr2[3])) ? 8'b11111111 : 8'b00000000;
assign B_in = ((sprite_ptr1[2]) || (sprite_ptr2[2])) ? 8'b11111111 : 8'b00000000;


pattern ptr1(
  .CLOCK_25(CLOCK_25),
  .command_in(4'b0100),
  .y_ini_pos(0),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr2),
  .y_pos(y_pos_ptr1),
  .sprite_pattern(sprite_ptr1)
);

pattern ptr2(
  .CLOCK_25(CLOCK_25),
  .command_in(4'b1010),
  .y_ini_pos(248),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr2),
  .y_pos(y_pos_ptr2),
  .sprite_pattern(sprite_ptr2)
);

pll_vga pll_vga_inst(
  .refclk (CLOCK_50),
  .rst(rst),
  .outclk_0(CLOCK_25)
);

wire [9:0] next_x;
wire [9:0] next_y;

vga vga(
  //input
  .VGA_CLK(VGA_CLK),
  .CLOCK_25(CLOCK_25),
  //.CLOCK_50(CLOCK_50),
  .KEY(KEY),
  .SW(SW),
  .R_in(R_in),
  .G_in(G_in),
  .B_in(B_in),
  //output
  .VGA_VS(VGA_VS),
  .VGA_HS(VGA_HS),
  .next_x(next_x),
  .next_y(next_y),
  .VGA_R(VGA_R),
  .VGA_G(VGA_G),
  .VGA_B(VGA_B),
  .VGA_SYNC_N(VGA_SYNC_N),
  .VGA_BLANK_N(VGA_BLANK_N)
);

endmodule