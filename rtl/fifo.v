// FIFO Buffer
module fifo(
    input clk,              // Clock (reloj)
    input rst,              // Reset (reinicio)
    input wr_en,            // Write enable (habilitación de escritura)
    input rd_en,            // Read enable (habilitación de lectura)
    input [7:0] din,        // Data input (dato de entrada)
    output reg [7:0] dout,  // Data output (dato de salida)
    output reg full,        // Full flag (bandera de lleno)
    output reg empty        // Empty flag (bandera de vacío)
);

    // Internal memory (memoria interna)
    // 4 positions (posiciones), each one 8 bits wide (cada una de 8 bits)
    reg [7:0] mem [0:3];

    // Write pointer (puntero de escritura)
    reg [1:0] wr_ptr;

    // Read pointer (puntero de lectura)
    reg [1:0] rd_ptr;

    // Count of stored elements (contador de elementos almacenados)
    // Needs 3 bits because it must represent values from 0 to 4
    reg [2:0] count;

    // Initial values for simulation (valores iniciales para simulación)
    initial begin
        dout   = 8'b00000000; // Output starts at 0 (la salida inicia en 0)
        full   = 1'b0;        // FIFO is not full at the beginning (no está llena al inicio)
        empty  = 1'b1;        // FIFO is empty at the beginning (está vacía al inicio)
        wr_ptr = 2'b00;       // Write pointer starts at position 0
        rd_ptr = 2'b00;       // Read pointer starts at position 0
        count  = 3'b000;      // No stored elements at the beginning
    end

    always @(posedge clk) begin
        if (rst) begin
            dout   <= 8'b00000000;
            full   <= 1'b0;
            empty  <= 1'b1;
            wr_ptr <= 2'b00;
            rd_ptr <= 2'b00;
            count  <= 3'b000;
        end
        else begin
            // Write if enabled and FIFO is not full (escribir si está habilitado y no está llena)
            if (wr_en == 1'b1 && full == 1'b0) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1'b1;
                count <= count + 1'b1;
            end

            // Read if enabled and FIFO is not empty (leer si está habilitado y no está vacía)
            if (rd_en == 1'b1 && empty == 1'b0) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
                count <= count - 1'b1;
            end

            // Update empty flag (actualizar bandera de vacío)
            if (count == 3'b000)
                empty <= 1'b1;
            else
                empty <= 1'b0;

            // Update full flag (actualizar bandera de lleno)
            if (count == 3'b100)
                full <= 1'b1;
            else
                full <= 1'b0;
        end
    end

endmodule
