# Microcomputer System Project 1

This repository contains Project 1 for the Microcomputer System course, written in 8051 Assembly Language.

<<<<<<< HEAD
## Directory Structure
- `project1_submission/`: Contains the final source code submissions (e.g., `Project_Method1.asm`, `Project_Method2.asm`, and `IDE_test.asm`).
- `project1_ide_test/`: Contains the test project files and virtual hardware configurations for MCU 8051 IDE (`.adf`, `.mcu8051ide`, `.vhw`).
=======
## 📝 Project Description
This project implements an 8051 Assembly program to continuously display a group member's student ID (leading with a "0", e.g., `01100423`) on an 8-digit 7-segment LED display. The displays take turns showing their contents based on a specific hardware sequence.

**Display Sequence:**
Let the right-most digit of the 7-segment display be `digit-0`, and the left-most digit be `digit-7`. 
The required display order is: 
`digit-0 -> digit-2 -> digit-4 -> digit-6 -> digit-7 -> digit-5 -> digit-3 -> digit-1 -> digit-0 (repeat)`.

**Timing Constraints:**
* Whenever a digit is on, it lasts for 1.0 second.
* When all the digits are off (between displays), it lasts for 0.5 second.

## 🎥 Demo Videos
* [Microcomputer System(8051) Project 1 demo video](https://www.youtube.com/watch?v=ve1Dxizj1So) (Hardware Demonstration)
* [Microcomputer System(8051) Project-1 IDE demo](https://www.youtube.com/watch?v=8tbQTQPz-Gc) (IDE Simulation)

## 💡 Implementation Methods
The project explores two different logic approaches to achieve the display requirements:

### Method 1: Direct Sequencing
* **Logic:** The position (`P1`) and digit to display (`P2`) are pre-arranged and stored in memory according to the exact required display sequence. A register (`R0`) is used as an index to fetch and display them sequentially.
* **Pros:** Very simple and straightforward program structure; easy to change the display order.
* **Cons:** The raw student ID is scrambled in the array, making it hard to read. Every time the ID changes, the sequence array must be manually re-calculated.

### Method 2: Algorithmic Traversal
* **Logic:** The student ID digits are stored in a standard left-to-right order in memory. The program uses an index (`R0`) and a direction indicator (`R2`) to algorithmically calculate the next digit to display. When `R2=0`, it shifts left; when `R2=1`, it shifts right. The program actively checks boundaries (`digit-1`, `digit-6`, `digit-7`) to reverse directions appropriately.
* **Pros:** The student ID is written in order, providing excellent readability and making it very easy to change the ID.
* **Cons:** The assembly logic is more complex, requiring conditional jumps to adjust the pointer and direction.

## 📂 Directory Structure
* `project1_繳交檔/`: Contains the final source code submissions and documentation.
  * `Project_方法一.asm`: Implementation using Method 1.
  * `Project_方法二.asm`: Implementation using Method 2.
  * `IDE_test.asm`: Modified script used for testing in the IDE environment.
  * `微電腦系統_Project_Report.pdf`: Comprehensive project report containing flowcharts, logic derivations, delay time calculations, and hardware demonstration photos.
* `project1_ide_test/`: Contains the test project files and virtual hardware configurations for MCU 8051 IDE (`.adf`, `.mcu8051ide`, `.vhw`).

>>>>>>> 82696162b63f0dee488ec620bb3b9a6ff6bb1aa4

