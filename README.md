# 🤖 Toy Robot Simulator

Tech test to build a Robot that can be moved around a grid. Built with ruby, rspec and some neat pattern matching features from Ruby 3.

## Brief

- Robot is placed on a 5x5 grid
- There are no obstructions on the grid
- Robot cannot fall off the grid
- 0,0 is considered the south west corner of the grid
- Invalid commands are ignored

## Commands

Robot responds to the following commands:

- `PLACE X,Y,F` - Places the robot on the grid at given coordinates, facing a certain direction
- `MOVE` - Moves the robot one square forward in the current direction
- `LEFT` - Turns the robot to the left
- `RIGHT` - Turns the robot to the right
- `REPORT` - Outputs the current coordinates and orientation

## Setup

Clone the project and run...

```bash
cd toy_robot_simulator
ruby ./lib/toy_robot_simulator.rb
```

## Tests

All tests are done with RSpec, using the guidelines from betterspec.org (how I generally write my tests)

For tests, run...

```bash
rspec
```
