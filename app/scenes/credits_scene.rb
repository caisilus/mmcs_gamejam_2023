$gtk.reset

class CreditsScene < Scene
  attr_accessor :args

  def initialize(args)
    super(args)
    args.outputs.sprites << { x: 576,
                            y: 100,
                            w: 128,
                            h: 101,
                            path: 'background.png',
                            angle: args.state.rotation }
  end

  def render_ui
    args.outputs.background_color = [0, 0, 0]
    super
  end
end