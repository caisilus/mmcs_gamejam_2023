$gtk.reset

module Tetramino
  class FigureFactory
    def initialize(cell_size, figures_folder_path="sprites/tetrominos/")
      @figures_folder_path = figures_folder_path
      @cell_size = cell_size
    end

    def build_figure(key)
      self.send(key)
    end

    def long_straight
      path = @figures_folder_path + "I.png"
      grid_mask = [[true], [true], [true], [true]]
      w = 4 * @cell_size
      h = @cell_size

      figure = Figure.new(w: h, h: w, path: path, grid_mask: grid_mask, cell_size: @cell_size)

      figure
    end

    def t_shaped
      path = @figures_folder_path + "T.png"
      grid_mask = [[false, true, false], [true, true, true]]
      w = 3 * @cell_size
      h = 2 * @cell_size

      Figure.new(w: w, h: h, path: path, grid_mask: grid_mask, cell_size: @cell_size)
    end

    def switch_case
      path = @figures_folder_path + "switch_case.png"
      puts path
      grid_mask = [[true], [true], [true]]

      make_figure(path, grid_mask, "menu.wav")
    end

    def hus_cloth
      path = @figures_folder_path + "hus_cloth.png"
      grid_mask = [[true, true], [true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def son_cloth
      path = @figures_folder_path + "son_cloth.png"
      grid_mask = [[true, true], [true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def penal_blue
      path = @figures_folder_path + "penal_blue.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def penal_son
      path = @figures_folder_path + "penal_son.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def book
      path = @figures_folder_path + "book.png"
      grid_mask = [[true]]

      make_figure(path, grid_mask, "door_1.wav")
    end

    def camera
      path = @figures_folder_path + "camera.png"
      grid_mask = [[true]]

      make_figure(path, grid_mask, "menu.wav")
    end

    def dau_cloth
      path = @figures_folder_path + "dau_cloth.png"
      grid_mask = [[true, true],
                   [true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def fan
      path = @figures_folder_path + "fan_L.png"
      grid_mask = [[true, true],
                   [true, false]]

      make_figure(path, grid_mask, "menu.wav")
    end

    def hangers
      path = @figures_folder_path + "hangers.png"
      grid_mask = [[true, true, true],
                   [false, true, false]]

      make_figure(path, grid_mask, "menu.wav")
    end

    def jacket
      path = @figures_folder_path + "jacket.png"
      grid_mask = [[true, true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def medkit
      path = @figures_folder_path + "medkit.png"
      grid_mask = [[true, true, true]]

      make_figure(path, grid_mask , "door_1.wav")
    end

    def dau_penal
      path = @figures_folder_path + "pink_penal.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def wif_penal
      path = @figures_folder_path + "red_penal.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def dau_boots
      path = @figures_folder_path + "pink_snikers.png"
      grid_mask = [[false, true, true],
                   [true, true, false]]

      make_figure(path, grid_mask, "cloth.wav")
    end


    def dau_tall_boots
      path = @figures_folder_path + "pink_tall_boots.png"
      grid_mask = [[true, true],
                   [true, false],
                   [true, false],]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def wif_hat
      path = @figures_folder_path + "red_hat.png"
      grid_mask = [[true, true, true],
                   [false, true, false]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def wif_shoes
      path = @figures_folder_path + "red_shoes.png"
      grid_mask = [[false, true, true],
                   [true, true, false]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def wif_tall_boots
      path = @figures_folder_path + "red_tall_boots.png"
      grid_mask = [[true, true],
                   [true, false],
                   [true, false],]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def steam_gen
      path = @figures_folder_path + "steam_gen.png"
      grid_mask = [[true, true],
                   [true, false]]

      make_figure(path, grid_mask, "menu.wav")
    end


    def towel
      path = @figures_folder_path + "towel.png"
      grid_mask = [[true, true, true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def yoga_carpet
      path = @figures_folder_path + "yoga_carpet.png"
      grid_mask = [[true, true, true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def wif_cloth
      path = @figures_folder_path + "wif_cloth.png"
      grid_mask = [[true, true],
                   [true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def antifreez
      path = @figures_folder_path + "antifreez.png"
      grid_mask = [[true]]

      make_figure(path, grid_mask, "door.wav")
    end

    def domcrat
      path = @figures_folder_path + "domcrat.png"
      grid_mask = [[false, true],
                   [true, true],
                   [false, true],]

      make_figure(path, grid_mask, "menu.wav")
    end

    def extinguisher
      path = @figures_folder_path + "extinguisher.png"
      grid_mask = [[false, true]]

      make_figure(path, grid_mask, "menu.wav")
    end

    def fomka
      path = @figures_folder_path + "fomka.png"
      grid_mask = [[true, true],
                   [true, false ]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def gray_bag
      path = @figures_folder_path + "gray_bag.png"
      grid_mask = [[true, true],
                   [true, true],
                   [true, true]]

      make_figure(path, grid_mask, "cloth.wav")
    end

    def hatch
      path = @figures_folder_path + "hatch.png"
      grid_mask = [[true, true],
                   [false, true]]

      make_figure(path, grid_mask, "menu.wav")
    end

    def pink_bag
      path = @figures_folder_path + "pink_bag.png"
      grid_mask = [[true, true, true],
                   [true, true, true],
                   [true, true, true]]

      make_figure(path, grid_mask,  "cloth.wav")
    end

    def ski
      path = @figures_folder_path + "ski.png"
      grid_mask = [[true, true, true, true]]

      make_figure(path, grid_mask, "door_1.wav")
    end

    def snowboard
      path = @figures_folder_path + "snowboard.png"
      grid_mask = [[true],
                   [true],
                   [true],
                   [true]]

      make_figure(path, grid_mask, "door_1.wav")
    end

    def thermos
      path = @figures_folder_path + "thermos.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask, "door_1.wav")
    end

    private

    def make_figure(path, grid_mask, sound = "pop.wav")
      w = grid_mask[0].length * @cell_size
      h = grid_mask.length * @cell_size

      Figure.new(w: w, h: h, path: path, grid_mask: grid_mask, cell_size: @cell_size, sound: sound)
    end
  end
end
