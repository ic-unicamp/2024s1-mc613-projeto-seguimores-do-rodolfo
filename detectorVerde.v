module detectorVerde(
    input PCLK,                     // Pixel clock
    input e_pix,                    // Enable read two pixels
    input [7:0] Y,                  // Byte Y output    
    input signed [7:0] Cb,     // Byte Y output  
    input signed [7:0] Cr,     // Byte Y output   

    output reg eh_verde, 
    output reg flag_Y, 
    output reg flag_Cr, 
    output reg flag_G, 
    output reg flag_R, 
    output reg flag_B, 
    output reg [7:0]R_out,
    output reg [7:0]G_out,
    output reg [7:0]B_out,
    output reg [7:0]Y_dec
);


parameter Y_MIN = 8'd140;
parameter Y_MAX = 8'd200;

parameter Cb_MIN = 8'd130; //não estamos utilizando por enquanto 
parameter Cb_MAX = 8'd150;

parameter Cr_MIN = 8'd125;
parameter Cr_MAX = 8'd160;

parameter R_MIN = 8'd0;
parameter R_MAX = 8'd10;

parameter G_MIN = 8'd200;
parameter G_MAX = 8'd255;

parameter B_MIN = 8'd0;
parameter B_MAX = 8'd10;

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


        /*Debug para calibração da câmera */ 
        if (Y > Y_MIN  && Y < Y_MAX ) flag_Y <=1; 
        else flag_Y <=0; 
        if(Cr > Cr_MIN && Cr < Cr_MAX) flag_Cr <=1; 
        else flag_Cr <=0;
        if(G_out > G_MIN && G_out < G_MAX)  flag_G <=1; 
        else flag_G <=0;
        if(R_out > R_MIN && R_out < R_MAX) flag_R <=1; 
        else flag_R <=0;
        if(B_out > B_MIN && B_out < B_MAX) flag_B <=1; 
        else flag_B <=0;

        if( (Cr[7]==1) && (Cb[7]==1) && (Y > Y_MIN  && Y < Y_MAX ) /*&& (Cr > Cr_MIN && Cr <Cr_MAX) && (G_out > G_MIN && G_out < G_MAX) && (R_out > R_MIN && R_out < R_MAX) && (B_out > B_MIN && B_out < B_MAX) */ ) begin
            eh_verde <= 1;
            //Y_out = 8'b0;
/*            Y_dec = {2'b11, Y[7:2]}; */
            Y_dec = 255;
            //Y_dec ={2'b11, Y[7:2]};
        end else begin
            eh_verde <= 0; 
            Y_dec = Y;
/*             Y_dec ={2'b00, Y[7:2]}; */
        end 
    end else eh_verde <= 0; 
end
endmodule