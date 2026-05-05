# Verilog Labs: Digital Design & IC Design

This repository contains a collection of hardware designs and testbenches implemented in Verilog HDL. The projects range from fundamental combinational and sequential logic to more complex digital systems, focusing on RTL design, functional verification, and Digital IC Design principles.

---

## 🚀 Overview
The goal of these labs is to demonstrate proficiency in Verilog HDL, synchronous design techniques, and the use of industry-standard simulation tools. Each module includes a synthesizable RTL implementation and a corresponding testbench for verification.

---

## 📂 Repository Structure
The repository is organized into several lab modules, each focusing on a specific aspect of digital logic:

### 1. Basic Combinational & Sequential Logic
* **Arithmetic Units:** Half-adders, full-adders, and multi-bit ripple-carry adders.
* **Data Processing:** Multiplexers (MUX), demultiplexers, and decoders.
* **Storage Elements:** D-Flip-Flops (including variants with synchronous/asynchronous reset), registers, and counters.

### 2. Finite State Machines (FSM)
* Implementation of Moore and Mealy machines.
* Practical applications such as sequence detectors and traffic light controllers.

### 3. Advanced Digital Modules
* **16-bit ALU:** A modular Arithmetic Logic Unit featuring arithmetic, logical, and shift operations.
* **Memory Structures:** Synchronous FIFO (First-In-First-Out) memory buffers, often used in clock domain crossing or data buffering.
* **Digital Communication:** Implementation of Line Coding techniques (e.g., NRZ) and AWGN noise integration modules.

### 4. Specialized IC Design Components
* **AES-128 Encryption Core:** A hardware implementation of the Advanced Encryption Standard algorithm.
* **Low Power Design:** Modules demonstrating clock gating techniques and the use of retention flip-flops for power management.

---

## 🛠 Tools & Environment
* **Language:** Verilog HDL (IEEE 1364-2005)
* **Simulation:** QuestaSim / ModelSim
* **Synthesis:** Design Compiler / Vivado
* **Modeling:** Visual Paradigm

---

## 💻 How to Run Simulations
To verify any of the modules, follow these steps using a simulator like QuestaSim:

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/Youssefemad12/Verilog_labs.git](https://github.com/Youssefemad12/Verilog_labs.git)
   cd Verilog_labs
