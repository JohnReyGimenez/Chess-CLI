# frozen_string_literal: true

require_relative 'chess/board/board'
require_relative 'chess/board/board_renderer'
require_relative 'chess/game'
require_relative 'chess/game_logic'
require_relative 'chess/chess_pieces'
require_relative 'chess/player_input'

module Chess
  def self.start
    puts 'Welcome to Chess'
    puts '1. Start new game'
    puts '2. Load game'
    choice = gets.chomp.to_i

    case choice
    when 1
      start_new_game
    when 2
      load_saved_game
    else
      puts 'Invalid choice. Exiting.'
    end
  end

  def self.start_new_game
    game = Game.new
    game.play_game
  end
end
