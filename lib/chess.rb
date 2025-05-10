# frozen_string_literal: true

require 'colorize'
Dir[File.join(__dir__, 'pieces', '*.rb')].sort.each { |file| require file }
require_relative 'chess/chess_pieces'

require_relative 'chess/board'
require_relative 'chess/game'
require_relative 'chess/player_input'

module Chess # rubocop:disable Style/Documentation
  def self.start # rubocop:disable Metrics/MethodLength
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

  def self.load_saved_game
    save_load = SaveLoad.new
    game = save_load.load_game

    if game
      pus 'Game Loaded.'
      game.play_game
    else
      puts 'No saved file found, starting new game instead.'
      start_new_game
    end
  end
end
