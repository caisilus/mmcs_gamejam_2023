$gtk.reset

class Primitive
  attr_accessor :x, :y, :w, :h, :anchor_x, :anchor_y, :r, :g, :b, :a, :blendmode_enum

  def initialize(x: nil, y: nil, w: nil, h: nil, color: Color.black, anchor_x: 0.5, anchor_y: 0.5, blendmode_enum: 1)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r, self.g, self.b, self.a = color.pack
    self.anchor_x = anchor_x
    self.anchor_y = anchor_y
    self.blendmode_enum = blendmode_enum
  end

  def primitive_marker
    :solid
  end

  def render args
    args.outputs.primitives << self
    # debug_pivots args
  end

  def debug_pivots(args)
    x, y = center
    Debug.draw_point(args, x: x, y: y, color: Color.green)
    x, y = left_upper_corner
    Debug.draw_point(args, x: x, y: y, color: Color.blue)
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      r: r,
      b: b,
      g: g,
      a: a,
      anchor_x: anchor_x,
      anchor_y: anchor_y
    }
  end

  def to_s
    serialize.to_s
  end

  def left_upper_corner
    [x - anchor_x * w, y + (1 - anchor_y) * h]
  end

  def center
    leftmost_x, highest_y = left_upper_corner
    [leftmost_x + w / 2, highest_y - h / 2].map(&:to_i)
  end

  def inside_rect?(rect)
    serialize.inside_rect?(rect.serialize)
  end
end

class Solid < Primitive
  attr_accessor :x2, :y2, :x3, :y3
end

class Border < Primitive
  def primitive_marker
    :border
  end
end

class Sprite < Primitive
  attr_accessor :path, :angle, :angle_anchor_x, :angle_anchor_y,  :tile_x, :tile_y, :tile_w, :tile_h,
                :source_x, :source_y, :source_w, :source_h, :flip_horizontally, :flip_vertically

  def initialize(x: nil, y: nil, w: nil, h: nil, path: nil, color: Color.white, anchor_x: 0.5, anchor_y: 0.5)
    super(x: x, y: y, w: w, h: h, color: color, anchor_x: anchor_x, anchor_y: anchor_y)
    self.path = path
  end

  def primitive_marker
    :sprite
  end
end
