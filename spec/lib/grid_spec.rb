require './lib/grid.rb'
require 'spec_helper'

RSpec.describe Grid do
  let(:grid)                { Grid.new(5,5) }
  let(:valid_coordinates)   { [[2,1], [0,0], [4,4], [0,4], [3,3], [4,0]] }
  let(:invalid_coordinates) { [[-1,0], [5,5], [0,5], [-5,-5]] }

  describe '#coordinates_valid?(x,y)' do
    context 'with in-grid coordinates' do
      it 'returns true' do
        valid_coordinates.each do |x, y|
          expect(grid.coordinates_valid?(x, y)).to eq(true)
        end
      end
    end

    context 'with off-grid coordinates' do
      it 'returns false' do
        invalid_coordinates.each do |x, y|
          expect(grid.coordinates_valid?(x, y)).to eq(false)
        end
      end
    end
  end
end

