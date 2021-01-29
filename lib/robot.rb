class Robot
  ORIENTATIONS = [:north, :east, :south, :west]

  attr_accessor :x, :y, :orientation

  def initialize(grid, x=nil, y=nil, orientation=nil)
    @grid, @x, @y, @orientation = grid, x, y, orientation
  end

  def place(x, y, orientation)
    validate_orientation(orientation)
    validate_coordinates(x, y, "Robot must be placed on the grid")

    @x, @y, @orientation = x, y, orientation
  end

  def placed?
    [@x, @y, @orientation].all?
  end

  def report
    { x: @x, y: @y, orientation: @orientation }
  end

  def turn(direction)
    validate_placed

    index         = ORIENTATIONS.index(@orientation)
    @orientation  = case direction
                    when 'RIGHT'  then ORIENTATIONS.rotate[index]
                    when 'LEFT'   then ORIENTATIONS.rotate(-1)[index]
                    else
                      raise "Invalid direction: #{direction}"
                    end
  end

  def move
    validate_placed
    new_x, new_y = move_forward
    validate_coordinates(new_x, new_y, "Move invalid! Robot would fall off!")
    @x, @y = new_x, new_y
  end

  private
    def validate_placed
      raise(StandardError, 'Robot must be placed on the grid first') unless placed?
    end

    def validate_orientation(orientation)
      raise(StandardError, 'Orientation invalid') unless ORIENTATIONS.include?(orientation)
    end

    def validate_coordinates(x, y, message="Coordinates invalid")
      raise(StandardError, message) unless @grid.coordinates_valid?(x, y)
    end

    def move_forward
      # Returns new coordinates, advancing the current coordinates by one step in the direction of current orientation
      case @orientation
      when :north then [@x, @y + 1]
      when :east  then [@x + 1, @y]
      when :south then [@x, @y - 1]
      when :west  then [@x - 1, @y]
      end
    end
end
