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
    set_queue(queue)
  end

  def tick args
    @current_scene.tick args

    next_scene = args.state.next_scene

    return if next_scene.nil?

    return unless @scenes.include?(next_scene)

    @current_scene = @scenes[next_scene]
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
