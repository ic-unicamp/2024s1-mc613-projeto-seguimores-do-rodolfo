module detectorVerde(
    input PCLK,                     // Pixel clock
    input e_pix,                    // Enable read two pixels
    input [7:0] Y,                  // Byte Y output    
    input signed wire [7:0] Cb,     // Byte Y output  
    input signed wire [7:0] Cr,     // Byte Y output  
    input [7:0] Y_2,                // Second Byte Y output  

    output reg verde, 
    output reg [7:0]Y_out
);

always @(posedge PCLK) begin 
    if(e_pix) begin 
        if(Cb[0] && Cr[0]) begin 
            verde <= 1;
            Y_out ={2'01, Y[7:2]};
        end else Y_out = Y; 
    end
end