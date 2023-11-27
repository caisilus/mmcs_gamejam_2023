$gtk.reset

class MainMenuScene < Scene
  attr_accessor :args

  def initialize(args)
    super(args)


    @play_button = Button.new(x: 640, y: 400, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Play")

    @play_button.on_mouse_click do |button, args|
      args.state.scene_manager.next_level(args)
    end

    @settings_button = Button.new(x: 640, y: 300, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Settings")
    
    @fullscreen_button = Button.new(x: 640, y: 200, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Fullscreen on")

    @fullscreen_button.on_mouse_click do |button, args|
      args.state.scene_manager.go_fullscreen(args,button)
    end

     @credit_button = Button.new(x: 640, y: 100, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Credits")

    @credit_button.on_mouse_click do |button, args|
      args.state.scene_manager.show_credits(args)
    end
  end

  def render_ui
    args.outputs.background_color = [0, 0, 0]
    super
    args.outputs.sprites << { x: 460,
    y: 400,
    w: 348,
    h: 304,
    path: 'sprites/logo.png',
    angle: args.state.rotation }
  end
end
