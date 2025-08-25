
---

## ⚙️ Setup Instructions

### Requirements
- **Hardware:** Digilent Zybo Z7-10 or Z7-20 board  
- **Software:** Xilinx Vivado (2020.2 or later recommended)  
- **Board files:** Install Digilent Zybo board files in  
  `C:/Xilinx/Vivado/<version>/data/boards/board_files/`  

### Steps to Build
1. Open **Vivado** → Create a new project → Select **Zybo Z7 board**.  
2. Add Verilog sources from `src/` and the constraint file from `constraints/`.  
3. Run **Synthesis → Implementation → Generate Bitstream**.  
4. Open **Hardware Manager** → Program device with generated bitstream.  

---

## 🖥️ Demo Program

The CPU runs a small hardcoded program stored in instruction memory:

```asm
addi $1, $0, 5      # put 5 in register 1
addi $2, $0, 10     # put 10 in register 2
add  $3, $1, $2     # $3 = 5 + 10 = 15
add  $4, $3, $0     # copy result into $4
sw   $4, 0($0)      # store result -> output
