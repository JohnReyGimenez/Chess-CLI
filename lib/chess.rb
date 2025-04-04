# frozen_string_literal: true

require_relative 'chess/board'
require_relative 'chess/game'

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
end
