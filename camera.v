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
    output reg [19:0] CONTADOR_C,   //Camera counter
    output reg e_data,              // Enable Data (Y)
    output reg e_pix,               // Enable read two pixels
    output reg [7:0] Y,             // Byte Y output    
    output [7:0] Cb,     // Byte Y output  
    output [7:0] Cr,     // Byte Y output  
    output reg [7:0] Y_2          // Second Byte Y output  
);

    reg signed [7:0] Cb_aux;
    reg signed [7:0] Cr_aux;

    assign XCLK = CLOCK_24;
    assign RESET = KEY[0];
    assign PWDN = 0;
    assign Cb = Cb_aux;
    assign Cr = Cr_aux;
    reg [1:0] byte_count; //Contador de bytes
    always @(posedge PCLK) begin
        if(!RESET) begin 
            e_data <= 0;
            e_pix <= 0;
            CONTADOR_C <= 0; // Reinicia o contador
            byte_count <= 0; 
            Y <= 0; 
            Y_2 <= 0; 
            Cr_aux <= 0; 
            Cb_aux <= 0; 
        end else if (VSYNC) begin 
            e_data <= 0;
            e_pix <= 0;
            CONTADOR_C <= 0; 
            byte_count <= 0; 
            Y <= 0;
            Y_2 <= 0; 
            Cr_aux <= 0; 
            Cb_aux <= 0; 
        end else if (HREF) begin 
            e_data <= 0;
            e_pix <= 0;
            byte_count <= byte_count + 1; 
            case (byte_count)
                2'b00: Cb_aux = D; //Capturando chroma blue
                2'b01: begin 
                    Y = D; //Capturando luminancia 1
                    CONTADOR_C <= CONTADOR_C + 1; // Incrementa o endereco de escrita do buffer
                    e_data <= 1;
                end
                2'b10: Cr_aux = D; //Capturando chroma red
                2'b11: begin 
                    Y = D; //Enviando a 2a luminancia para a RAM
                    Y_2 = D; //Capturando luminancia 2
                    CONTADOR_C <= CONTADOR_C + 1; // Incrementa o endereco de escrita do buffer
                    e_data <= 1;
                    e_pix <= 1;
                end
            endcase  
        end 
    end    

endmodule