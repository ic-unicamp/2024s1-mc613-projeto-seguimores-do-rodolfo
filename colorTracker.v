module colorTracker (
    input wire clk,
    input wire eh_verde,
    input wire [3:0] SW,
    input wire [7:0] R,
    input wire [7:0] G,
    input wire [7:0] B,
    input wire [1:0] region, //0 - red, 1-green, 2-yellow, 3-blue
    input wire [9:0] x, // posição x do pixel
    input wire [9:0] y, // posição y do pixel
    output reg vga_section,
    output reg regiao_detectada
);

parameter WIDTH = 640;
parameter HEIGHT = 480;
parameter REGION_WIDTH = WIDTH / 4;
parameter THRESHOLD = 12000; // Limiar para o número de pixels verdes

// Contador para pixels verdes
reg [15:0] green_count;


always @(posedge clk) begin
    if (!SW[0]) begin
        vga_section <=0; 
        regiao_detectada <= 0;
        green_count <=0; 
    end else if(y== 0 && x==0) begin
        vga_section <= 0; 
        regiao_detectada <= 0;
        green_count <=0; 
        end else if(eh_verde) begin
            case (region)
                2'b00: begin
                   if (x < REGION_WIDTH) begin
                        vga_section <=1;
                        green_count <= green_count + 1; 
                   end
                end 
                2'b01: begin
                   if (x > REGION_WIDTH && (x < 2 * REGION_WIDTH) ) begin
                        vga_section <=1;
                        green_count <= green_count + 1; 
                   end
                end 
                2'b10: begin
                   if ((x > 2 * REGION_WIDTH) && (x < 3 * REGION_WIDTH) ) begin
                        vga_section <=1;
                        green_count <= green_count + 1; 
                   end
                end 
                2'b11: begin
                   if ((x > 3 * REGION_WIDTH) && (x < 4 * REGION_WIDTH) )begin
                        vga_section <=1;
                        green_count <= green_count + 1; 
                   end
                end
            endcase 
            if(green_count > THRESHOLD && green_count < 1111_1111_1111_1111) regiao_detectada <= 1; 
            else regiao_detectada <= 0;          
        end else regiao_detectada <= 0;   
end

endmodule
