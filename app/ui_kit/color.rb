$gtk.reset

class Color
  attr_accessor :r, :g, :b, :a

  def initialize(r, g, b, a=255)
    @r, @g, @b, @a = r, g, b, a
  end

  def pack
    [r, g, b, a]
  end

  def serialize
    {r: r, g: g, b: b, a: a}
  end

  def self.black
    Color.new(0, 0, 0)
  end

  def self.white
    Color.new(255, 255, 255)
  end

  def self.gray(value=90)
    Color.new(value, value, value)
  end

  def self.red(value=255)
    Color.new(value, 0, 0)
  end

  def self.green(value=255)
    Color.new(0, value, 0)
  end

  def self.blue(value=255)
    Color.new(0, 0, value)
  end
end
