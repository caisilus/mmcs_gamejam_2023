$gtk.reset

class SceneManagerError < Exception
  def initialize(message)
    super(message)
  end
end

class SceneManager
  def initialize(scenes, starting_scene, queue: nil)
    @scenes = scenes
    @current_scene = @scenes[starting_scene]
    @transition_timer = 60
    @transition_duration = 60
    @transition_speed = 720.0 / @transition_duration
    set_queue(queue)
  end

  def tick args

    @current_scene.tick(args)

    next_scene = args.state.next_scene

    return if next_scene.nil?

    return unless @scenes.include?(next_scene)

    return if @current_scene == @scenes[next_scene]

    handle_scene_transition(args, next_scene)

  end

  def handle_scene_transition(args, next_scene)
    if @transition_timer > 0
      transition_frame = @transition_speed
      move_elements_up(transition_frame)
      interpolate_background_color(args, transition_frame)
      @transition_timer -= 1
    else
      interpolate_background_color(args, transition_frame)
      @transition_timer = @transition_duration
      @current_scene = @scenes[next_scene]
    end
  end

  private

  def move_elements_up(transition_frame)
    # Move all elements of the current scene upwards based on the transition frame
    @current_scene.move_elements_up(transition_frame)
  end

  def interpolate_background_color(args, transition_frame)
    # Interpolate the RGB values of the background color based on the transition frame
    target_color = [49, 139, 87]
    current_color = [0, 0, 0]
    args.outputs.background_color = interpolate_color(current_color, target_color, 1 - @transition_timer / @transition_duration)
  end

  def interpolate_color(start_color, end_color, t)
    # Interpolate each component of the color
    [
        start_color[0] + (end_color[0] - start_color[0]) * t,
        start_color[1] + (end_color[1] - start_color[1]) * t,
        start_color[2] + (end_color[2] - start_color[2]) * t
    ]
  end


  def set_queue(queue)
    @queue = queue
    @index = 0
  end

  def next_level(args)
    raise SceneManagerError.new("No scene queue provided to scene manager") if @queue.nil?

    args.state.next_scene = @queue[@index]

    @index += 1
    @index = 0 if @index == @queue.length
  end
end
