require './lib/grid.rb'
require './lib/robot.rb'

grid  = Grid.new(5,5)
robot = Robot.new(grid)

loop do
  puts "Enter a move..."
  move = gets.chomp.split(/[\s+,]/).delete_if(&:empty?)

  case move
    in ["LEFT"|"RIGHT" => direction]  then robot.turn(direction)
    in ["MOVE"]                       then robot.move
    in ["REPORT"]                     then puts robot.report
    in ["PLACE", x, y, f]             then robot.place(x.to_i, y.to_i, f.downcase.to_sym)
  else
    raise StandardError, "Please enter a valid command"
  end
rescue => e
  puts "⚠️  #{e.message}"
end
