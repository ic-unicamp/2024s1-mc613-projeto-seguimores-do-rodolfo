module top1(
  input CLOCK_50,
  input [3:0] KEY, // para o reset

  output VGA_VS,
  output VGA_HS,
  output [7:0] VGA_R,
  output [7:0] VGA_G,
  output [7:0] VGA_B,
  output VGA_SYNC_N,
  output VGA_BLANK_N,
  output VGA_CLK
);

wire CLOCK_24;
wire CLOCK_25;
wire rst = !KEY[0];

wire [3:0] pattern_out_ptr1;
wire [7:0] y_pos_ptr1;
wire [3:0] command_out_ptr1;

wire [7:0] R_in;
wire [7:0] G_in;
wire [7:0] B_in;

// Mudar a atribuição de R_in, G_in e B_in para adicionar transparencia -> passar só os bits mais significativos de cor

assign R_in = command_out_ptr1[0] ? 8'b11111111 : 8'b00000000;
assign G_in = command_out_ptr1[1] || command_out_ptr1[3] ? 8'b11111111 : 8'b00000000;
assign B_in = command_out_ptr1[2] || command_out_ptr1[3] ? 8'b11111111 : 8'b00000000;


patter ptr1(
  .CLOCK_24(CLOCK_24),
  .command_in(4'b1011),
  .y_ini_pos(640),
  .reset(rst),
  .command_out(command_out),
  .y_pos(y_pos_ptr1),
  .sprite_pattern(pattern_out_ptr1)
);

pll_vga pll_vga_inst(
  .refclk (CLOCK_50),
  .rst(rst),
  .outclk_0(CLOCK_25)
);

vga vga(
  //input
  .VGA_CLK(VGA_CLK),
  .CLOCK_25(CLOCK_25),
  //.CLOCK_50(CLOCK_50),
  .KEY(KEY),
  .SW(SW),
  .R_in(Y_out),
  .G_in(Y_out),
  .B_in(Y_out),
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