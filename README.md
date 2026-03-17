# Microcomputer System Project 1

This repository contains **Project 1** for the **Microcomputer System** course, implemented in **8051 Assembly Language**.

---

## 📝 Project Description

This project implements an 8051 Assembly program that continuously displays a group member's student ID on an **8-digit 7-segment LED display**.

The student ID is shown with a leading `0`, for example:

`01100423`

Each digit is displayed one at a time according to a predefined hardware sequence.

### Display Sequence

Let the **right-most** 7-segment display be **digit-0**, and the **left-most** one be **digit-7**.

The required display order is:

`digit-0 → digit-2 → digit-4 → digit-6 → digit-7 → digit-5 → digit-3 → digit-1 → digit-0 → ...`

### Timing Constraints

- Each active digit stays on for **1.0 second**
- All digits remain off for **0.5 second** between displays

---

## 💡 Implementation Methods

This project explores **two different approaches** to achieve the required display behavior.

### Method 1: Direct Sequencing

**Logic**  
The display positions (`P1`) and corresponding digit values (`P2`) are pre-arranged and stored in memory following the exact required display sequence. A register (`R0`) is used as an index to fetch and display them one by one.

**Advantages**
- Simple and straightforward program structure
- Easy to modify the display order

**Disadvantages**
- The original student ID becomes scrambled in memory
- Any change to the ID requires manually rebuilding the sequence array

---

### Method 2: Algorithmic Traversal

**Logic**  
The student ID digits are stored in normal **left-to-right order** in memory. The program uses an index register (`R0`) and a direction flag (`R2`) to determine the next digit algorithmically.

- When `R2 = 0`, the pointer shifts left
- When `R2 = 1`, the pointer shifts right

The program checks boundary positions such as `digit-1`, `digit-6`, and `digit-7` to determine when to reverse direction.

**Advantages**
- The student ID remains in natural order and is easy to read
- Changing the student ID is much easier

**Disadvantages**
- More complex assembly logic
- Requires extra conditional jumps and boundary handling

---

## 📂 Directory Structure

### `project1_submission/`

Contains the final source code submissions and documentation.

- `Project_Method1.asm`  
  Implementation using **Method 1: Direct Sequencing**

- `Project_Method2.asm`  
  Implementation using **Method 2: Algorithmic Traversal**

- `IDE_test.asm`  
  Modified script used for testing in the IDE environment

- `Project_Report.pdf`  
  Comprehensive project report including:
  - Flowcharts
  - Logic derivations
  - Delay time calculations
  - Hardware demonstration photos

---

### `project1_ide_test/`

Contains the testing project files and virtual hardware configurations for **MCU 8051 IDE**.

- `.adf`
- `.mcu8051ide`
- `.vhw`

---
## 🎥 Demo Videos

- [Microcomputer System (8051) Project 1 Demo Video](https://www.youtube.com/watch?v=ve1Dxizj1So) — Hardware Demonstration
- [Microcomputer System (8051) Project 1 IDE Demo](https://www.youtube.com/watch?v=8tbQTQPz-Gc) — IDE Simulation
