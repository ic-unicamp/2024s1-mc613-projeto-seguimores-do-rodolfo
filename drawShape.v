module drawShape(
    input [7:0] Y_out, 
    input [9:0] x_pos,
    input [9:0] y_pos,                  
    input red_flag, 
    input green_flag,
    input yellow_flag,
    input blue_flag,

    output [7:0] R_in, 
    output [7:0] G_in, 
    output [7:0] B_in
);

// Dimensões do retângulo
reg [9:0] rectangle_x, rectangle_y, rectangle_width, rectangle_height;
reg rectangle; 

// Retângulo
always @(x_pos, y_pos, rectangle_x, rectangle_y, rectangle_width, rectangle_height) begin
    rectangle = (x_pos >= rectangle_x) && (x_pos < rectangle_x + rectangle_width) && (y_pos >= rectangle_y) && (y_pos < rectangle_y + rectangle_height);
end

// Lógica para selecionar a cor de uma região 
assign R_in = rectangle && ((red_flag && x_pos < 160) || (yellow_flag && x_pos >= 480)) ? 8'hFF : Y_out;
assign G_in = rectangle && ((green_flag && x_pos >= 160 && x_pos < 320) || (yellow_flag && x_pos >= 480)) ? 8'hFF : Y_out;
assign B_in = rectangle && (blue_flag && x_pos >= 320 && x_pos < 480) ? 8'hFF : Y_out;

always @(red_flag, green_flag, blue_flag, yellow_flag) begin
        if (red_flag) begin
            rectangle_x = 0;
            rectangle_y = 0;
            rectangle_width = 160; // 1/4 da resolução horizontal
            rectangle_height = 480; 
        end else if (green_flag) begin
            rectangle_x = 160;
            rectangle_y = 0;
            rectangle_width = 160; // 1/4 da resolução horizontal
            rectangle_height = 480; 
        end else if (blue_flag) begin
            rectangle_x = 320;
            rectangle_y = 0;
            rectangle_width = 160; // 1/4 da resolução horizontal
            rectangle_height = 480; 
        end else if (yellow_flag) begin
            rectangle_x = 480;
            rectangle_y = 0;
            rectangle_width = 160; // 1/4 da resolução horizontal
            rectangle_height = 480; 
        end
end

endmodule