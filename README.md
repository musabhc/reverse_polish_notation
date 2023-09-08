# Reverse Polish Notation

Reverse Polish notation (RPN) is a method for representing expressions in which the operator symbol is placed after the arguments being operated on.
In this notation, operands come first and operator follows them. Incoming operands are pushed to stack. Then the operator uses the latest two operands.

Detailed information on Wikipedia:
http://en.wikipedia.org/wiki/Reverse_Polish_notation

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

```
Vivado
```

### Installing

Download the project and open it by stj.xpr file.

```
Design Sources:
RPN_Module (stj.v)

Simulation Sources:
 sim_1:
  RPN_Module_Testbench (stj_tb.v)
```
## Running the tests

You just need to click Run Simulation button under the SIMULATION section on the left.

### Break down into end to end tests

There are 4 scenarios, each of them written to testing the functions.  
Each scenario testing the mul, sum, push and pop functions.

```
Scenario 1: 3 + 4 * 5
Scenario 2: 10 * 2 + 7
Scenario 3: 5 * 6 + 8 * 2
Scenario 4: 3 + (6 * 7 * 5) + 6 * 7
```

## Authors

* **Musa BUHURCU** - *Initial work* - [MusaBUHURCU](https://github.com/musabhc)
* **Erdoğan KILINÇ** - *Initial work* - [ErdoğanKILINÇ](https://github.com/erdogankilinc)

