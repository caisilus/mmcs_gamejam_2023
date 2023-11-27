require "app/requirements"

def tick args
  args.state.tetramino_level_factory ||= Tetramino::LevelFactory.new(args)

  args.state.scenes ||= { main_menu: MainMenuScene.new(args), solitaire: SolitaireScene.new(args),
                          tetramino1: args.state.tetramino_level_factory.build(1),
                          memo1: MemoryCardGame.new(args, cards_per_row: 3, cards_per_column: 2, level: 1),
                          memo2: MemoryCardGame.new(args, cards_per_row: 4, cards_per_column: 3, level: 2 )
                        }

  args.state.scene_manager ||= SceneManager.new(args.state.scenes, :tetramino1, queue: [:memo1, :memo2, :tetramino, :solitaire])

  args.state.scene_manager.tick args
end
