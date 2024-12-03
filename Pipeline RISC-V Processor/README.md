## Project Overview

This project focuses on the design and implementation of a **Pipelined RISC-V Processor**. The processor supports multiple instruction types and is designed using pipelining to improve instruction throughput. The objective is to implement a 5-stage pipeline that supports a variety of RISC-V instructions, ensuring that data hazards and control hazards are properly handled.

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

### 1. 5-Stage Pipelining
The processor implements a 5-stage pipeline with the following stages:
   - **Instruction Fetch (IF)**
   - **Instruction Decode (ID)**
   - **Execution (EX)**
   - **Memory Access (MEM)**
   - **Write Back (WB)**
Each instruction passes through these stages, allowing the processor to execute multiple instructions simultaneously, improving overall performance.

### 2. Hazard Handling
The design includes mechanisms to handle **data hazards** and **control hazards** that arise from pipelining. This ensures that the pipeline operates correctly without producing erroneous results.
   - For data hazards, forwarding and stalling techniques are used to resolve dependencies between instructions.
   - For control hazards, branch prediction and flushing of incorrect instructions are implemented to ensure proper flow of control instructions.

### 3. Memory Access
The processor supports memory operations, including load (`lw`) and store (`sw`), which are handled in the memory access (MEM) stage of the pipeline.

### 4. Simulation and Testing
The processor is tested using a set of test cases that cover various scenarios, including typical RISC-V operations, handling of hazards, and performance evaluation of the pipeline.
   - Simulations are run to verify the functionality of each instruction type, as well as the correctness of pipeline execution.

## Deliverables:
- **Processor Design**: Verilog or VHDL code for the pipelined RISC-V processor.
- **Testbench and Simulations**: A set of test cases to validate the functionality of the processor, including hazard detection and resolution.
- **Reports**: Documentation detailing the design choices, handling of hazards, and performance metrics of the processor.

This project is part of the **Computer Architecture** course at the University of Tehran.