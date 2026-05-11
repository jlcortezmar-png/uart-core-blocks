module uart_tx(
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    output reg tx,
    output reg busy,
    output reg done
);
    reg [1:0] state;
    reg [7:0] data_reg;
    reg [2:0] bit_index;

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    initial begin
        state = IDLE;
        tx = 1;
        busy = 0;
        done = 0;
        bit_index = 0;
        data_reg = 0;
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1;
            busy <= 0;
            done <= 0;
            bit_index <= 0;
            data_reg <= 0;
        end
        else begin
            done <= 0;

            case (state)
                IDLE: begin
                    tx <= 1;
                    busy <= 0;

                    if (start == 1) begin
                        data_reg <= data_in;
                        busy <= 1;
                        bit_index <= 0;
                        state <= START;
                    end
                    else begin
                        state <= IDLE;
                    end
                end

                START: begin
                    tx <= 0;
                    busy <= 1;
                    state <= DATA;
                end

                DATA: begin
                    tx <= data_reg[bit_index];
                    busy <= 1;
                    if ( bit_index < 7 ) begin
                        bit_index <= bit_index +1;
                        state <= DATA;
                    end
                    else begin
                        state <= STOP;
                    end
                end

                STOP: begin
                    tx <= 1;
                    busy <= 0;
                    done <= 1;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                    tx <= 1;
                    busy <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule