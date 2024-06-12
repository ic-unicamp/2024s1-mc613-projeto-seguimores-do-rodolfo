module green_mass_center(
    input wire clk,
    input wire eh_verde,
    input wire [3:0] SW,
    input [9:0] x_pos, y_pos,
    output reg [9:0] centroX, centroY
);

reg [19:0] sumX = 0, sumY = 0; // Para evitar overflow
reg [10:0] green_count = 0; // Contador para o número de pixels verdes

always @(posedge clk) begin
    if (!SW[0]) begin
        sumX <= 0;
        sumY <= 0;
        green_count <= 0;
        centroX <= 0;
        centroY <= 0;
    end else if (eh_verde) begin
        sumX <= sumX + x_pos;
        sumY <= sumY + y_pos;
        green_count <= green_count + 1;
    end

    // Atualiza o centro de massa quando todos os pixels da imagem foram processados
    // Isso depende de como você determina o fim de uma imagem/frame
    if (x_pos == 0 && y_pos == 0) begin
        if (green_count > 0) begin
            centroX <= sumX / green_count;
            centroY <= sumY / green_count;
        end
        sumX <= 0;
        sumY <= 0;
        green_count <= 0;
    end
end

endmodule