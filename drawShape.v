module drawShape(
    input clk,
    input [9:0] x_pos,
    input [9:0] y_pos,                 
    input flag,     //flag que identifica a luva em uma região
    input wire [9:0] reg_min, //Início da região

    output reg rectangle
);

// Dimensões do retângulo
reg [9:0] rectangle_x, rectangle_y, rectangle_width, rectangle_height;

always @(posedge clk) begin
        if (flag) begin
            rectangle_x = reg_min;
            rectangle_y = 0;
            rectangle_width = 160; // 1/4 da resolução horizontal
            rectangle_height = 480; 
        end else begin 
            rectangle_x = 0;
            rectangle_y = 0;
            rectangle_width = 0;
            rectangle_height = 0;
        end
        rectangle = (x_pos > rectangle_x) && (x_pos < rectangle_x + rectangle_width) && (y_pos > rectangle_y) && (y_pos < rectangle_y + rectangle_height);
end

endmodule