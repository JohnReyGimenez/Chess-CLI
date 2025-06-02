# frozen_string_literal: true

require_relative 'player_input'
require_relative 'save_load'

module Chess
  # game loop, turn tracking
  class Game
    def initialize
      @board = Board.new
      @board.set_up_board
      @renderer = BoardRenderer.new(@board)
      @current_player_color = :white
      # captured pieces
      @captured = { white: [], black: [] }
    end

    def play_game
      turn = 1
      loop do
        system('clear')                    # clears terminal
        @renderer.render                   # renders the current board state
        display_turn_info(turn, @current_player_color)

        # checks for game end conditions
        if @board.checkmate?(@current_player_color)
          puts "#{@current_player_color.capitalize} is checkmated! Game over."
          break
        elsif @board.stalemate?(@current_player_color)
          puts "Stalemate! It's a draw."
          break
        end

        # prompts and parses player move
        move_input = ask_for_move
        break if move_input == 'exit'

        if move_input == :save
          SaveLoad.new.save_game(self) # Save the entire Game object
          puts 'Game saved. Exiting.'
          break
        end

        # handles castling separately
        if move_input.start_with?('castle')
          handle_castling(move_input)
          puts '[DEBUG] Move succeeded. Piece moved. Switching turns.'
          turn += 1
          switch_players
          next
        end

        # parse and validate
        from, to = parse_move(move_input)
        puts "[DEBUG] Input: #{move_input}"
        puts "[DEBUG] Parsed from: #{from.inspect}, to: #{to.inspect}"
        puts "[DEBUG] Is move valid? #{valid_move?(from, to)}"

        puts "Parsed move: from=#{from.inspect}, to=#{to.inspect}" # 👈 TESTT
        puts "Valid? #{valid_move?(from, to)}"

        if from && to && valid_move?(from, to)
          @board.move_piece_to(from, to)
          puts "Moved piece from #{from} to #{to}" # TESTING FOR NOW!!
          check_promotion(to)
          puts '[DEBUG] Move succeeded. Piece moved. Switching turns.'
          turn += 1
          switch_players
        else
          puts 'Invalid move. Try again.'
        end
      end
    end

    def display_turn_info(turn_number, current_player)
      puts "\nTurn #{turn_number}  #{current_player.capitalize}'s move"
      puts '─' * 45
      puts "> Move using notation: e.g. 'e2e4'"
      puts "> Castle with: 'castle k' or 'castle q'"
      puts "> Type 'exit' to quit."
      puts
    end

    def ask_for_move
      puts "\nEnter your move (e.g. 'e2e4', 'castle k', or 'exit')"
      Chess::PlayerInput.get_move
    end

    def castle(color, side)
      # later: Add logic for king and rook movement, safety checks, etc.
      puts "#{color.capitalize} castled #{side == 'k' ? 'kingside' : 'queenside'}."
    end

    def capture_piece(color, captured_piece)
      opponent = color == :white ? :black : :white
      @captured[color] ||= [] # Init array if needed
      @captured[color] << captured_piece if captured_piece.color == opponent
    end

    def valid_move?(from, to)
      piece = @board[from]
      return false unless piece # no piece at that location
      return false unless piece.color == @current_player_color

      piece.legal_moves(@board).include?(to)
    end

    def switch_players
      @current_player_color = @current_player_color == :white ? :black : :white
    end

    def parse_position(str)
      col_map = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7 }
      return nil unless str.length == 2 && col_map.key?(str[0]) && str[1].to_i.between?(1, 8)

      row = 8 - str[1].to_i
      col = col_map[str[0]]
      [row, col]
    end

    def parse_move(input)
      input = input.strip.downcase
      return nil unless input.length == 4

      from = input[0..1]
      to = input[2..3]
      [parse_position(from), parse_position(to)]
    end

    def check_promotion(to)
      piece = @board.piece_at(to)
      return unless piece.is_a?(Pawn)
      return unless (piece.color == :white && to[0] == 0) || (piece.color == :black && to[0] == 7)

      puts 'Promote pawn to (Q, R, B, N):'
      choice = gets.chomp.upcase
      new_piece = case choice
                  when 'Q' then Queen.new(piece.color, to)
                  when 'R' then Rook.new(piece.color, to)
                  when 'B' then Bishop.new(piece.color, to)
                  when 'N' then Knight.new(piece.color, to)
                  else Queen.new(piece.color, to)
                  end
      @board.place_piece(to, new_piece)
    end

    def handle_castling(input)
      side = input.split.last.downcase
      if @board.can_castle?(@current_player_color, side)
        @board.perform_castling(@current_player_color, side)
        puts "#{@current_player_color.capitalize} castled #{side == 'k' ? 'kingside' : 'queenside'}."
      else
        puts 'Castling not allowed.'
      end
    end

    def self.load_game
      if File.exist?('save_file.sav')
        puts 'Loading saved game...'
        YAML.load_file('save_file.sav')
      else
        puts 'No save file found. Starting a new game.'
        Game.new
      end
    end
  end
end
