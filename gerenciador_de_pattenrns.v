module gerenciador_de_patterns(
    /* input [3:0] lista_de_comandos [10:0], */
    input trocar_comando,
    input [7:0] fim_da_lista,
    output reg fim_de_jogo,
    output [3:0] prox_comando
); 
reg [3:0] comando;
reg [7:0] index;
wire [3:0] lista_de_comandos [9:0];
assign lista_de_comandos[0] = 0;
assign lista_de_comandos[1] = 0;
assign lista_de_comandos[2] = 0;
assign lista_de_comandos[3] = 1;
assign lista_de_comandos[4] = 1;
assign lista_de_comandos[5] = 1;
assign lista_de_comandos[6] = 1;
assign lista_de_comandos[7] = 1;
assign lista_de_comandos[8] = 1;
assign lista_de_comandos[9] = 1;

reg [1:0] estado_do_jogo; //0 inicio; 1 meio; 2 fim

always @ (posedge trocar_comando) begin
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
        estado_do_jogo = 0;
    end
    default estado_do_jogo = 0;

    endcase
    comando = lista_de_comandos[index];
end

assign prox_comando = comando;



endmodule