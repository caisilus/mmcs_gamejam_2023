$gtk.reset

module Tetramino
  class Grid
    attr_accessor :w, :h

    def initialize(rows:, cols:, position:, cell_size:, anchor_x: 0.5, anchor_y: 0.5, cell_primitive: nil, mask: nil)
      @grid = []
      @grid_elements = []

      @position = position
      @cell_size = cell_size
      @anchor_x, @anchor_y = anchor_x, anchor_y
      self.w = cols * cell_size
      self.h = rows * cell_size
      set_mask(mask)
      set_cell_primitive(cell_primitive)
      set_grid(rows, cols)
    end

    private

    def set_cell_primitive(cell_primitive)
      @cell_primitive = cell_primitive
      if @cell_primitive.nil?
        @cell_primitive = Border.new(color: Color.white)
      end
    end

    def set_grid(rows, cols)
      rows.times do |i|
        cols.times do |j|
          @grid[i] ||= []
          @grid[i][j] = nil

          @grid_elements[i] ||= []
          @grid_elements[i][j] = grid_element_at(i, j)
        end
      end
      puts @grid_elements
    end

    def grid_element_at(i, j)
      return nil unless has_element_at?(i, j)

      left_corner_x, left_corner_y = left_upper_corner

      cell = @cell_primitive.clone
      cell.x = left_corner_x + j * @cell_size
      cell.y = left_corner_y - i * @cell_size
      cell.w = @cell_size
      cell.h = @cell_size
      cell.anchor_x = 0
      cell.anchor_y = 1

      cell
    end

    def set_mask(mask)
      return if mask.nil? or mask[0].nil?

      return if mask.length != @grid.length or mask[0].length != @grid[0].length

      @mask = mask
    end

    def left_upper_corner
      x, y = @position
      [x - @anchor_x * w, y + @anchor_y * h].map(&:to_i)
    end

    def size
      [w, h]
    end

    public

    def render args
      @grid_elements.each_with_index do |row, i|
        row.each_with_index do |element, j|
          next unless has_element_at?(i, j)

          element.render args
        end
      end
    end

    private

    def debug_pivots args
      x, y = left_upper_corner
      Debug.draw_point(args, x: x, y: y)
      x, y = @position
      Debug.draw_point(args, x: x, y: y)
    end

    def has_element_at?(i, j)
      @mask.nil? or @mask[i][j]
    end

    def figure_can_be_placed?(figure)
      figure.segments_centers_solids.all? { |segment| segment_can_be_placed?(segment) }
    end

    def segment_can_be_placed?(segment)
      segment_inside_grid_cell = false

      @grid_elements.each_with_index do |row, i|
        row.each_with_index do |element, j|
          next unless segment.inside_rect? element

          segment_inside_grid_cell = true

          return false if !@grid[i][j].nil?
        end
      end

      return segment_inside_grid_cell
    end

    def place_figure(figure)
      distance_vector = [0, 0]
      figure.segments_centers_solids.each do |segment|
        distance_vector = place_segment(figure, segment)
      end

      figure.x += distance_vector[0]
      figure.y += distance_vector[1]

      puts @grid
    end

    private

    def place_segment(figure, segment)
      distance_vector = [0, 0]
      @grid_elements.each_with_index do |row, i|
        row.each_with_index do |element, j|
          next unless segment.inside_rect? element

          @grid[i][j] = figure

          segment_center = segment.center
          element_center = element.center
          distance_vector = [element_center[0] - segment_center[0], element_center[1] - segment_center[1]]
          return distance_vector
        end
      end

      return nil
    end
  end
end
