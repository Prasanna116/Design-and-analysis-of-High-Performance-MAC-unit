# Design-and-analysis-of-High-Performance-MAC-unit
This project presents the Design, Simulation, Synthesis, and Evaluation of various **Multiply-Accumulate (MAC) units** using\
 Multipliers: **Vedic**, **Dadda**, **Wallace Tree** \
Adders: **Kogge-Stone (KS)**, **Brent-Kung (BK)** 
Each MAC variant is implemented for **4-bit, 8-bit, and 16-bit** datapath widths to study scaling behavior.

# Parallel Prefix Adders
   This project utilizes **Parallel Prefix aAdders (PPAs)** to optimize the accumulation stage of Multiply-Accumulate (MAC) units. PPAs are known for their ability to compute carry bits in parallel, leading to faster addition compared to ripple or carry-lookahead designs.

### 🧠 What is a Parallel Prefix Adder?

A **parallel prefix adder** computes carry bits through a pre-computation and propagation process, dividing the addition into three main steps:
1. **Preprocessing**: Calculate generate (G) and propagate (P) signals from input bits.
2. **Prefix computation**: Use prefix operations (e.g., tree structures) to compute carries.
3. **Postprocessing**: Final sum is computed using carries and propagate signals.

These structures reduce the overall delay by **logarithmic depth** rather than linear (as in ripple adders).

---

### ⚡ Kogge-Stone Adder (KSA)

The **Kogge-Stone adder** is the **fastest** parallel prefix adder in the family. It features:
- **Log₂(n)** depth → excellent speed
- **Minimal fanout** → high frequency capability
- **Extensive wiring and area usage** due to its full binary tree of prefix operations
- ![16-bit KSA](https://github.com/user-attachments/assets/6d08a814-79d9-4ce7-ae25-578e058f1a12)
- ![32-bit KSA](https://github.com/user-attachments/assets/4270aa33-a852-4681-bcec-0b318649ca40)


---

### 🔧 Brent-Kung Adder (BKA)

The **Brent-Kung adder** is a more **area- and power-efficient** prefix structure:
- **2·log₂(n) - 1** stages → slightly higher delay than KSA
- **Fewer interconnects** and logic blocks
- **Balanced trade-off** between performance and silicon footprint
- ![16-bit BKA](https://github.com/user-attachments/assets/dd5eb6eb-bb81-4f3f-a238-e918ac688b47)
- ![32-bit BKA](https://github.com/user-attachments/assets/6a16881a-8047-43af-ae94-c37d46d4f26a)

---

### 🔍 Why Use Them in MAC Units?

In MAC architectures, the adder stage often becomes the **critical path**. By selecting a suitable prefix adder:
- **KSA** accelerates accumulation at the cost of area
- **BKA** reduces area and power while maintaining reasonable speed, sometimes act as the fastest too.

In this project, both adders were implemented and compared across 4-, 8-, and 16-bit datapaths to assess how these trade-offs evolve with scale. 
We have designed 8-bit,16-bit and 32-bit KSA and BKA for this project and verified it's functionalites


