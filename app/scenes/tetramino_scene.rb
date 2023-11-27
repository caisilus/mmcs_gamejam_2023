$gtk.reset

class TetraminoScene < Scene
  CELL_SIZE = 50
  GAP_BETWEEN_FIGURES = 50
  MARGIN_BOTTOM = 20
  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720

  def initialize args
    super(args)

    @cell_primitive = Solid.new(color: Color.black)
    @mask = [[false, true, true, true, true, false],
             [true, false, true, true, false, true],
             [true, true, true, true, true, true],
             [true, false, true, true, false, true],
             [false, true, true, true, true, false]
            ]
    @grid = Tetramino::Grid.new(rows: 5, cols: 6, position: [640, 500], cell_size: CELL_SIZE,
                                cell_primitive: @cell_primitive, mask: @mask)

    @background_color = Color.gray
    setup_figures(:long_straight, :t_shaped)
  end

  def setup_figures(*figure_names)
    @figure_factory = Tetramino::FigureFactory.new(CELL_SIZE)

    @figures_hand = figure_names.map { |f_name| @figure_factory.build_figure(f_name) }
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
    args.outputs.background_color = @background_color.pack
    @grid.render args

    @draggables.each do |figure|
      figure.render args
    end
  end

  def on_mouse_up_draggable(draggable)
    if @grid.figure_can_be_placed?(draggable)
      @grid.place_figure(draggable)

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
    args.state.scene_manager.next_level(args)
  end
end
