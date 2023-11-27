module Debug
  def draw_point(args, x:, y:, size: 10, color: Color.red)
    r, g, b, a = color.pack
    args.outputs.solids << { x: x, y: y, w: 10, h: 10, anchor_x: 0.5, anchor_y: 0.5, r: r, g: g, b: b, a: a }
  end

  module_function :draw_point
end
