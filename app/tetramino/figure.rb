$gtk.reset

module Tetramino
  class Figure < Sprite
    include Draggable

    attr_accessor :grid_mask, :logical_w, :logical_h, :sound

    def initialize(x: nil, y: nil, w: nil, h: nil, path: nil, color: nil, anchor_x: 0.5, anchor_y: 0.5,
                   grid_mask: [[true]], cell_size: 50, sound: 'pop.wav')
      super(x: x, y: y, w: w, h: h, path: path, color: color, anchor_x: anchor_x, anchor_y: anchor_y)

      @grid_mask = grid_mask
      @cell_size = cell_size

      @logical_w = w
      @logical_h = h

      @sound = self.sound
    end

    def left_upper_corner
      [x - anchor_x * @logical_w, y + (1 - anchor_y) * @logical_h]
    end

    def center
      leftmost_x, highest_y = left_upper_corner
      [leftmost_x + @logical_w / 2, highest_y - @logical_h / 2].map(&:to_i)
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

    def rotate_90
      self.angle ||= 0
      self.angle -= 90
      @logical_w, @logical_h = @logical_h, @logical_w
      rotate_mask_90
    end

    private

    def rotate_mask_90
      @grid_mask = @grid_mask.transpose.map(&:reverse)
    end
   end
end
