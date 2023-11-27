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
      when 2
        cell_size = 55

        mask = [[true, true, true, true, true, false, false, false, true, true, true, true, true, true],
                [false, true, true, true, true, true, false, false, true, true, true, true, true, false],
                [false, true, true, true, true, true, false, false, false, true, false, true, true, false],
                [true, true, true, true, true, true, false, false, true, true, true, true, true, false],
                [false, false, true, true, true, false, false, false, true, false, false, true, true, true],
                [true, true, true, true, true, false, false, false, true, true, true, true, true, true]]

        folder = level_folder(level)

        figure_factory = FigureFactory.new(cell_size, folder)
        figures = [:book, :camera, :dau_cloth, :hangers, :jacket, :medkit, :dau_penal, :wif_penal, :dau_boots,
                   :dau_tall_boots,  :wif_hat, :wif_shoes, :wif_tall_boots, :steam_gen, :towel, :yoga_carpet,
                   :wif_cloth, :fan]
        figures = figures.map {|fig_name| figure_factory.build_figure(fig_name)}
        puts figures

        bg_image_path = folder + "chalk_pink_bag.png"
        bg_image = Sprite.new(x: 625, y: 420, w: 860, h: 600, path: bg_image_path)
        bg_color = Color.new(199, 163, 184)

        cell_primitive = make_cell_primitive(cell_size)
        grid_position = [620, 350]

        TetraminoScene.new(args, cell_primitive: cell_primitive, bg_color: bg_color, bg_image: bg_image,
                           mask: mask, grid_position: grid_position, figures: figures)
      when 3
        cell_size = 48

        mask = [[false, true, true, true, false, false, true, false, false, true, true, true, false],
                [true, true, true, true, true, true, true, true, true, true, true, true, true],
                [false, true, true, true, true, false, true, false, true, true, true, true, false],
                [false, false, true, true, true, true, true, true, true, true, true, false, false]]

        folder = level_folder(level)

        figure_factory = FigureFactory.new(cell_size, folder)
        figures = [:antifreez, :domcrat, :extinguisher, :fomka, :gray_bag, :hatch, :pink_bag, :ski, :snowboard, :thermos]
        figures = figures.map {|fig_name| figure_factory.build_figure(fig_name)}
        puts figures

        bg_image_path = folder + "car_chalk.png"
        bg_image = Sprite.new(x: 640, y: 360, w: 1280, h: 720, path: bg_image_path)
        bg_color = Color.new(131, 173, 156)

        cell_primitive = make_cell_primitive(cell_size)
        grid_position = [640, 330]

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
