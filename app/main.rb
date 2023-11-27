require "app/requirements"

def tick args
  args.state.scenes ||= { main_menu: MainMenuScene.new(args), solitaire: SolitaireScene.new(args),
                          tetramino: TetraminoScene.new(args),
                          memo1: MemoryCardGame.new(args, cards_per_row: 3, cards_per_column: 2, level: 1),
                          memo2: MemoryCardGame.new(args, cards_per_row: 4, cards_per_column: 3, level: 2 ),
                          credit: CreditsScene.new(args)
                        }

  args.state.scene_manager ||= SceneManager.new(args.state.scenes, :main_menu, queue: [:memo1, :memo2, :tetramino, :solitaire, :credit])

  if args.state.tick_count == 1
    args.audio[:music] = { input: "sounds/ambient.wav", looping: true }
  end

  args.state.scene_manager.tick args
end
