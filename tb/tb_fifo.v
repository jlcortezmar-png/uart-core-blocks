// Testbench for FIFO Buffer (banco de pruebas para el buffer FIFO)
module tb;

    // Inputs to the DUT (Device Under Test, dispositivo bajo prueba)
    reg clk;               // Clock (reloj)
    reg rst;               // Reset (reinicio)
    reg wr_en;             // Write enable (habilitación de escritura)
    reg rd_en;             // Read enable (habilitación de lectura)
    reg [7:0] din;         // Data input (dato de entrada)

    // Outputs from the DUT
    wire [7:0] dout;       // Data output (dato de salida)
    wire full;             // Full flag (bandera de lleno)
    wire empty;            // Empty flag (bandera de vacío)

    // DUT instantiation (instancia del módulo bajo prueba)
    fifo dut(
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock generation (generación de reloj)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Dump waveform file (archivo de waveform / forma de onda)
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    // Stimulus (estímulos)
    initial begin
        // Initial values (valores iniciales)
        rst   = 1'b1;
        wr_en = 1'b0;
        rd_en = 1'b0;
        din   = 8'b00000000;

        // Release reset (liberar reinicio)
        #10 rst = 1'b0;

        // Write first data (escribir primer dato)
        #10;
        wr_en = 1'b1;
        din   = 8'hA5;

        // Write second data (escribir segundo dato)
        #10;
        din   = 8'h3C;

        // Write third data (escribir tercer dato)
        #10;
        din   = 8'hF0;

        // Stop writing (dejar de escribir)
        #10;
        wr_en = 1'b0;

        // Read first data (leer primer dato)
        #10;
        rd_en = 1'b1;

        // Read second data (leer segundo dato)
        #10;

        // Read third data (leer tercer dato)
        #10;

        // Stop reading (dejar de leer)
        #10;
        rd_en = 1'b0;

        // Write until full (escribir hasta llenar)
        #10;
        wr_en = 1'b1; din = 8'h11;
        #10;
        din = 8'h22;
        #10;
        din = 8'h33;
        #10;
        din = 8'h44;

        // Stop writing
        #10;
        wr_en = 1'b0;

        // Read until empty (leer hasta vaciar)
        #10;
        rd_en = 1'b1;
        #40;
        rd_en = 1'b0;

        // Finish simulation (terminar simulación)
        #20 $finish;
    end

    // Monitor signals (monitorear señales)
    initial begin
        $monitor("t=%0t clk=%b rst=%b wr_en=%b rd_en=%b din=%h dout=%h full=%b empty=%b",
                 $time, clk, rst, wr_en, rd_en, din, dout, full, empty);
    end

endmodule
