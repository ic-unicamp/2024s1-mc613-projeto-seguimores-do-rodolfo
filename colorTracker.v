module colorTracker (
    input wire clk,
    input wire verde,
    input wire [3:0] SW,
    input wire [7:0] R,
    input wire [7:0] G,
    input wire [7:0] B,
    input wire [9:0] x, // posição x do pixel
    input wire [9:0] y, // posição y do pixel
    output reg [3:0] verde_detectado
);

parameter WIDTH = 640;
parameter HEIGHT = 480;
parameter REGION_WIDTH = WIDTH / 4;
parameter THRESHOLD = 20000; // Limiar para o número de pixels verdes

// Contadores para pixels verdes em cada região
reg [15:0] green_count_0;
reg [15:0] green_count_1;
reg [15:0] green_count_2;
reg [15:0] green_count_3;

always @(posedge clk) begin
    if (!SW[0]) begin
        verde_detectado <= 4'b0000;
        green_count_0 <=0; 
        green_count_1 <=0;
        green_count_2 <=0;
        green_count_3 <=0;
    end else begin 
        if(y== 0 && x==0)begin
            green_count_0 <=0; 
            green_count_1 <=0;
            green_count_2 <=0;
            green_count_3 <=0;

        end else if(verde) begin
            if (x < REGION_WIDTH) green_count_0 <= green_count_0 + 1; // peça vermelha

            else if (x < 2 * REGION_WIDTH) green_count_1 <= green_count_1 + 1; //peça verde

            else if (x < 3 * REGION_WIDTH) green_count_2 <= green_count_2 + 1; //peça azul

            else if (x < 4 * REGION_WIDTH) green_count_3 <= green_count_3 + 1; //peça amarela 

            if(green_count_0 > THRESHOLD) verde_detectado[0] <= 1; 
            else verde_detectado[0] <= 0;

            if(green_count_1 > THRESHOLD) verde_detectado[1] <= 1; 
            else verde_detectado[1] <= 0;

            if(green_count_2 > THRESHOLD) verde_detectado[2] <= 1; 
            else verde_detectado[2] <= 0;

            if(green_count_3 > THRESHOLD) verde_detectado[3] <= 1; 
            else verde_detectado[3] <= 0;            
        end   
    end  
end

endmodule
