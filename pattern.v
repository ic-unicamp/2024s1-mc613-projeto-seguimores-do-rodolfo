module pattern (
    input CLOCK_24,
    input [3:0] command_in,
    input [7:0] y_ini_pos,
    input reset,
    input next_x,
    input next_y,
    
    output [3:0] command_out,
    output [7:0] y_pos,
    output [3:0] sprite_pattern
);
// cada sprite vai ser responsável por verificar se a pessoa pontuou e emitira um sinal booleano

// k é a cordenada vertical central do padrão
reg [27:0] contador = 0;

always @(posedge CLOCK_24) begin
    contador <= contador + 1;

    if (contador == 800_000) begin
        contador <= 0;
        if (reset) begin
            y_pos <= y_ini_pos;
        end else begin
            y_pos <= y_pos + 1;
        end
        
        // A verificação se o sprite chegou a fim da tela será feita no top, que tbm mudará o padrão
    end
end


assign sprite_pattern[0] = command_in[0] && (next_y >= y_pos - 8 ) && (next_y < y_pos + 8) && (next_x < 160) && (next_x >= 0) ; // vermelho
assign sprite_pattern[1] = command_in[1] && (next_y >= y_pos - 8 ) && (next_y < y_pos + 8) && (next_x < 320) && (next_x >= 160) ; // verde
assign sprite_pattern[2] = command_in[2] && (next_y >= y_pos - 8 ) && (next_y < y_pos + 8) && (next_x < 480) && (next_x >= 320) ; // azul
assign sprite_pattern[3] = command_in[3] && (next_y >= y_pos - 8 ) && (next_y < y_pos + 8) && (next_x < 640) && (next_x >= 480) ; // amarelo

endmodule