# Microcomputer System Project 1

This repository contains Project 1 for the Microcomputer System course, written in 8051 Assembly Language.

## 📝 Project Description
[cite_start]This project implements an 8051 Assembly program to continuously display a group member's student ID (leading with a "0", e.g., `01100423`) on an 8-digit 7-segment LED display[cite: 746, 748, 572]. [cite_start]The displays take turns showing their contents based on a specific hardware sequence[cite: 750].

**Display Sequence:**
[cite_start]Let the right-most digit of the 7-segment display be `digit-0`, and the left-most digit be `digit-7`[cite: 749]. 
The required display order is: 
[cite_start]`digit-0 -> digit-2 -> digit-4 -> digit-6 -> digit-7 -> digit-5 -> digit-3 -> digit-1 -> digit-0 (repeat)`[cite: 751].

**Timing Constraints:**
- [cite_start]Whenever a digit is on, it lasts for 1.0 second[cite: 755].
- [cite_start]When all the digits are off (between displays), it lasts for 0.5 second[cite: 756].

## 💡 Implementation Methods
[cite_start]The project explores two different logic approaches to achieve the display requirements[cite: 574]:

### Method 1: Direct Sequencing 
- [cite_start]**Logic:** The position (`P1`) and digit to display (`P2`) are pre-arranged and stored in memory according to the exact required display sequence[cite: 576]. [cite_start]A register (`R0`) is used as an index to fetch and display them sequentially[cite: 586].
- [cite_start]**Pros:** Very simple and straightforward program structure; easy to change the display order[cite: 651, 652].
- [cite_start]**Cons:** The raw student ID is scrambled in the array, making it hard to read[cite: 653]. [cite_start]Every time the ID changes, the sequence array must be manually re-calculated[cite: 652].

### Method 2: Algorithmic Traversal 
- [cite_start]**Logic:** The student ID digits are stored in a standard left-to-right order in memory[cite: 603]. The program uses an index (`R0`) and a direction indicator (`R2`) to algorithmically calculate the next digit to display. [cite_start]When `R2=0`, it shifts left; when `R2=1`, it shifts right[cite: 613]. [cite_start]The program actively checks boundaries (`digit-1`, `digit-6`, `digit-7`) to reverse directions appropriately[cite: 614].
- [cite_start]**Pros:** The student ID is written in order, providing excellent readability and making it very easy to change the ID[cite: 655, 657].
- [cite_start]**Cons:** The assembly logic is more complex, requiring conditional jumps to adjust the pointer and direction[cite: 656].

## 📂 Directory Structure
- `project1_submission/`: Contains the final source code submissions and documentation.
  - `Project_Method1.asm`: Implementation using Method 1.
  - `Project_Method2.asm`: Implementation using Method 2.
  - `IDE_test.asm`: Modified script used for testing in the IDE environment.
  - [cite_start]`Project_Report.pdf`: Comprehensive project report containing flowcharts, logic derivations, delay time calculations, and hardware demonstration photos[cite: 536, 569, 588, 633, 683].
- `project1_ide_test/`: Contains the test project files and virtual hardware configurations for MCU 8051 IDE (`.adf`, `.mcu8051ide`, `.vhw`).



