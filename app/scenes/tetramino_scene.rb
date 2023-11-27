$gtk.reset

class TetraminoScene < Scene
  GAP_BETWEEN_FIGURES = 50
  MARGIN_BOTTOM = 20
  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720

  def initialize(args, cell_primitive: Solid.new(color: black),
                       bg_color: Color.gray, bg_image: nil, mask: nil, grid_position: [640, 360], figures: [])
    super(args)

    setup_background(bg_color, bg_image)
    setup_cell(cell_primitive)
    setup_grid(mask, grid_position)
    setup_figures(figures)
  end

  def setup_background(bg_color, bg_image)
    @background_color = bg_color
    @background_image = bg_image
  end

  def setup_cell(cell_primitive)
    @cell_primitive = cell_primitive
    @cell_size = cell_primitive.w
  end

  def setup_grid(mask, grid_position)
    @mask = mask
    rows = @mask.length
    cols = @mask[0].length

    @grid = Tetramino::Grid.new(rows: rows, cols: cols, position: grid_position, cell_size: @cell_size,
                                cell_primitive: @cell_primitive, mask: @mask)
  end

  def setup_figures(figures)
    @figures_hand = figures.clone
    position_figures_in_hand

    @draggables = @figures_hand.clone
  end

  def position_figures_in_hand
    return if @figures_hand.empty?

    w = @figures_hand.sum { |fig| fig.w }
    w += (@figures_hand.count - 1) * GAP_BETWEEN_FIGURES

    x = (SCREEN_WIDTH - w) / 2
    y = MARGIN_BOTTOM
    @figures_hand.each do |figure|
      figure.x = x + figure.anchor_x * figure.w
      figure.y = y + figure.anchor_y * figure.h
      x += figure.w + GAP_BETWEEN_FIGURES
    end
  end

  def render
    super
    render_background
    @grid.render args

    @draggables.each do |figure|
      figure.render args
    end
  end

  def render_background
    args.outputs.background_color = @background_color.pack
    @background_image.render args
  end

  def on_mouse_up_draggable(draggable)
    if @grid.figure_can_be_placed?(draggable)
      @grid.place_figure(args, draggable)

      @figures_hand.delete draggable if @figures_hand.include?(draggable)
    else
      @grid.take_figure(draggable)

      @figures_hand << draggable unless @figures_hand.include?(draggable)
    end

    position_figures_in_hand
    super(draggable)
  end

  def on_mouse_click_draggable(draggable)
    super

    return if @figures_hand.include?(draggable)

    @grid.take_figure(draggable)
  end

  def on_mouse_held_draggable(draggable)
    super

    return unless args.inputs.keyboard.key_up.r

    draggable.rotate_90
  end

  def tick args
    super(args)

    win if @figures_hand.empty?
  end

  def win
    args.outputs.sounds << "sounds/zipper.wav"
    args.state.scene_manager.next_level(args)
  end
end
