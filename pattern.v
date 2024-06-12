module pattern (
    input CLOCK_25,
    input [3:0] KEY,
    input [3:0] command_in,
    //input [3:0] command_player,
    input [9:0] y_ini_pos,
    input reset,
    input [9:0] next_x,
    input [9:0] next_y,
    
    output [3:0] command_out,
    output reg ponto = 0,
    output reg [9:0] y_pos = y_ini_pos,
    output [3:0] sprite_pattern,
    output reg trocar
);
// cada sprite vai ser responsável por verificar se a pessoa pontuou e emitira um sinal booleano

// k é a cordenada vertical central do padrão
reg [3:0] command_in_aux;

wire [3:0] command_player;
assign command_player[0] = KEY[0];
assign command_player[1] = KEY[1];
assign command_player[2] = KEY[2];
assign command_player[3] = KEY[3];

reg [27:0] contador = 0;
reg ITS_FIRST_SCREEN = 1;
reg TENTOU = 0;

always @(posedge CLOCK_25) begin
    if (reset) ITS_FIRST_SCREEN = 1;
    contador <= contador + 1;
    if (trocar == 1) begin
        command_in_aux = command_in;
        trocar = 0;
    end

    case (ITS_FIRST_SCREEN)
    1: begin 
        ITS_FIRST_SCREEN = 0;
        y_pos = y_ini_pos;
    end
    0: begin
        if (contador == 200000) begin
            ponto = 0;
            contador <= 0;
            if (reset) begin
                y_pos = y_ini_pos;
            end
            else if (y_pos >= 480) begin
                y_pos = 0;
                trocar = 1;
                TENTOU = 0;
            end else begin
                y_pos = y_pos + 1;
            end

            // A verificação se o sprite chegou a fim da tela será feita no top, que tbm mudará o padrão
        end

        if (y_pos >= 420 && y_pos <= 452) begin

            case(TENTOU) 
                0: begin
                        if (command_player != 0) begin
                            if (command_player == command_in_aux) begin
                                ponto = 1;
                                TENTOU = 1;
                            end
                        end
                    end
                1: begin
                    if (y_pos <= 40) TENTOU = 0;
                end
                default: begin 
                    TENTOU = 0;
                end
            endcase
        end
    end
    

    default: begin
        ITS_FIRST_SCREEN = 1;
        y_pos = y_ini_pos;
    end
    
    endcase
end

// 450 - 32 < y < 458 + 32 


assign sprite_pattern[0] = command_in_aux[0] && (next_y >= y_pos - 15) && (next_y < y_pos + 15) && (next_x < 160) && (next_x >= 0) ; // vermelho
assign sprite_pattern[1] = command_in_aux[1] && (next_y >= y_pos - 15) && (next_y < y_pos + 15) && (next_x < 320) && (next_x >= 160) ; // verde
assign sprite_pattern[2] = command_in_aux[2] && (next_y >= y_pos - 15) && (next_y < y_pos + 15) && (next_x < 480) && (next_x >= 320) ; // azul
assign sprite_pattern[3] = command_in_aux[3] && (next_y >= y_pos - 15) && (next_y < y_pos + 15) && (next_x < 640) && (next_x >= 480) ; // amarelo

endmodule