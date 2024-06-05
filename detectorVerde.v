module detectorVerde(
    input PCLK,                // Pixel clock
    input e_pix,               // Enable read two pixels
    input [7:0] Y,             // Byte Y input    
    input signed [7:0] Cb,     // Byte Y input  
    input [7:0] Cr,            // Byte Y input  

    output reg verde,           //Flag de deteccao da cor verde
    output reg [7:0] Y_out      //Luminancia alterada
);

always @(posedge PCLK) begin
    verde <= 0; 
    if(e_pix) begin
    //Temos todas as informacoes do pixel 
        if(Cb[0] && Cr[0]) begin
            verde <= 1; 
            Y_out = {2'b01, Y[7:2]}; //Indicador de que o pixel eh de um objeto da cor verde
        end else Y_out = Y; 
    end
end 
endmodule