// testbench UART

module tb;
    reg clk;
    reg rst;
    reg start;
    reg [7:0] data_in;

    wire tx;
    wire busy;
    wire done;

    uart_tx uut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        rst = 1;
        start = 0;
        data_in = 8'b10100101;

        #10;
        rst = 0;

        #10;
        start = 1;

        #10;
        start = 0;

    end

    initial begin
        $monitor("t=%0t clk=%b rst=%b start=%b data_in=%b tx=%b busy=%b done=%b",$time, clk, rst, start, data_in, tx, busy, done);
    end

    initial begin
        #150 $finish;
    end


endmodule
