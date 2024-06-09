module detectorVerde(
    input PCLK,                     // Pixel clock
    input e_pix,                    // Enable read two pixels
    input [7:0] Y,                  // Byte Y output    
    input signed [7:0] Cb,     // Byte Y output  
    input signed [7:0] Cr,     // Byte Y output   

    output reg eh_verde, 
    output reg [7:0]R_out,
    output reg [7:0]G_out,
    output reg [7:0]B_out,
    output reg [7:0]Y_dec
);

// Coeficientes convertidos para ponto fixo com precisão de 8 bits
/*parameter COEF1 = 8'd142; // Aproximação de 1.402 * 2^8
parameter COEF2 = 8'd35;  // Aproximação de 0.34414 * 2^8
parameter COEF3 = 8'd73;  // Aproximação de 0.71414 * 2^8
parameter COEF4 = 8'd180; // Aproximação de 1.772 * 2^8*/



reg signed [15:0] Y_signed, Cb_signed, Cr_signed,R_signed,G_signed,B_signed;

//reg signed [7:0] G_max, G_min = 8'd130, R_max= 8'd90, R_min, B_max= 8'd180, B_min; 

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


        /*(G_out - R_out) > 8'd80
        (B_out - G_out) < 8'd90
        B_out < 8'd247
        R_out < 8'd75*/
        //G_out > 8'd110 && R_out < 8'd75 && B_out < 8'd247 && (B_out - G_out) < 8'd90
        if(Y > 8'd90 && Y < 8'd115 && Cr > 8'd125 && Cr <8'd160 && G_out > 8'd75 && R_out <8'd70 && B_out < 8'd220) begin
            eh_verde <= 1;
            //Y_out = 8'b0;
            Y_dec = {2'b11, Y[7:2]};
            //Y_dec ={2'b11, Y[7:2]};
        end else begin
            eh_verde <= 0; 
            Y_dec ={2'b00, Y[7:2]};
        end 
    end else eh_verde <= 0; 
end
endmodule