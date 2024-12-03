## Project Overview

This project focuses on designing a **Multi-Cycle RISC-V Processor** using Verilog or VHDL. The objective is to implement a multi-cycle processor capable of executing various RISC-V instructions across different instruction types. The design is evaluated based on its ability to handle multiple instruction types and successfully implement control and data paths.

## Supported Instruction Types:

### 1. R-Type Instructions
   - `add`, `sub`, `and`, `or`, `slt`, `sltu`

### 2. I-Type Instructions
   - `lw`, `addi`, `xori`, `ori`, `slti`, `sltiu`, `jalr`

### 3. S-Type Instruction
   - `sw` (store word)

### 4. J-Type Instruction
   - `jal` (jump and link)

### 5. B-Type Instructions
   - `beq`, `bne`, `blt`, `bge`

### 6. U-Type Instruction
   - `lui` (load upper immediate)

## Key Components of the Project:

### 1. Multi-Cycle Execution
The processor is designed to execute instructions over multiple clock cycles. This approach splits the fetch, decode, execution, memory, and write-back stages, allowing each stage to complete within a single cycle.

### 2. Control Unit
The control unit is responsible for managing the instruction execution by issuing control signals for each cycle of instruction execution.

### 3. Datapath
The datapath includes registers, ALUs (Arithmetic Logic Units), memory units, and multiplexers that process the instructions. The multi-cycle design reuses these components over several cycles to execute each instruction.

### 4. Memory Access
The processor handles memory access instructions (`lw`, `sw`) efficiently using load and store operations. Memory addresses are calculated based on the base register and immediate values provided by the instruction.

### 5. Branching and Jumping
The processor supports branching (`beq`, `bne`, `blt`, `bge`) and jumping (`jal`, `jalr`) instructions. Control signals manage branching and jumping to correct addresses based on condition flags.

## Evaluation Criteria:
- **Functionality**: The processor should correctly execute all supported instruction types.
- **Control and Data Path Design**: The control unit and datapath should be efficiently implemented to handle multi-cycle execution.
- **Performance**: The design is evaluated based on the number of cycles required to execute each instruction and overall resource usage.

## Deliverables:

- **Processor Design**: Verilog or VHDL code implementing the multi-cycle RISC-V processor.
- **Testbench and Simulations**: A set of test cases for validating the functionality of the processor.
- **Reports**: Documentation detailing the design, including control signals, datapath, and cycle-by-cycle breakdown of instruction execution.

This project is part of the **Computer Architecture** course at the University of Tehran.