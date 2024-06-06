module placar (
  input [19:0] display,
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3,
  output [6:0] HEX4,
  output [6:0] HEX5
);

//Registradores auxiliares
wire [3:0] dig0;
wire [3:0] dig1;
wire [3:0] dig2;
wire [3:0] dig3;
wire [3:0] dig4;
wire [3:0] dig5;

//Instanciação do módulo conversor de 7 segmentos para os displays
conversorBin7Seg conv0(dig0,HEX0);
conversorBin7Seg conv1(dig1,HEX1);
conversorBin7Seg conv2(dig2,HEX2);
conversorBin7Seg conv3(dig3,HEX3);
conversorBin7Seg conv4(dig4,HEX4);
conversorBin7Seg conv5(dig5,HEX5);

//Instanciação do conversor binário para BCD 
bin2bcd acum(display, bcd);

wire[25:0] bcd; 
assign dig0[3:0] = bcd[3:0];
assign dig1[3:0] = bcd[7:4];
assign dig2[3:0] = bcd[11:8];
assign dig3[3:0] = bcd[15:12];
assign dig4[3:0] = bcd[19:16];
assign dig5[3:0] = bcd[24:20];

endmodule