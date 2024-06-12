module suavizador(
    input PCLK,
    input VSYNC, 
    input [9:0] centroX,
    output reg en,
    output reg [3:0] green_region
); 
reg [3:0] counter_blue, counter_yellow, counter_green, counter_red; 
reg [3:0] count; 
always@(posedge PCLK) begin 
    if(VSYNC) begin 
        if(count == 4'b1010) begin
            count <= 4'b0000; 
            // Atribuir valores a green_region com base em intervalos para os contadores
            green_region[0] <= (counter_red > 6) ? 1'b1 : 1'b0;
            green_region[1] <= (counter_green > 6) ? 1'b1 : 1'b0;
            green_region[2] <= (counter_yellow > 6) ? 1'b1 : 1'b0;
            green_region[3] <= (counter_blue > 6) ? 1'b1 : 1'b0;

            en <= 1; 

            counter_red <= 0;
            counter_green <= 0;
            counter_yellow <= 0;
            counter_blue <= 0;
        end else begin
        // Incrementar os contadores
        en <= 0; 
        counter_red <= (centroX < 161) ? counter_red + 1 : 0;
        counter_green <= (centroX > 160  && centroX < 321) ? counter_green + 1 : 0;
        counter_yellow <= (centroX > 320 && centroX < 479)? counter_yellow + 1 : 0;
        counter_blue <= (centroX > 480 && centroX< 639) ? counter_blue + 1 : 0;  
        count <= count + 1; 
        end 
    end 
end 

endmodule