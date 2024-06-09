module top1(
  input CLOCK_50,
  input [9:0] SW, // para o reset
  // Pinos de propósito geral
  inout [35:0] GPIO_1,

  output VGA_VS,
  output VGA_HS,
  output [7:0] VGA_R,
  output [7:0] VGA_G,
  output [7:0] VGA_B,
  output VGA_SYNC_N,
  output VGA_BLANK_N,
  output VGA_CLK
  
);

wire CLOCK_24, CLOCK_25;


/*wire [3:0] pattern_out_ptr1;
wire [7:0] y_pos_ptr1;
wire [3:0] command_out_ptr1;*/


wire rst = !SW[0];
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

/*pattern ptr1(
  .CLOCK_25(CLOCK_24),
  .command_in(4'b1011),
  .y_ini_pos(640),
  .reset(rst),
  .command_out(command_out),
  .y_pos(y_pos_ptr1),
  .sprite_pattern(pattern_out_ptr1)
);*/

/* assign GPIO_1[31] = CLOCK_24; */

// implemente o circuito aqui
  //wire SDIOC; 
  //wire SDIOD; // passado direto para a camera
  wire XCLK;    
  wire RESET; 
  wire PWDN;       
  wire VSYNC;      
  wire HREF;       
  wire PCLK;
  wire e_pix;

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

  wire [9:0] next_x, next_y;

  wire [7:0] Y_out;
  wire [19:0] contador_V;

  parameter WIDTH = 640;
  parameter HEIGHT = 480;
  parameter REGION_WIDTH = WIDTH / 4;

assign contador_V = next_y * 10'd640 + next_x;

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
wire reg0,reg1, reg2, reg3;
colorTracker red_tracker(
    .clk(CLOCK_24),
    .SW(SW),
    .R(R_aux),
    .G(G_aux),
    .B(B_aux),
    .region(0),
    .vga_section(reg0),
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
    .region(1),
    .vga_section(reg1),
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
    .region(2),
    .vga_section(reg2),
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
    .region(3),
    .vga_section(reg3),
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
  .Y_out(Y_out)
);

/*wire [7:0] R_in, B_in, G_in;


assign R_in = (red_flag || yellow_flag) ? {2'b11, Y_out[7:2]}:{2'b00, Y_out[7:2]}; 
assign G_in = (green_flag || yellow_flag) ? {2'b11, Y_out[7:2]}:{2'b00, Y_out[7:2]}; 
assign B_in = (blue_flag) ? {2'b11, Y_out[7:2]}:{2'b00, Y_out[7:2]}; */

vga vga(
  //input
  .VGA_CLK(VGA_CLK),
  .CLOCK_25(CLOCK_25),
  //.CLOCK_50(CLOCK_50),
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