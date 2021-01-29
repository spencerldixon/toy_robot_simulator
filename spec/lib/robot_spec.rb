require './lib/robot.rb'
require 'spec_helper'

RSpec.describe Robot do
  let(:grid)                    { Grid.new(5,5) }
  let(:unplaced_robot)          { Robot.new(grid) }
  let(:placed_robot)            { Robot.new(grid, 3, 3, :north) }
  let(:valid_coordinates)       { [[2,1], [0,0], [4,4], [0,4], [3,3], [4,0]] }
  let(:invalid_coordinates)     { [[-1,0], [5,5], [0,5], [-5,-5]] }

  describe '#placed?' do
    context 'when x, y, and orientation are present' do
      it 'returns true' do
        expect(placed_robot.placed?).to be true
      end
    end

    context 'when x, y, and orientation are not present' do
      it 'returns false' do
        expect(unplaced_robot.placed?).to be false
      end
    end
  end

  describe '#place(x, y, orientation)' do
    context 'with invalid coordinates' do
      it 'raises an error' do
        invalid_coordinates.each do |x, y|
          expect { unplaced_robot.place(x, y, :north) }.to raise_error(StandardError)
        end
      end
    end

    context 'with valid coordinates' do
      it 'sets the x, y, and orientation' do
        valid_coordinates.each do |x, y|
          unplaced_robot.place(x, y, :north)

          expect(unplaced_robot.x).to eq(x)
          expect(unplaced_robot.y).to eq(y)
          expect(unplaced_robot.orientation).to eq(:north)
        end
      end
    end

    context 'with invalid orientation' do
      it 'raises an error' do
        expect { unplaced_robot.place(3, 3, :wrong) }.to raise_error(StandardError)
      end
    end
  end

  describe '#report' do
    subject(:report) { placed_robot.report }

    it 'returns a hash' do
      expect(report).to be_a Hash
    end

    it 'returns the x value' do
      expect(report).to include(:x)
    end

    it 'returns the y value' do
      expect(report).to include(:y)
    end

    it 'returns the orientation' do
      expect(report).to include(:orientation)
    end
  end

  describe '#turn(direction)' do
    let(:turns) { [
      {starting_orientation: :north, direction: 'LEFT',  final_orientation: :west},
      {starting_orientation: :north, direction: 'RIGHT', final_orientation: :east},
      {starting_orientation: :south, direction: 'LEFT', final_orientation: :east},
      {starting_orientation: :south, direction: 'RIGHT', final_orientation: :west}
    ] }

    context 'with valid direction' do
      it 'is oriented correctly' do
        turns.each do |turn|
          placed_robot.orientation = turn[:starting_orientation]
          placed_robot.turn(turn[:direction])

          expect(placed_robot.orientation).to be turn[:final_orientation]
        end
      end
    end

    context 'with invalid direction' do
      it 'raises an error' do
        expect { placed_robot.turn("WRONG") }.to raise_error(StandardError)
      end
    end
  end

  describe '#move' do
    context 'when move is invalid' do
      it 'raises an error' do
        placed_robot.x = 0
        placed_robot.y = 0
        placed_robot.orientation = :south

        expect { placed_robot.move }.to raise_error(StandardError)
      end
    end

    context 'when facing north' do
      it 'increments the Y coordinate by 1' do
        placed_robot.orientation = :north

        expect { placed_robot.move }.to change { placed_robot.y }.by(+1)
      end
    end

    context 'when facing south' do
      it 'decrements the Y coordinate by 1' do
        placed_robot.orientation = :south

        expect { placed_robot.move }.to change { placed_robot.y }.by(-1)
      end
    end

    context 'when facing east' do
      it 'increments the X coordinate by 1' do
        placed_robot.orientation = :east

        expect { placed_robot.move }.to change { placed_robot.x }.by(+1)
      end
    end

    context 'when facing wesr' do
      it 'decrements the X coordinate by 1' do
        placed_robot.orientation = :west

        expect { placed_robot.move }.to change { placed_robot.x }.by(-1)
      end
    end
  end
end

