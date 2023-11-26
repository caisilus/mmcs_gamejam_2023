$gtk.reset

module Tetramino
  class Figure < Sprite
    include Draggable

    attr_accessor :grid_mask

    def initialize(x: nil, y: nil, w: nil, h: nil, path: nil, color: nil, anchor_x: 0.5, anchor_y: 0.5,
                   grid_mask: [[true]], cell_size: 50)
      super(x: x, y: y, w: w, h: h, path: path, color: color, anchor_x: anchor_x, anchor_y: anchor_y)

      @grid_mask = grid_mask
      @cell_size = cell_size
    end

    def first_segment_center
      point = left_upper_corner

      point[0] += @cell_size / 2
      point[1] -= @cell_size / 2

      point
    end

    def segments_centers
      first_x, first_y = first_segment_center
      current_x, current_y = first_x, first_y
      centers = []

      @grid_mask.each do |row|
        row.each do |flag|
          centers << [current_x, current_y] if flag

          current_x += @cell_size
        end

        current_x = first_x
        current_y -= @cell_size
      end

      centers
    end

    def segments_centers_solids
      centers = segments_centers
      centers.map { |p| Solid.new(x: p[0], y: p[1], w: 10, h: 10, color: Color.red) }
    end

    def render args
      super args

      centers_solids = segments_centers_solids

      centers_solids.each do |solid|
        args.outputs.solids << solid
      end
    end
  end
end
