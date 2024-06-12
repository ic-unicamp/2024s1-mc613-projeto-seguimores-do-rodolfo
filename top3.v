module top3 (
input CLOCK_50,
input [3:0] KEY, 
input [9:0] SW, // para o reset
inout [35:0] GPIO_1,
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

wire CLOCK_24, CLOCK_25;
wire rst = !SW[0];
wire XCLK;    
wire RESET; 
wire PWDN;       
wire VSYNC;      
wire HREF;       
wire PCLK;
wire e_pix;
wire [19:0] display;
wire [3:0] comando;
wire [7:0] D;
wire [18:0] contador_C;
wire [7:0] Y_in, Y_2; 
wire [7:0]R_out, G_out, B_out; 
wire [7:0]R_out2, G_out2, B_out2; 
wire [7:0] Y_verde, Y_verde2;
wire verde, verde2;
wire red_flag, green_flag, yellow_flag, blue_flag;
reg [7:0] Y_enter; 
wire [7:0] Cb, Cr; 
wire enable_d; 
wire [9:0] next_x, next_y;
wire [7:0] Y_out;
wire [19:0] contador_V;
//assign GPIO_1[26] = SDIOC;
//assign SDIOC = 1'bz;
assign GPIO_1[31] = XCLK;
//assign XCLK = 1'bz;
assign GPIO_1[24] = RESET;
//assign RESET = 1'bz;
assign GPIO_1[25] = PWDN;
//assign PWDN = 1'bz;
assign VSYNC = GPIO_1[28];
assign GPIO_1[28] = 1'bz;
assign HREF = GPIO_1[29]; 
assign GPIO_1[29] = 1'bz;
assign PCLK = GPIO_1[30];
assign GPIO_1[30] = 1'bz;
assign D[7] = GPIO_1[16];
assign D[6] = GPIO_1[17];
assign D[5] = GPIO_1[18];
assign D[4] = GPIO_1[19];
assign D[3] = GPIO_1[20];
assign D[2] = GPIO_1[21];
assign D[1] = GPIO_1[22];
assign D[0] = GPIO_1[23];
assign GPIO_1[23:16] = 8'bz;
assign GPIO_1[17:0] = 18'bz;
assign GPIO_1[35:32] = 4'bz;
assign GPIO_1[27:26] = 2'bz;
parameter WIDTH = 640;
parameter HEIGHT = 480;
parameter REGION_WIDTH = WIDTH / 4;
assign contador_V = next_y * 10'd640 + next_x;
// modules
PLL clk_24(
.refclk(CLOCK_50),
.rst(rst),
.outclk_0 (CLOCK_24)
);

pll_vga pll_vga_inst(
  .refclk (CLOCK_50),
  .rst(rst),
  .outclk_0(CLOCK_25)
);

camera camera(
  // inputs
  .CLOCK_24(CLOCK_24),
  .KEY(SW),
  .D(D),
  .RESET(RESET),
  //.SDIOC(SDIOC),
  .PWDN(PWDN),
  //.SDIOD(GPIO_1[27]),   //inout
  .XCLK(XCLK),
  // outputs
  .e_data(enable_d),
  .Y(Y_in),
  .Y_2(Y_2),
  .Cb(Cb),
  .Cr(Cr),
  .e_pix(e_pix),
  .VSYNC(VSYNC),
  .HREF(HREF),
  .CONTADOR_C(contador_C),
  .PCLK(PCLK)
);

detectorVerde dec(
  .PCLK(PCLK), 
  .e_pix(e_pix),
  .x(next_x),
  .y(next_y),
  .Y(Y_in),
  .Cb(Cb),
  .Cr(Cr),
  .R_out(R_out), 
  .G_out(G_out),
  .B_out(B_out),
  .eh_verde(verde), 
  .Y_dec(Y_verde)
);

detectorVerde dec_verde(
  .PCLK(PCLK), 
  .e_pix(e_pix),
  .Y(Y_2),
  .Cb(Cb),
  .Cr(Cr),
  .R_out(R_out2), 
  .G_out(G_out2),
  .B_out(B_out2),
  .eh_verde(verde2), 
  .Y_dec(Y_verde2)
);

colorTracker red_tracker(
    .clk(CLOCK_24),
    .SW(SW),
    .R(R_aux),
    .G(G_aux),
    .B(B_aux),
    .reg_min(0),
    .reg_max(10'd161),
    .eh_verde(verde_aux),
    .x(next_x), 
    .y(next_y), 
    .regiao_detectada(red_flag)
);

colorTracker green_tracker(
    .clk(CLOCK_24),
    .SW(SW),
    .R(R_aux),
    .G(G_aux),
    .B(B_aux),
    .reg_min(10'd160),
    .reg_max(10'd321),
    .eh_verde(verde_aux),
    .x(next_x), 
    .y(next_y), 
    .regiao_detectada(green_flag)
);

colorTracker yellow_tracker(
    .clk(CLOCK_24),
    .SW(SW),
    .R(R_aux),
    .G(G_aux),
    .B(B_aux),
    .reg_min(10'd320),
    .reg_max(10'd479),
    .eh_verde(verde_aux),
    .x(next_x), 
    .y(next_y), 
    .regiao_detectada(yellow_flag)
);

colorTracker blue_tracker(
    .clk(CLOCK_24),
    .SW(SW),
    .R(R_aux),
    .G(G_aux),
    .B(B_aux),
    .reg_min(10'd480),
    .reg_max(10'd639),
    .eh_verde(verde_aux),
    .x(next_x), 
    .y(next_y), 
    .regiao_detectada(blue_flag)
);

framebuffer framebuffer(
  .CLOCK_25(CLOCK_25),
  .CLOCK_24(CLOCK_24),
  .Y_in(Y_enter),
  .en(enable_d),
  .contador_C(contador_C),
  .contador_V(contador_V),
  .Y_out(Y_out)7
);

drawShape rectangle(
  .Y_out(Y_out),
  .x_pos(next_x),
  .y_pos(next_y),                  
  .red_flag(red_flag), 
  .green_flag(0),
  .yellow_flag(0),
  .blue_flag(0),
  .R_in(R_in), 
  .G_in(G_in), 
  .B_in(B_in)
); 

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
  .KEY({red_flag, green_flag, blue_flag, yellow_flag}),
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

vga vga(
  //input
  .VGA_CLK(VGA_CLK),
  .CLOCK_25(CLOCK_25),
  //.CLOCK_50(CLOCK_50),
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

wire [7:0] R_in, B_in, G_in;
reg c, verde_aux; 
reg [7:0] R_aux, G_aux, B_aux;
always @(posedge PCLK) begin //Ajustado o conteúdo gravado na RAM
  c = !c; 
  if(c) begin 
    Y_enter = Y_verde;
    verde_aux = verde; 
    R_aux = R_out;
    G_aux = G_out;
    B_aux = B_out;
  end else begin 
    Y_enter = Y_verde2;
    verde_aux = verde2; 
    R_aux = R_out2;
    G_aux = G_out2;
    B_aux = B_out2;
  end
end 

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

assign R_in = (((next_y > 450) && (next_y <= 458)) 
                || (sprite_ptr1[0] || sprite_ptr1[3]) 
                || (sprite_ptr2[0] || sprite_ptr2[3])
                || (sprite_ptr3[0] || sprite_ptr3[3])
                || (sprite_ptr4[0] || sprite_ptr4[3])
                || (sprite_ptr5[0] || sprite_ptr5[3])
                || (sprite_ptr6[0] || sprite_ptr6[3])
                || (sprite_ptr7[0] || sprite_ptr7[3])
                || (sprite_ptr8[0] || sprite_ptr8[3])) ? 8'b11111111: 8'b00000000;
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

endmodule 