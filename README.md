# UART Core Blocks in Verilog

This project contains a simplified UART transmitter, UART receiver, and FIFO buffer written in Verilog.  
The goal of the project is to demonstrate basic RTL design, finite state machine implementation, synchronous design, and functional verification using custom testbenches.

## Modules

### 1. UART Transmitter (`uart_tx`)
Implements a simplified UART transmitter with:
- 1 start bit
- 8 data bits
- 1 stop bit

Main features:
- FSM-based transmission
- LSB first transmission
- `busy` flag
- `done` pulse at the end of transmission

### 2. UART Receiver (`uart_rx`)
Implements a simplified UART receiver with:
- 1 start bit
- 8 data bits
- 1 stop bit

Main features:
- FSM-based reception
- LSB first reception
- `valid` pulse when a byte is successfully received

### 3. FIFO Buffer (`fifo`)
Implements a simple 4-depth, 8-bit FIFO buffer.

Main features:
- write and read pointers
- element counter
- `full` and `empty` flags
- ordered data storage and retrieval

## Project Structure

```text
uart-core-blocks/
├── rtl/
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── fifo.v
├── tb/
│   ├── tb_uart_tx.v
│   ├── tb_uart_rx.v
│   └── tb_fifo.v
├── waves/
└── README.md
