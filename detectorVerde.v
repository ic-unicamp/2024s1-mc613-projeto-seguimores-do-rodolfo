module detectorVerde(
<<<<<<< HEAD
    input PCLK,                     // Pixel clock
    input e_pix,                    // Enable read two pixels
    input [7:0] Y,                  // Byte Y output    
    input signed [7:0] Cb,     // Byte Y output  
    input signed [7:0] Cr,     // Byte Y output   

    output reg verde, 
    output reg [7:0]R_out,
    output reg [7:0]G_out,
    output reg [7:0]B_out,
    output reg [7:0]Y_out
);

// Coeficientes convertidos para ponto fixo com precisão de 8 bits
/*parameter COEF1 = 8'd142; // Aproximação de 1.402 * 2^8
parameter COEF2 = 8'd35;  // Aproximação de 0.34414 * 2^8
parameter COEF3 = 8'd73;  // Aproximação de 0.71414 * 2^8
parameter COEF4 = 8'd180; // Aproximação de 1.772 * 2^8*/



reg signed [15:0] Y_signed, Cb_signed, Cr_signed,R_signed,G_signed,B_signed;

always @(posedge PCLK) begin 
    if(e_pix) begin 

        Y_signed = Y;
        Cb_signed = Cb - 128;
        Cr_signed = Cr - 128;

        // R = Y + 1.402 * Cr
        R_signed = Y_signed + ((1436 * Cr_signed) >>> 10); // 1.402 * 1024 = 1436
        // G = Y - 0.34414 * Cb - 0.71414 * Cr
        G_signed = Y_signed - ((352 * Cb_signed) >>> 10) - ((730 * Cr_signed) >>> 10); // 0.34414 * 1024 = 352, 0.71414 * 1024 = 730
        // B = Y + 1.772 * Cb
        B_signed = Y_signed + ((1815 * Cb_signed) >>> 10); // 1.772 * 1024 = 1815
        
        // Results to 8-bit range
        R_out = (R_signed[7:0]);
        G_out = (G_signed[7:0]);
        B_out = (B_signed[7:0]);

        if((G_out - R_out > 70) && (G_out - B_out > 70)) begin
            verde <= 1;
            //Y_out = 8'b0;
            Y_out ={2'b11, Y[7:2]};
        end else begin
            verde <= 0; 
            Y_out = Y;
        end 
    end else verde <= 0; 
end
=======
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
>>>>>>> patterns-sprites
endmodule