module conversorBin7Seg(
    input [3:0] numero,
    output reg [6:0] segmentos
);

always @(numero)
begin
    case(numero)
        4'b0000: segmentos = 7'b1000000; // 0
        4'b0001: segmentos = 7'b1111001; // 1
        4'b0010: segmentos = 7'b0100100; // 2
        4'b0011: segmentos = 7'b0110000; // 3
        4'b0100: segmentos = 7'b0011001; // 4
        4'b0101: segmentos = 7'b0010010; // 5
        4'b0110: segmentos = 7'b0000010; // 6
        4'b0111: segmentos = 7'b1111000; // 7
        4'b1000: segmentos = 7'b0000000; // 8
        4'b1001: segmentos = 7'b0010000; // 9
        //Vamos trabalhar somente com decimais
        /*4'b1010: segmentos = 7'b0001001; //A
        4'b1011: segmentos = 7'b1100000; //b
        4'b1100: segmentos = 7'b0110001; //C
        4'b1101: segmentos = 7'b1000010; //d
        4'b1110: segmentos = 7'b0110000; //E
        4'b1111: segmentos = 7'b0111000; //F*/ 
        default: segmentos = 7'b0000000; // Entrada inválida
    endcase
end

endmodule