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
    output reg regiao_detectada
);

parameter WIDTH = 640;
parameter HEIGHT = 480;
parameter REGION_WIDTH = WIDTH / 4;
parameter THRESHOLD = 30000; // Limiar para o número de pixels verdes na região 
parameter THRESHOLD_X = 160; // Limiar para o número de pixels verdes na linha
reg [15:0] green_count; // Contadores para cada região
reg [9:0] x_aux; 
reg [7:0] green_x;
    always @(posedge clk) begin
        if (!SW[0]) begin
            regiao_detectada <= 0;
            green_count <= 0;
        end else if(y== 0 && x==0) begin
            regiao_detectada <= 0; //novo frame
            green_count <= 0;
        end else if(x < reg_max && x > reg_min) begin
            if(eh_verde) green_count <= green_count + 1; //pixel verde na região 
            else green_count <= green_count - 1;  //o pixel não foi reconhecido como verde
            if(x_aux == x) begin 
                if(eh_verde) green_x <= green_x + 1; //pixel verde na linha 
                else green_x <= green_x - 1;  //o pixel não foi reconhecido como verde
            end
        end
        x_aux <= x; 
        if(green_count > THRESHOLD) regiao_detectada <= 1; //encontramos uma porção de pixels verdes (luva)
        else regiao_detectada <= 0;   
    end


endmodule
