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

      make_figure(path, grid_mask)
    end

    def hus_cloth
      path = @figures_folder_path + "hus_cloth.png"
      grid_mask = [[true, true], [true, true]]

      make_figure(path, grid_mask)
    end

    def son_cloth
      path = @figures_folder_path + "son_cloth.png"
      grid_mask = [[true, true], [true, true]]

      make_figure(path, grid_mask)
    end

    def penal_blue
      path = @figures_folder_path + "penal_blue.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask)
    end

    def penal_son
      path = @figures_folder_path + "penal_son.png"
      grid_mask = [[true, true]]

      make_figure(path, grid_mask)
    end

    private

    def make_figure(path, grid_mask)
      w = grid_mask[0].length * @cell_size
      h = grid_mask.length * @cell_size

      Figure.new(w: w, h: h, path: path, grid_mask: grid_mask, cell_size: @cell_size)
    end
  end
end
