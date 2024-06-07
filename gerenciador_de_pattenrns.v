module gerenciador_de_patterns(
    /* input [3:0] lista_de_comandos [10:0], */
    input trocar_comando,
    input rst,
    input [7:0] fim_da_lista,
    output reg fim_de_jogo,
    output [3:0] prox_comando
); 
reg [3:0] comando;
reg [7:0] index;
wire [3:0] lista_de_comandos [50:0];
assign lista_de_comandos[0] = 0;
assign lista_de_comandos[1] = 1;
assign lista_de_comandos[2] = 2;
assign lista_de_comandos[3] = 4;
assign lista_de_comandos[4] = 8;
assign lista_de_comandos[5] = 1;
assign lista_de_comandos[6] = 2;
assign lista_de_comandos[7] = 4;
assign lista_de_comandos[8] = 8;
assign lista_de_comandos[9] = 1;
assign lista_de_comandos[10] = 2;
assign lista_de_comandos[11] = 4;
assign lista_de_comandos[12] = 8;
assign lista_de_comandos[13] = 1;
assign lista_de_comandos[14] = 2;
assign lista_de_comandos[15] = 4;
assign lista_de_comandos[16] = 8;
assign lista_de_comandos[17] = 1;
assign lista_de_comandos[18] = 2;
assign lista_de_comandos[19] = 4;
assign lista_de_comandos[20] = 8;
assign lista_de_comandos[21] = 1;
assign lista_de_comandos[22] = 2;
assign lista_de_comandos[23] = 4;
assign lista_de_comandos[24] = 8;
assign lista_de_comandos[25] = 1;
assign lista_de_comandos[26] = 2;
assign lista_de_comandos[27] = 4;
assign lista_de_comandos[28] = 8;
assign lista_de_comandos[29] = 1;
assign lista_de_comandos[30] = 2;
assign lista_de_comandos[31] = 4;
assign lista_de_comandos[32] = 8;
assign lista_de_comandos[33] = 1;
assign lista_de_comandos[34] = 2;
assign lista_de_comandos[35] = 4;
assign lista_de_comandos[36] = 8;
assign lista_de_comandos[37] = 1;
assign lista_de_comandos[38] = 2;
assign lista_de_comandos[39] = 4;
assign lista_de_comandos[40] = 8;
assign lista_de_comandos[41] = 1;
assign lista_de_comandos[42] = 2;
assign lista_de_comandos[43] = 4;
assign lista_de_comandos[44] = 8;
assign lista_de_comandos[45] = 1;
assign lista_de_comandos[46] = 2;
assign lista_de_comandos[47] = 4;
assign lista_de_comandos[48] = 8;
assign lista_de_comandos[49] = 1;
assign lista_de_comandos[50] = 2;

reg [1:0] estado_do_jogo; //0 inicio; 1 meio; 2 fim

always @ (posedge trocar_comando) begin
    if (rst) estado_do_jogo = 0;
    case (estado_do_jogo)
    0: begin
        index = 0;
        estado_do_jogo = 1;
        fim_de_jogo = 0;
    end
    1: begin
        index = index + 1;
        if (index == fim_da_lista) estado_do_jogo = 2;
    end
    2: begin 
        fim_de_jogo = 1;
    end
    default estado_do_jogo = 0;

    endcase
    comando = lista_de_comandos[index];
end

assign prox_comando = comando;



endmodule