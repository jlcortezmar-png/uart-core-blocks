module uart_rx(
    input clk,
    input rst,
    input rx,
    output reg [7:0] data_out,
    output reg valid
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
        data_out = 8'b00000000;
        valid = 1'b0;
        data_reg = 8'b00000000;
        bit_index = 3'b000;
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            data_out <= 8'b00000000;
            valid <= 1'b0;
            data_reg <= 8'b00000000;
            bit_index <= 3'b000;
        end
        else begin
            valid <= 1'b0;

            case (state)
                IDLE: begin
                    if (rx == 1'b0) begin
                        bit_index <= 3'b000;
                        state <= START;
                    end
                    else begin
                        state <= IDLE;
                    end
                end

                START: begin
                    state <= DATA;
                end

                DATA: begin
                    data_reg[bit_index] <= rx;
                    if (bit_index < 3'd7) begin
                        bit_index <= bit_index + 1'b1;
                        state <= DATA;
                    end
                    else begin
                        state <= STOP;
                    end
                end

                STOP: begin
                    if (rx == 1'b1) begin
                        data_out <= data_reg;
                        valid <= 1'b1;
                        state <= IDLE;
                    end
                    else begin
                        state <= IDLE;
                    end
                end

                default: begin
                    state <= IDLE;
                    valid <= 1'b0;
                end
            endcase
        end
    end

endmodule