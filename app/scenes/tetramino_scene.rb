$gtk.reset

class TetraminoScene < Scene
  CELL_SIZE = 50
  GAP_BETWEEN_FIGURES = 50
  MARGIN_BOTTOM = 20
  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720

  def initialize args
    super(args)

    @cell_primitive = Border.new(color: Color.white)
    @grid = Tetramino::Grid.new(rows: 5, cols: 10, position: [640, 500], cell_size: CELL_SIZE,
                                cell_primitive: @cell_primitive)

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

  def draggable_dropped(draggable)
    if @grid.figure_can_be_placed?(draggable)
      @figures_hand.delete draggable if @figures_hand.include?(draggable)

      @grid.place_figure(draggable)
    end

    position_figures_in_hand
    super(draggable)
  end
end
