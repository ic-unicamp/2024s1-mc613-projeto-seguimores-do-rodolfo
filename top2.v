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
  output VGA_CLK,
  
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3,
  output [6:0] HEX4,
  output [6:0] HEX5
);

wire [19:0] display;

wire CLOCK_24;
wire CLOCK_25;
wire rst = !SW[0];

wire [3:0] comando;

wire trocar_comando;
assign trocar_comando = trocar1 || trocar2 || trocar3 || trocar4 || trocar5 || trocar6 || trocar7 || trocar8;
assign ponto = ponto1 || ponto2 || ponto3 || ponto4 || ponto5 || ponto6 || ponto7 || ponto8; 
reg [7:0] score = 0;


always @ (posedge ponto) begin
  score = score + 1;
end

wire [3:0] command_out_ptr1;
wire [7:0] y_pos_ptr1;
wire [3:0] sprite_ptr1;
wire [3:0] command_out_ptr2;
wire [7:0] y_pos_ptr2;
wire [3:0] sprite_ptr2;
wire [3:0] command_out_ptr3;
wire [7:0] y_pos_ptr3;
wire [3:0] sprite_ptr3;
wire [3:0] command_out_ptr4;
wire [7:0] y_pos_ptr4;
wire [3:0] sprite_ptr4;
wire [3:0] command_out_ptr5;
wire [7:0] y_pos_ptr5;
wire [3:0] sprite_ptr5;
wire [3:0] command_out_ptr6;
wire [7:0] y_pos_ptr6;
wire [3:0] sprite_ptr6;
wire [3:0] command_out_ptr7;
wire [7:0] y_pos_ptr7;
wire [3:0] sprite_ptr7;
wire [3:0] command_out_ptr8;
wire [7:0] y_pos_ptr8;
wire [3:0] sprite_ptr8;

wire [7:0] R_in;
wire [7:0] G_in;
wire [7:0] B_in;

// Mudar a atribuição de R_in, G_in e B_in para adicionar transparencia -> passar só os bits mais significativos de cor

assign R_in = (((next_y > 450) && (next_y <= 458)) 
                || (sprite_ptr1[0] || sprite_ptr1[3]) 
                || (sprite_ptr2[0] || sprite_ptr2[3])
                || (sprite_ptr3[0] || sprite_ptr3[3])
                || (sprite_ptr4[0] || sprite_ptr4[3])
                || (sprite_ptr5[0] || sprite_ptr5[3])
                || (sprite_ptr6[0] || sprite_ptr6[3])
                || (sprite_ptr7[0] || sprite_ptr7[3])
                || (sprite_ptr8[0] || sprite_ptr8[3])) ? 8'b11111111 : 8'b00000000;
assign G_in = (((next_y > 450) && (next_y <= 458)) 
                || (sprite_ptr1[1] || sprite_ptr1[3]) 
                || (sprite_ptr2[1] || sprite_ptr2[3])
                || (sprite_ptr3[1] || sprite_ptr3[3])
                || (sprite_ptr4[1] || sprite_ptr4[3])
                || (sprite_ptr5[1] || sprite_ptr5[3])
                || (sprite_ptr6[1] || sprite_ptr6[3])
                || (sprite_ptr7[1] || sprite_ptr7[3])
                || (sprite_ptr8[1] || sprite_ptr8[3])) ? 8'b11111111 : 8'b00000000;
assign B_in = (((next_y > 450) && (next_y <= 458)) 
                || (sprite_ptr1[2]) 
                || (sprite_ptr2[2])
                || (sprite_ptr3[2])
                || (sprite_ptr4[2])
                || (sprite_ptr5[2])
                || (sprite_ptr6[2])
                || (sprite_ptr7[2])
                || (sprite_ptr8[2])) ? 8'b11111111 : 8'b00000000;

// 

placar placar(
  .display(display),
  .HEX0(HEX0),
  .HEX1(HEX1),
  .HEX2(HEX2),
  .HEX3(HEX3),
  .HEX4(HEX4),
  .HEX5(HEX5)
);


pattern ptr1(
  .CLOCK_25(CLOCK_25),
  .KEY(KEY),
  .command_in(comando),
  //.command_player({!KEY[3], !KEY[2], !KEY[1], !KEY[0]}),
  .y_ini_pos(0),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr2),
  .ponto(ponto1),
  .y_pos(y_pos_ptr1),
  .sprite_pattern(sprite_ptr1),
  .trocar(trocar1)
);

pattern ptr2(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(60),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr2),
  .ponto(ponto2),
  .y_pos(y_pos_ptr2),
  .sprite_pattern(sprite_ptr2),
  .trocar(trocar2)
);

pattern ptr3(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(120),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr3),
  .ponto(ponto3),
  .y_pos(y_pos_ptr3),
  .sprite_pattern(sprite_ptr3),
  .trocar(trocar3)
);

pattern ptr4(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(180),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr4),
  .ponto(ponto4),
  .y_pos(y_pos_ptr4),
  .sprite_pattern(sprite_ptr4),
  .trocar(trocar4)
);

pattern ptr5(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(240),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr5),
  .ponto(ponto5),
  .y_pos(y_pos_ptr5),
  .sprite_pattern(sprite_ptr5),
  .trocar(trocar5)
);

pattern ptr6(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(300),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr6),
  .ponto(ponto6),
  .y_pos(y_pos_ptr6),
  .sprite_pattern(sprite_ptr6),
  .trocar(trocar6)
);

pattern ptr7(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(360),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr7),
  .ponto(ponto7),
  .y_pos(y_pos_ptr7),
  .sprite_pattern(sprite_ptr7),
  .trocar(trocar7)
);

pattern ptr8(
  .CLOCK_25(CLOCK_25),
  .command_in(comando),
  .KEY(KEY),
  //.command_player(KEY),
  .y_ini_pos(420),
  .reset(rst),
  .next_x(next_x),
  .next_y(next_y),
  .command_out(command_out_ptr8),
  .ponto(ponto8),
  .y_pos(y_pos_ptr8),
  .sprite_pattern(sprite_ptr8),
  .trocar(trocar8)
);

gerenciador_de_patterns lista(
  .trocar_comando(trocar_comando),
  .rst(rst),
  .fim_da_lista(203),
  .fim_de_jogo(fim_de_jogo),
  .prox_comando(comando)
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

assign display = rst ? 0 : score;
,,
endmodule