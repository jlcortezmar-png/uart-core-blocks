module tb;
    reg clk;
    reg rst;
    reg rx;
    wire [7:0] data_out;
    wire valid;

    uart_rx dut(
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data_out(data_out),
        .valid(valid)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        rst= 1;
        rx= 1;

        #10 rst = 0;

        #10 rx = 0;   
        #10 rx = 0;   
        #10 rx = 1;   
        #10 rx = 0;   
        #10 rx = 1;   
        #10 rx = 0;   
        #10 rx = 0;   
        #10 rx = 1;   
        #10 rx = 0;   
        #10 rx = 1;   
        #10 rx = 1;   
    end

    initial begin
        $monitor("t=%0t clk=%b rst=%b rx=%b data_out=%b valid=%b", $time, clk, rst, rx, data_out, valid);
    end

    initial begin
        #150 $finish;
    end

endmodule
