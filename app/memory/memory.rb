$gtk.reset

class MemoryCardGame < Scene
    attr_reader :matched_pairs, :card_width, :card_height, :card_spacing, :cards_per_row, :cards_per_column, :game_over

    def initialize(args, cards_per_row:, cards_per_column:, level:)
      super(args)
      @level = level
      @cards = generate_card_images(cards_per_row * cards_per_column)
      @cards.shuffle!
      @revealed_cards = []
      @matched_pairs = 0
      @selected_card = nil
      @card_width = 200
      @card_height = 200
      @card_spacing = 20
      @cards_per_row = cards_per_row
      @cards_per_column = cards_per_column
      @game_over = false
    end

    def generate_card_images(num_cards)
      card_images = []
      card_filenames = (1..num_cards / 2).map { |num| "sprites/memo/level#{@level}/#{num}.png" }

      card_filenames.each do |filename|
        card_images << filename
        pair = pair_filename(filename)
        card_images << pair
      end

      card_images.shuffle
    end

    def pair_filename(filename)
      name, ext = filename.split(".")
      name += "_pair"

      name + "." + ext
    end

    def draw_background
      $gtk.args.outputs.solids << [0, 0, $gtk.args.grid.w, $gtk.args.grid.h, 226, 174, 168]
    end

    def draw
      @cards.each_with_index do |card, index|
        draw_card(index, card)
      end
    end

    def handle_input(x, y)
      return if @game_over

      args.outputs.sounds << "sounds/fold.wav"
      clicked_card = find_clicked_card(x, y)

      return if clicked_card.nil?

      card_index = clicked_card[:index]

      if !@revealed_cards.include?(card_index) && @selected_card.nil?
        @selected_card = card_index
      elsif !@revealed_cards.include?(card_index) && !@selected_card.nil?
        handle_card_selection(card_index)
      end
    end

    def update
      return if @game_over

      if @matched_pairs == (@cards.length / 2)
        @game_over = true
      end
    end

    private

    def draw_card(index, card)
      row, col = index.divmod(@cards_per_row)

      x = ($gtk.args.grid.center_x - (@cards_per_row * (@card_width + @card_spacing)) / 2) + col * (@card_width + @card_spacing)
      y = ($gtk.args.grid.center_y - (@cards_per_column * (@card_height + @card_spacing)) / 2) + row * (@card_height + @card_spacing)


      draw_face = @revealed_cards.include?(index) || index == @selected_card
      draw_card_back(x, y) unless draw_face
      draw_card_face(x, y, card) if draw_face
    end

    def draw_card_back(x, y)
      back_image = "sprites/memo/level#{@level}/back.png"
      $gtk.args.outputs.sprites << [x, y, @card_width, @card_height, back_image, 0]
    end

    def draw_card_face(x, y, card)
      $gtk.args.outputs.sprites << [x, y, @card_width, @card_height, card, 0]
    end

    def handle_card_selection(card_index)
      if cards_match?(@cards[@selected_card], @cards[card_index])
        @matched_pairs += 1
        @revealed_cards.concat([@selected_card, card_index])
      else
        handle_mismatched_cards(card_index)
      end
      @selected_card = nil
    end

    def cards_match?(card1, card2)
      card1 == pair_filename(card2) || card2 == pair_filename(card1)
    end

    def handle_mismatched_cards(card_index)
      $gtk.scheduled_callbacks.clear
      $gtk.args.gtk.schedule_callback(500) do
        @selected_card = nil
        @revealed_cards.delete(card_index)
        @revealed_cards.delete(@selected_card)
      end
    end

    def find_clicked_card(x, y)
      @cards.each_with_index do |_, index|
        row, col = index.divmod(@cards_per_row)

        card_x = ($gtk.args.grid.center_x - (@cards_per_row * (@card_width + @card_spacing)) / 2) + col * (@card_width + @card_spacing)
        card_y = ($gtk.args.grid.center_y - (@cards_per_column * (@card_height + @card_spacing)) / 2) + row * (@card_height + @card_spacing)

        card_rect = {
          x: card_x,
          y: card_y,
          w: @card_width,
          h: @card_height,
        }

        mouse_rect = {
          x: x,
          y: y,
          w: 1,
          h: 1,
        }

        return { index: index, loc: card_rect } if mouse_rect.intersect_rect?(card_rect)
      end

      nil
    end


    def tick(args)
      super(args)

      draw_background
      if args.inputs.mouse.click
        handle_input(args.inputs.mouse.x, args.inputs.mouse.y)
        update
      end

      args.outputs.labels << [10, 690, "Matched Pairs: #{matched_pairs}"]

      if game_over
        args.state.scene_manager.next_level(args)
      else
        draw
      end
    end
  end

