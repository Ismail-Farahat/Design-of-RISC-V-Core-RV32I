# Design of RISC-V Core (RV32I)

## Overview
This repository contains the implementation of a RISC-V processor core. The design includes a pipelined architecture, hazard handling, and essential components required for executing RISC-V instructions.

## Features
- **Pipelined Architecture**: Supports multiple instruction execution stages.
- **Hazard Handling**: Implements forwarding and stall mechanisms.
- **Modular Design**: Composed of individual components for flexibility and reusability.
- **Instruction & Data Memory**: Separate memory modules for instructions and data.
- **ALU & Control Unit**: Responsible for arithmetic operations and instruction decoding.

## Project Structure
```
├── src/
│   ├── ADDER.sv             # Adder module
│   ├── ALU.sv               # Arithmetic Logic Unit
│   ├── ALUDecoder.sv        # ALU control decoder
│   ├── ControlUnit.sv       # Main control unit
│   ├── DataMemory.sv        # Data memory module
│   ├── EXTEND.sv            # Immediate extension unit
│   ├── HazardUnit.sv        # Handles pipeline hazards
│   ├── InstructionMemory.sv # Instruction memory module
│   ├── MainDecoder.sv       # Decodes RISC-V instructions
│   ├── MUX2.sv              # 2-to-1 multiplexer
│   ├── MUX3.sv              # 3-to-1 multiplexer
│   ├── PipelineReg.sv       # Pipeline registers
│   ├── RegisterFile.sv      # Register file for storing registers
│   ├── RISC_V_TOP.sv        # Top-level module
├── tb/
│   ├── RISCV_TB.sv          # Testbench
├── const/
│   └── const.sdc            # Constraints file for synthesis
```

## Requirements
- **Verilog/SystemVerilog Simulator** (e.g., ModelSim, QuestaSim, or Xilinx Vivado)
- **Synthesis Tools** (e.g., Xilinx Vivado, Synopsys Design Compiler)
- **RISC-V GCC Toolchain** (for generating binary instructions)

## Getting Started
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```
2. Simulate the design:
   - Open the testbench file (`RISCV_TB.sv`) in your simulator.
   - Compile and run the simulation.
   ```sh
   vlog RISCV_TB.sv
   vsim RISCV_TB
   run -all
   ```
3. Synthesize the design (if using Vivado):
   - Open Vivado and create a new project.
   - Add the Verilog source files.
   - Set the target device and synthesize the design.

## Testing & Validation
- The testbench (`RISCV_TB.sv`) provides stimulus and checks the output against expected results.
- Modify the instruction memory (`InstructionMemory.sv`) to load different programs for execution.
- Verify pipeline stages using waveform analysis in a simulator.


---

