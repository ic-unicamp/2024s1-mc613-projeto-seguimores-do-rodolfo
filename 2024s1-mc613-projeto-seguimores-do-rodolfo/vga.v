module vga(
  output VGA_CLK,
  //input CLOCK_50
  input CLOCK_25,
  input [3:0] KEY,
  input [9:0] SW,
  input [7:0] R_in,
  input [7:0] G_in,
  input [7:0] B_in,
  output VGA_VS,
  output VGA_HS,
  output [9:0] next_x,
  output [9:0] next_y,
  output [7:0] VGA_R,
  output [7:0] VGA_G,
  output [7:0] VGA_B,
  output VGA_SYNC_N,
  output VGA_BLANK_N
  /* output reg VGA_CLK */
);

//assign VGA_CLK = VGA_CLK_aux;
assign VGA_CLK = CLOCK_25;
reg VGA_CLK_aux = 0;

reg [9:0] x;
reg [9:0] y;

reg [9:0] nxt_x;
reg [9:0] nxt_y;

/*always @(posedge CLOCK_50) begin
  VGA_CLK_aux = ~VGA_CLK_aux;
end*/
always @ (posedge VGA_CLK) begin

  if (!KEY[0]) begin
        x = 0;
        y = 0;
    end else begin
        x = x +1;
        if(x >= 142 && x < 800)begin
            nxt_x = x - 142;
        end
        if (x == 800) begin
            x = 0;
            nxt_x = 0;
            y = y + 1;
            if(y >= 35 && y < 525)begin
              nxt_y = y - 35;
            end
            if (y == 525) begin
                y = 0;
                nxt_y = 0;
            end
        end
        
    end
end

wire ativo;
assign ativo = (x > 96) && (y > 2);



assign VGA_HS = (x < 96) ? 0:1;
assign VGA_VS = (y < 2) ? 0:1;

assign VGA_BLANK_N = 1;
assign VGA_SYNC_N = 1;
assign next_x = nxt_x;
assign next_y = nxt_y;
assign VGA_R = (ativo)  ? R_in:0;
assign VGA_G = (ativo)  ? G_in:0;
assign VGA_B = (ativo)  ? B_in:0;


endmodule