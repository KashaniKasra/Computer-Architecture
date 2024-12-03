## Project Overview

This project involves the design and implementation of a **Single-Cycle RISC-V Processor**. The processor executes a variety of RISC-V instructions in a single clock cycle, ensuring simplicity in the control unit and datapath. The aim is to demonstrate the execution of different RISC-V instruction types, including arithmetic, memory access, branching, and immediate-based instructions.

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

### 1. Single-Cycle Execution
The processor is designed to execute each instruction in a single clock cycle. All five stages of instruction execution (fetch, decode, execute, memory access, and write-back) are completed within one clock cycle.

### 2. Datapath
The datapath includes registers, an ALU, and memory units to process the instructions. The ALU performs arithmetic and logic operations, and the memory units handle load (`lw`) and store (`sw`) instructions.

### 3. Control Unit
The control unit generates signals based on the instruction type to control the operation of the datapath. It determines the actions of the ALU, memory, and register file.

### 4. Memory Access
Memory access instructions (`lw`, `sw`) are performed within the same clock cycle. The memory address is calculated by adding an immediate value to a base register, and the data is either loaded into or stored from the register file.

### 5. Branching and Jumping
Branch instructions (`beq`, `bne`, `blt`, `bge`) and jump instructions (`jal`, `jalr`) are supported. The control unit manages branching and jumping by calculating the target address and updating the program counter.

## Deliverables:

- **Processor Design**: Verilog or VHDL code for the single-cycle RISC-V processor.
- **Testbench and Simulations**: A set of test cases to verify the processor’s functionality, covering all supported instruction types.
- **Reports**: Documentation of the design, including details of the control unit, datapath, and cycle-by-cycle instruction execution.

This project is part of the **Computer Architecture** course at the University of Tehran.