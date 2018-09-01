# peg-sol
Solver for triangular peg solitaire in Haskell

## Prerequisite
* stack - you can get it from [here](https://docs.haskellstack.org/en/stable/README/).

## Build
Run a command from the peg-sol directory to build the solver.  
`> stack build`

## Run

Run a command fro mthe peg-sol directory.  
`> stack exec peg-sol-exe *hole-number*`

*hole-number* (0-14) specifies the initial empty hole. The holes are numbered as

            0
          1   2
        3   4   5
      6   7   8   9
    10  11  12  13  14

The solutions are shown as simple triangular diagrams to show the moves. `.` is an empty hole, `I` is a peg, `S` is the next move, and `o` is a jumped peg to be removed.

ex)

    > stack exec peg-sol-exe 0
    solution 1

        .
       o I
      S I I
     I I I I
    I I I I I

        I
       . I
      . o I
     I I S I
    I I I I I

In this example, the first diagram shows position 0 is an empty hole. A peg at postion 3 is the next move and a peg at 1 is jumped. As the result, the peg at 3 moves to 0 and the peg at 1 gets removed.
