$gtk.reset

class MainMenuScene < Scene
  attr_accessor :args, :game_objects

  def initialize(args)
    super(args)

    @play_button = Button.new(x: 640, y: 500, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Play")
    @play_button.on_mouse_click do |button, args|
      args.state.scene_manager.next_level(args)
    end

    @settings_button = Button.new(x: 640, y: 400, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                                  text_color: Color.new(250, 250, 250), text: "Settings")

    # Add elements to the game_objects array
    @game_objects << @play_button
    @game_objects << @settings_button

    @bg_color = [0, 0, 0]
  end

  def render_ui
    args.outputs.background_color = [0, 0, 0]
    super
  end

  def move_elements_up(transition_frame)
    @game_objects.each { |obj| obj.y += transition_frame }
  end

end

