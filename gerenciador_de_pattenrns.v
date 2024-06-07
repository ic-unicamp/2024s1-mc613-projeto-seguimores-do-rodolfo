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
wire [3:0] lista_de_comandos [204:0];
assign lista_de_comandos[0] = 0;     // Início da música
assign lista_de_comandos[1] = 1;     // Nota A
assign lista_de_comandos[2] = 2;     // Nota B
assign lista_de_comandos[3] = 3;     // Nota C
assign lista_de_comandos[4] = 4;     // Nota D
assign lista_de_comandos[5] = 3;     // Nota C
assign lista_de_comandos[6] = 2;     // Nota B
assign lista_de_comandos[7] = 1;     // Nota A
assign lista_de_comandos[8] = 0;     // Nota de Pausa
assign lista_de_comandos[9] = 1;     // Nota A
assign lista_de_comandos[10] = 2;    // Nota B
assign lista_de_comandos[11] = 3;    // Nota C
assign lista_de_comandos[12] = 4;    // Nota D
assign lista_de_comandos[13] = 5;    // Nota E
assign lista_de_comandos[14] = 6;    // Nota F
assign lista_de_comandos[15] = 7;    // Nota G
assign lista_de_comandos[16] = 6;    // Nota F
assign lista_de_comandos[17] = 5;    // Nota E
assign lista_de_comandos[18] = 4;    // Nota D
assign lista_de_comandos[19] = 3;    // Nota C
assign lista_de_comandos[20] = 2;    // Nota B
assign lista_de_comandos[21] = 1;    // Nota A
assign lista_de_comandos[22] = 0;    // Nota de Pausa
assign lista_de_comandos[23] = 1;    // Nota A
assign lista_de_comandos[24] = 3;    // Nota C
assign lista_de_comandos[25] = 5;    // Nota E
assign lista_de_comandos[26] = 7;    // Nota G
assign lista_de_comandos[27] = 8;    // Nota H
assign lista_de_comandos[28] = 7;    // Nota G
assign lista_de_comandos[29] = 5;    // Nota E
assign lista_de_comandos[30] = 3;    // Nota C
assign lista_de_comandos[31] = 1;    // Nota A
assign lista_de_comandos[32] = 0;    // Nota de Pausa
assign lista_de_comandos[33] = 1;    // Nota A
assign lista_de_comandos[34] = 3;    // Nota C
assign lista_de_comandos[35] = 5;    // Nota E
assign lista_de_comandos[36] = 7;    // Nota G
assign lista_de_comandos[37] = 8;    // Nota H
assign lista_de_comandos[38] = 7;    // Nota G
assign lista_de_comandos[39] = 5;    // Nota E
assign lista_de_comandos[40] = 3;    // Nota C
assign lista_de_comandos[41] = 1;    // Nota A
assign lista_de_comandos[42] = 0;    // Nota de Pausa
assign lista_de_comandos[43] = 1;    // Nota A
assign lista_de_comandos[44] = 2;    // Nota B
assign lista_de_comandos[45] = 3;    // Nota C
assign lista_de_comandos[46] = 4;    // Nota D
assign lista_de_comandos[47] = 5;    // Nota E
assign lista_de_comandos[48] = 6;    // Nota F
assign lista_de_comandos[49] = 7;    // Nota G
assign lista_de_comandos[50] = 8;    // Nota H
assign lista_de_comandos[51] = 7;    // Nota G
assign lista_de_comandos[52] = 6;    // Nota F
assign lista_de_comandos[53] = 5;    // Nota E
assign lista_de_comandos[54] = 4;    // Nota D
assign lista_de_comandos[55] = 3;    // Nota C
assign lista_de_comandos[56] = 2;    // Nota B
assign lista_de_comandos[57] = 1;    // Nota A
assign lista_de_comandos[58] = 0;    // Nota de Pausa
assign lista_de_comandos[59] = 1;    // Nota A
assign lista_de_comandos[60] = 2;    // Nota B
assign lista_de_comandos[61] = 3;    // Nota C
assign lista_de_comandos[62] = 4;    // Nota D
assign lista_de_comandos[63] = 5;    // Nota E
assign lista_de_comandos[64] = 6;    // Nota F
assign lista_de_comandos[65] = 7;    // Nota G
assign lista_de_comandos[66] = 8;    // Nota H
assign lista_de_comandos[67] = 7;    // Nota G
assign lista_de_comandos[68] = 6;    // Nota F
assign lista_de_comandos[69] = 5;    // Nota E
assign lista_de_comandos[70] = 4;    // Nota D
assign lista_de_comandos[71] = 3;    // Nota C
assign lista_de_comandos[72] = 2;    // Nota B
assign lista_de_comandos[73] = 1;    // Nota A
assign lista_de_comandos[74] = 0;    // Nota de Pausa
assign lista_de_comandos[75] = 1;    // Nota A
assign lista_de_comandos[76] = 3;    // Nota C
assign lista_de_comandos[77] = 5;    // Nota E
assign lista_de_comandos[78] = 7;    // Nota G
assign lista_de_comandos[79] = 8;    // Nota H
assign lista_de_comandos[80] = 7;    // Nota G
assign lista_de_comandos[81] = 5;    // Nota E
assign lista_de_comandos[82] = 3;    // Nota C
assign lista_de_comandos[83] = 1;    // Nota A
assign lista_de_comandos[84] = 0;    // Nota de Pausa
assign lista_de_comandos[85] = 1;    // Nota A
assign lista_de_comandos[86] = 2;    // Nota B
assign lista_de_comandos[87] = 3;    // Nota C
assign lista_de_comandos[88] = 4;    // Nota D
assign lista_de_comandos[89] = 5;    // Nota E
assign lista_de_comandos[90] = 6;    // Nota F
assign lista_de_comandos[91] = 7;    // Nota G
assign lista_de_comandos[92] = 8;    // Nota H
assign lista_de_comandos[93] = 7;    // Nota G
assign lista_de_comandos[94] = 6;    // Nota F
assign lista_de_comandos[95] = 5;    // Nota E
assign lista_de_comandos[96] = 4;    // Nota D
assign lista_de_comandos[97] = 3;    // Nota C
assign lista_de_comandos[98] = 2;    // Nota B
assign lista_de_comandos[99] = 1;    // Nota A
assign lista_de_comandos[100] = 0;   // Fim da música
assign lista_de_comandos[101] = 7;   // Nota G
assign lista_de_comandos[102] = 6;   // Nota F
assign lista_de_comandos[103] = 5;   // Nota E
assign lista_de_comandos[104] = 4;   // Nota D
assign lista_de_comandos[105] = 3;   // Nota C
assign lista_de_comandos[106] = 2;   // Nota B
assign lista_de_comandos[107] = 1;   // Nota A
assign lista_de_comandos[108] = 0;   // Nota de Pausa
assign lista_de_comandos[109] = 1;   // Nota A
assign lista_de_comandos[110] = 2;   // Nota B
assign lista_de_comandos[111] = 1;   // Nota A
assign lista_de_comandos[112] = 0;   // Nota de Pausa
assign lista_de_comandos[113] = 1;   // Nota A
assign lista_de_comandos[114] = 2;   // Nota B
assign lista_de_comandos[115] = 3;   // Nota C
assign lista_de_comandos[116] = 4;   // Nota D
assign lista_de_comandos[117] = 3;   // Nota C
assign lista_de_comandos[118] = 2;   // Nota B
assign lista_de_comandos[119] = 1;   // Nota A
assign lista_de_comandos[120] = 0;   // Nota de Pausa
assign lista_de_comandos[121] = 1;   // Nota A
assign lista_de_comandos[122] = 3;   // Nota C
assign lista_de_comandos[123] = 5;   // Nota E
assign lista_de_comandos[124] = 4;   // Nota D
assign lista_de_comandos[125] = 2;   // Nota B
assign lista_de_comandos[126] = 0;   // Nota de Pausa
assign lista_de_comandos[127] = 3;   // Nota C
assign lista_de_comandos[128] = 5;   // Nota E
assign lista_de_comandos[129] = 7;   // Nota G
assign lista_de_comandos[130] = 8;   // Nota H
assign lista_de_comandos[131] = 7;   // Nota G
assign lista_de_comandos[132] = 5;   // Nota E
assign lista_de_comandos[133] = 3;   // Nota C
assign lista_de_comandos[134] = 1;   // Nota A
assign lista_de_comandos[135] = 0;   // Nota de Pausa
assign lista_de_comandos[136] = 1;   // Nota A
assign lista_de_comandos[137] = 3;   // Nota C
assign lista_de_comandos[138] = 5;   // Nota E
assign lista_de_comandos[139] = 4;   // Nota D
assign lista_de_comandos[140] = 2;   // Nota B
assign lista_de_comandos[141] = 0;   // Nota de Pausa
assign lista_de_comandos[142] = 3;   // Nota C
assign lista_de_comandos[143] = 5;   // Nota E
assign lista_de_comandos[144] = 7;   // Nota G
assign lista_de_comandos[145] = 8;   // Nota H
assign lista_de_comandos[146] = 7;   // Nota G
assign lista_de_comandos[147] = 5;   // Nota E
assign lista_de_comandos[148] = 3;   // Nota C
assign lista_de_comandos[149] = 1;   // Nota A
assign lista_de_comandos[150] = 0;   // Nota de Pausa
assign lista_de_comandos[151] = 1;   // Nota A
assign lista_de_comandos[152] = 3;   // Nota C
assign lista_de_comandos[153] = 5;   // Nota E
assign lista_de_comandos[154] = 4;   // Nota D
assign lista_de_comandos[155] = 2;   // Nota B
assign lista_de_comandos[156] = 0;   // Nota de Pausa
assign lista_de_comandos[157] = 3;   // Nota C
assign lista_de_comandos[158] = 5;   // Nota E
assign lista_de_comandos[159] = 7;   // Nota G
assign lista_de_comandos[160] = 8;   // Nota H
assign lista_de_comandos[161] = 7;   // Nota G
assign lista_de_comandos[162] = 5;   // Nota E
assign lista_de_comandos[163] = 3;   // Nota C
assign lista_de_comandos[164] = 1;   // Nota A
assign lista_de_comandos[165] = 0;   // Nota de Pausa
assign lista_de_comandos[166] = 1;   // Nota A
assign lista_de_comandos[167] = 3;   // Nota C
assign lista_de_comandos[168] = 5;   // Nota E
assign lista_de_comandos[169] = 4;   // Nota D
assign lista_de_comandos[170] = 2;   // Nota B
assign lista_de_comandos[171] = 0;   // Nota de Pausa
assign lista_de_comandos[172] = 3;   // Nota C
assign lista_de_comandos[173] = 5;   // Nota E
assign lista_de_comandos[174] = 7;   // Nota G
assign lista_de_comandos[175] = 8;   // Nota H
assign lista_de_comandos[176] = 7;   // Nota G
assign lista_de_comandos[177] = 5;   // Nota E
assign lista_de_comandos[178] = 3;   // Nota C
assign lista_de_comandos[179] = 1;   // Nota A
assign lista_de_comandos[180] = 0;   // Nota de Pausa
assign lista_de_comandos[181] = 8;    // Nota H
assign lista_de_comandos[182] = 9;    // Nota I
assign lista_de_comandos[183] = 10;   // Nota J
assign lista_de_comandos[184] = 11;   // Nota K
assign lista_de_comandos[185] = 12;   // Nota L
assign lista_de_comandos[186] = 13;   // Nota M
assign lista_de_comandos[187] = 14;   // Nota N
assign lista_de_comandos[188] = 15;   // Nota O
assign lista_de_comandos[189] = 14;   // Nota N
assign lista_de_comandos[190] = 13;   // Nota M
assign lista_de_comandos[191] = 12;   // Nota L
assign lista_de_comandos[192] = 11;   // Nota K
assign lista_de_comandos[193] = 10;   // Nota J
assign lista_de_comandos[194] = 9;    // Nota I
assign lista_de_comandos[195] = 8;    // Nota H
assign lista_de_comandos[196] = 7;    // Nota G
assign lista_de_comandos[197] = 6;    // Nota F
assign lista_de_comandos[198] = 5;    // Nota E
assign lista_de_comandos[199] = 4;    // Nota D
assign lista_de_comandos[200] = 3;    // Nota C
assign lista_de_comandos[201] = 2;    // Nota B
assign lista_de_comandos[202] = 1;    // Nota A

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