class Grid
  def initialize(rows, columns)
    @rows     = rows
    @columns  = columns
  end

  def coordinates_valid?(x, y)
    (0...@rows).include?(y) && (0...@columns).include?(x)
  end
end

