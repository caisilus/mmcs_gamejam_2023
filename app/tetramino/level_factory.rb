$gtk.reset

module Tetramino
  class LevelFactory
    attr_accessor :args

    def initialize(args, tetramino_folder: "sprites/tetrominos")
      @args = args
      @tetramino_folder = tetramino_folder
    end

    def build(level)
      case level
      when 1
        cell_size = 70

        mask = [[true, true, true, true, true],
                [true, true, true, true, true],
                [true, true, true, true, true]]

        folder = level_folder(level)

        figure_factory = FigureFactory.new(cell_size, folder)
        figures = [:switch_case, :penal_blue, :penal_son, :hus_cloth, :son_cloth]
        figures = figures.map {|fig_name| figure_factory.build_figure(fig_name)}
        puts figures

        bg_image_path = folder + "chalck_frame.png"
        bg_image = Sprite.new(x: 625, y: 420, w: 600, h: 450, path: bg_image_path)
        bg_color = Color.new(169, 204, 226)

        cell_primitive = make_cell_primitive(cell_size)
        grid_position = [640, 350]

        TetraminoScene.new(args, cell_primitive: cell_primitive, bg_color: bg_color, bg_image: bg_image,
                                 mask: mask, grid_position: grid_position, figures: figures)
      end
    end

    def make_cell_primitive(cell_size)
      path = @tetramino_folder + "/sector.png"
      cell_primitive = Sprite.new(w: cell_size, h: cell_size, path: path)

      cell_primitive
    end

    def level_folder(level)
      "#{@tetramino_folder}/lvl#{level}/"
    end
  end
end
