module framebuffer(
    input CLOCK_25,
    input CLOCK_24, 
    input wire [7:0] Y_in,
    input wire en, 
    input wire [19:0] contador_C,
    input wire [19:0] contador_V,
    output [7:0] Y_out
);
 

    //wire [7:0] Y_out_aux;

    ram2 mem(
	.data(Y_in),
	.rdclock(CLOCK_25),//25.18Mhz
	.wrclock(CLOCK_24),
	.rdaddress(contador_V),
	.wraddress(contador_C),
	.wren(en),
	.q(Y_out)
    );
    // Definindo a memória RAM
    /* reg [0:2457592] RAM; //640*480 de 16 bits cada */
    /* reg [307199:0] RAM; //640*480 de 16 bits cada

    // Escrevendo na memória RAM
    always @(posedge contador_C) begin
        RAM[contador_C +:8] <= Y_in;
    end

    // Lendo da memória RAM 
    always @(posedge contador_V) begin
        Y_out_aux <= RAM[contador_V +: 8];
    end 

    assign Y_out = Y_out_aux;*/

endmodule