module colorTracker (
    input wire clk,
    input wire eh_verde,
    input wire [3:0] SW,
    input wire [7:0] R,
    input wire [7:0] G,
    input wire [7:0] B,
    input wire [1:0] region, //0 - red, 1-green, 2-yellow, 3-blue
    input wire [9:0] reg_min, //Início da região
    input wire [9:0] reg_max, //Fim da região
    input wire [9:0] x, // posição x do pixel
    input wire [9:0] y, // posição y do pixel
    output reg red_secao, //flag para indicar se a região foi detectada
    output reg regiao_detectada
);

parameter WIDTH = 640;
parameter HEIGHT = 480;
parameter REGION_WIDTH = WIDTH / 4;
parameter THRESHOLD = 20; // Limiar para o número de pixels verdes na região 
//parameter THRESHOLD_X = 160; // Limiar para o número de pixels verdes na linha
reg [15:0] green_count; // Contadores para cada região

reg[4:0] count; // Contador de pixels verdes na coluna
//reg [7:0] green_x;
    always @(posedge clk) begin
        if (!SW[0]) begin
            red_secao <= 0;
            regiao_detectada <= 0;
            green_count <= 0;
        end else if(y== 0 && x==0) begin
            red_secao <= 0;
            regiao_detectada <= 0; //novo frame
            green_count <= 0;
        end else if(x < reg_max && x > reg_min) begin
            if(count == 5'b10100) begin 
                green_count <= 0; //não encontramos pixels verdes na coluna
                count <= 0;
            end else if(eh_verde) begin 
                if(x == reg_min + 10) begin 
                    count <= count + 1; //pixel verde na coluna
                    green_count <= green_count + 1; //pixel verde na região 
                end
            end
        end
        if(green_count > THRESHOLD) begin 
            regiao_detectada <= 1; //encontramos uma porção de pixels verdes (luva)
            red_secao <= 1;
        end else regiao_detectada <= 0;   
    end
endmodule
