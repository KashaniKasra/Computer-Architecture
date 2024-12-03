## Project Overview

This project focuses on **Computer Arithmetic** by designing and simulating a 10-bit division circuit using SystemVerilog. The goal is to create a division module that takes two 10-bit inputs and computes the quotient and remainder using sequential logic. The experiment involves implementing, simulating, and analyzing the circuit's behavior under various input conditions.

## Contents

- `Instruction.pdf`: Detailed instructions for the project.
- `Report.doc`: Documentation covering design, implementation, and results.

## Key Components

### 1. Inputs and Outputs
   - **Inputs**:
     - `a_in`: 10-bit dividend
     - `b_in`: 10-bit divisor
     - `start`: Signal to begin the division process
     - `sclr`: Synchronous clear
     - `clk`: Clock signal
   - **Outputs**:
     - `q_out`: 10-bit quotient
     - `dvz`: Division by zero flag
     - `ovf`: Overflow flag for results
     - `busy`: Indicates if the division process is still ongoing
     - `valid`: Signal to indicate when the result is ready

### 2. Division Algorithm
The division algorithm uses sequential logic, looping through each bit to perform the division. The dividend and divisor are loaded into registers, and subtraction is performed iteratively.
   - The quotient is constructed bit-by-bit during each iteration. If a division-by-zero scenario is detected, a flag (`dvz`) is raised, and the result is invalidated.

### 3. Simulation Process
The circuit is simulated in steps to observe the division process, handling edge cases like division by zero and ensuring proper operation under normal conditions.
   - The overflow (`ovf`) and division-by-zero (`dvz`) flags are closely monitored to validate that the module handles these conditions appropriately.

### 4. Verification
A series of test cases are used to validate the division circuit, checking for accuracy in both normal and edge-case conditions.
   - Simulation waveforms are generated to observe the internal states of the division process.

## Deliverables
- SystemVerilog code for the 10-bit division circuit.
- Simulated waveforms demonstrating the division process.
- Reports detailing the handling of overflow and division by zero scenarios.

This project is part of the **Computer Arithmetic** course at the University of Tehran.