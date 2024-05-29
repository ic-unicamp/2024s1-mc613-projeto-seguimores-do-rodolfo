module camera(
    input CLOCK_24,
    input [3:0] KEY,
    input VSYNC,                     // Horizontal synchronization
    input HREF,                      // Vertical synchronization
    input PCLK,                      // Pixel clock
    input [7:0] D,                    // Video parallel input

    //inout SDIOD,                     // SCCB data

    //output SDIOC,                    // SCCB clock
    output XCLK,                     // System clock
    output RESET,                    // Reset (active low)
    output PWDN,                     // Power down (active high)
    output reg [19:0] CONTADOR_C,    //Camera counter
    output reg e_data,               // Enable Data
    output reg [7:0] Y,                  // Byte Y output    
    output eh_verde
);

    assign XCLK = CLOCK_24;
    assign RESET = KEY[0];
    assign PWDN = 0;

    reg signed [7:0] Cr;
    reg signed [7:0] Cb;

    reg byte_Y; 
    reg byte_Cx;
    always @(posedge PCLK) begin
        if(!RESET) begin 
            e_data <= 0;
            CONTADOR_C <= 0; // Reinicia o contador
            byte_Y <= 0; 
            Y <= 0; 
        end else if (VSYNC) begin 
            e_data <= 0;
            CONTADOR_C <= 0; // Reinicia o contador
            byte_Y <= 0; 
            byte_Cx <= 0;
            Y <= 0; 
        end else if (HREF) begin 
            e_data <= 0;
            byte_Y <= !byte_Y;
            if(byte_Y == 1) begin 
                CONTADOR_C <= CONTADOR_C + 1; // Incrementa o contador
                e_data <= 1;
                Y = D;
            end
            else begin
                byte_Cx <= !byte_Cx;
                if (byte_Cx == 1) Cr = D;
                else Cb = D;
            end     
        end 
    end
         
assign eh_verde = Cb[0] && Cr[0];

endmodule